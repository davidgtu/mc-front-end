module Shared
  module AddressHelper
    # Formats an address for display.
    #
    # @example Formatting a full address
    #   address_tag(address, :full)
    #
    # Output:
    #   <div>
    #     Mr. Picov Andropov</br>
    #     123 Main Street</br>
    #     Apt 5</br>
    #     Waynesboro, VA 11234</br>
    #     United States
    #   </div>
    #
    # @example Formatting a short address
    #   address_tag(address, :short)
    #
    # Output:
    #   <div>
    #     123 Main Street, Apt 5</br>
    #     Waynesboro, VA 11234, United States
    #   </div>
    #
    # @example Formatting an address as a single line
    #
    # Output:
    #   <div>
    #     123 Main Street, Apt 5, Wanynesboro, VA 11234, United States
    #   </div>
    #
    def address_tag(address, style, options={})
      case style.to_sym
      when :full
        full_address_tag(address, options)
      when :short
        short_address_tag(address, options)
      when :one_line
        one_line_address_tag(address, options)
      end
    end

    private

    def full_address_tag(address, options)
      content_tag(:div, options) do
        concat address.full_name
        concat tag(:br)
        concat address.address_1
        concat tag(:br)

        if address.address_2.present?
          concat address.address_2
          concat tag(:br)
        end

        concat "#{address.city}, #{address.state} #{address.zip}"
        concat tag(:br)
        concat address.country_full_name
      end
    end

    def short_address_tag(address, options)
      content_tag(:div, options) do
        concat [address.address_1, address.address_2].reject(&:blank?).join(', ')
        concat tag(:br)
        concat "#{address.city}, #{address.state} #{address.zip}, #{address.country_full_name}"
      end
    end

    def one_line_address_tag(address, options)
      lines = [
        address.address_1,
        address.address_2,
        address.city,
        "#{address.state} #{address.zip}",
        address.country_full_name
      ]
      content_tag(:div, options) do
        concat lines.reject(&:blank?).join(', ')
      end
    end
  end
end
