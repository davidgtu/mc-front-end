module Shared
  module MoneyHelper
    # Bypasses format call for RubyMoney object if it is nil.
    def price_for(monetizable)
      monetizable&.price ? monetizable.price.format : 'n/a'
    end
  end
end
