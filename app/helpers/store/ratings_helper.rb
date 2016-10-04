module Store
  module RatingsHelper
    def star_rating_for(product, readonly: true)
      hidden_field_tag nil, product.rating, class: 'stars', data: { js_hook: 'rating' }, disabled: readonly
    end
  end
end
