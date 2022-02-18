# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  about_us_text :string
#  address       :string
#  discarded_at  :datetime
#  email         :string           not null
#  image_url     :string
#  name          :string           not null
#  phone         :integer
#  welcome_text  :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_organizations_on_discarded_at  (discarded_at)
#  index_organizations_on_email         (email) UNIQUE
#
FactoryBot.define do
  factory :organization do
    name { "MyString" }
    address { "MyString" }
    phone { 1 }
    email { "MyString" }
    welcome_text { "MyText" }
    about_us_text { "MyString" }
    image_url { "MyString" }
  end
end
