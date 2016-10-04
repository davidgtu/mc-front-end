module Shared
  module PhotosHelper
    def photo_image_tag_for(photo, size:, **options)
      if photo.present?
        url = photo.asset.url(size)
        options.merge!(alt: photo.alt_text)
      else
        url = "shared/photos/missing-#{size}.png"
        options.merge!(alt: nil)
      end

      options.merge!(class: ["photo photo-#{size}", options[:class]].compact)

      image_tag url, options
    end
  end
end
