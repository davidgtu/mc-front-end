module Store
  module ProductsHelper
    def add_to_cart_path(cart)
      if cart.new_record?
        carts_path
      else
        cart_path(cart)
      end
    end

    def options_for_select_with_blank(options, blank: nil)
      default = [(blank || 'Select one'), '']
      selectables = options.unshift(default)
      options_for_select(selectables)
    end
  end
end
