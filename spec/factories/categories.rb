# frozen_string_literal: true

# == Schema Information
#
# Table name: categories
#
#  id           :bigint           not null, primary key
#  description  :string
#  discarded_at :datetime
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_categories_on_discarded_at  (discarded_at)
#
FactoryBot.define do
  factory :category do
    name { Faker::FunnyName.two_word_name }
    description { Faker::Company.catch_phrase }

    trait :with_image do
      image do
        fixture_file_upload(Rails.root.join('/spec/factories_files/test.png'), 'image/png')
      end
    end
  end
end
