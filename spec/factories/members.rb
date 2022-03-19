# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id            :bigint           not null, primary key
#  description   :text
#  discarded_at  :datetime
#  facebook_url  :string
#  instagram_url :string
#  linkedin_url  :string
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_members_on_discarded_at  (discarded_at)
#
FactoryBot.define do
  factory :member do
    name { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    facebook_url { Faker::Internet.url(host: 'facebook.com') }
    instagram_url { Faker::Internet.url(host: 'instagram.com') }
    linkedin_url { Faker::Internet.url(host: 'linkedin.com', path: '/in') }
    after(:build) do |member|
      member.image.attach(
        io: File.open(Rails.root.join('spec/factories_files/user_icon.jpeg')),
        filename: 'user_icon.jpeg',
        content_type: 'image/jpeg'
      )
    end
  end
end
