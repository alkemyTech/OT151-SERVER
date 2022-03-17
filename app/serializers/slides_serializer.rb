# frozen_string_literal: true

class SlidesSerializer
  include JSONAPI::Serializer
  attributes :order
  attribute :image do |object|
    return object.image_url if Rails.env.production?

    if Rails.env.development? || Rails.env.test?
      ActiveStorage::Blob.service.path_for(object.image.key)
    end
  end
end
