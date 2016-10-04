module Store
  class CheckoutsFormBuilder < ActionView::Helpers::FormBuilder
    class State
      include ActiveModel::Model
      attr_accessor :name
      attr_accessor :code
    end

    def format_arrival_date(shipping_quote)
      shipping_quote.arrival_date.strftime('%A, %B %d')
    end

    def shipping_quote_radio_button(shipping_quote)
      checked = (shipping_quote.shipping_method.id == object.shipping_method_id)
      radio_button(:shipping_method_id, shipping_quote.shipping_method.id, checked: checked)
    end

    def shipping_quote_label(shipping_quote, &block)
      label(:shipping_method_id, value: shipping_quote.shipping_method.id, &block)
    end

    def inverted_check_box(method)
      check_box method, { checked: !object.public_send(method) }, 0, 1
    end

    def country_select(method, html_options)
      options = { selected: object.country }
      collection_select(method, Address::SUPPORTED_COUNTRIES, :alpha2, :name, options, html_options)
    end

    def state_select(method, html_options)
      country = ISO3166::Country.new(object.country)
      states = country.states.map do |code, state|
        State.new(code: code, name: state['name'])
      end

      states = states.sort { |a, b| a.name <=> b.name }

      options = {
        prompt: I18n.t('checkout.select_state'),
        selected: object.state
      }

      collection_select(method, states, :code, :name, options, html_options)
    end
  end
end
