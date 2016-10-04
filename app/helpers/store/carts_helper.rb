module Store
  module CartsHelper
    include Shared::IconHelper

    GIFT_NOTE_SUGGESTIONS = [
      'Literally Anyone'
    ]

    def cart_link
      text = icon_tag('shopping_cart') + content_tag(:span, 'Cart', class: 'hidden-xs')
      link_to text.html_safe, '/cart'
    end

    def gift_note_suggestion_select(html_options = {})
      collection_select(
        :cart_item,
        :gift_note_suggestion,
        GIFT_NOTE_SUGGESTIONS,
        :itself,
        :itself,
        {},
        html_options
      )
    end
  end
end
