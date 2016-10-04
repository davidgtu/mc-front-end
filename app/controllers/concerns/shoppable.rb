module Shoppable
  extend ActiveSupport::Concern
  included do
    before_action :set_categories

    helper Store::CartsHelper
    helper Store::CheckoutsHelper
    helper Store::ProductsHelper
    helper Store::RatingsHelper

  end

  def set_categories
    @categories = %w(Drinking Grilling Personalized Outdoor Sports More AllGifts Eating)
  end
end
