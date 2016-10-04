module Store
  module CheckoutsHelper
    HIDDEN_STEPS = [
      :complete,
      :paypal_billing_details
    ]

    HIDDEN_TITLE = [
      :multi_arrival_date
    ]

    UNMODIFIABLE_STEPS = [
      :account_details,
      :complete,
      :paypal_billing_details,
      :paypal_token
    ]

    def checkout_form(object, **options, &block)
      options.merge!(
        url: wizard_path,
        method: :put,
        as: :checkout,
        builder: Store::CheckoutsFormBuilder
      )
      form_for(object, options, &block)
    end

    def step_completed?(furthest_step, step)
      step_index = wizard_steps.index { |s| s.to_sym == step.to_sym }
      furthest_step ||= wizard_steps.first
      furthest_step_index = wizard_steps.index { |s| s.to_sym == furthest_step.to_sym }
      step_index < furthest_step_index
    end

    def hidden_step?(step)
      HIDDEN_STEPS.include?(step.name.to_sym)
    end

    def hidden_title?(step)
      HIDDEN_TITLE.include?(step.name.to_sym)
    end

    def modifiable_step?(current_step, furthest_step, step)
      UNMODIFIABLE_STEPS.exclude?(step.to_sym) && step_completed?(furthest_step, step) && current_step != step
    end

    def select_exp_month(html_options = {})
      select_month(13, { prompt: I18n.t(:month) }, html_options.merge({ id: :expiration_month }))
    end

    def select_exp_year(html_options = {})
      collection_select(
        :payment,
        :expiration_year,
        Date.today.year..Date.today.year+15,
        :itself,
        :itself,
        { prompt: I18n.t(:year) },
        html_options
      )
    end

    def address_summary(address)
      address_tag(address, :one_line)
    end

    def arrival_date_summary(step)
      return '' if step.shipping_method.nil?

      [
        step.selected_shipping_quote.arrival_date.strftime('%A, %B %e'),
        I18n.t(:via),
        step.shipping_method.carrier,
        step.shipping_method.service
      ].join(' ')
    end

    def step_summary(step)
      case step.name
      when :arrival_date, :multi_arrival_date
        arrival_date_summary(step)
      when :shipping_address, :multi_shipping_address
        address_summary(step.shipping_address)
      when :billing_address
        address_summary(step.billing_address)
      end
    end

    def step_title(step)
      case step.name
      when :multi_shipping_address
        "#{I18n.t('checkout.shipment.title')} \##{step.line_item_index + 1}"
      else
        I18n.t("checkout.#{step.name}.title")
      end
    end

    # Iterate through all the checkout panels visible to the user. Skip hidden
    # steps, and don't assign a user-visible step number/index to steps with a
    # hidden title bar.
    def checkout_panels
      index = 0
      wizard_steps.each do |step|
        if hidden_step?(step)
          # Skip this step entirely
        else
          index += 1 unless hidden_title?(step)
          yield step, index
        end
      end
    end
  end
end
