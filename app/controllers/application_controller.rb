class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout 'store'

  helper Shared::AddressHelper
  helper Shared::DateHelper
  helper Shared::IconHelper
  helper Shared::JbuilderHelper
  helper Shared::LiquidHelper
  helper Shared::MoneyHelper
  helper Shared::NameFormatHelper
  helper Shared::PhotosHelper

  helper_method :view_name

  def view_name
    "#{controller_name}/#{action_name}"
  end
end
