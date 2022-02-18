class OrganizationSerializer
  include JSONAPI::Serializer
  attributes :name, :address, :phone, :email, :welcome_text, :about_us_text, :image_url
end
