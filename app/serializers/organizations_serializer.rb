class OrganizationsSerializer
  include JSONAPI::Serializer
  attributes :name, :email
end
