module Shared
  module IconHelper
    def icon_tag(name, **options)
      options.merge!(class: ['material-icons', options[:class]].compact)
      content_tag :i, name.html_safe, **options
    end

    def social_icon_tag(name, **options)
      options.merge!(class: ['mono-social-icons', options[:class]].compact)
      content_tag :i, name.html_safe, **options
    end
  end
end
