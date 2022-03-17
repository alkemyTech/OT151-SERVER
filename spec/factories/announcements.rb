# frozen_string_literal: true

# == Schema Information
#
# Table name: announcements
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  discarded_at :datetime
#  name         :string           not null
#  type         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  category_id  :bigint           not null
#
# Indexes
#
#  index_announcements_on_category_id   (category_id)
#  index_announcements_on_discarded_at  (discarded_at)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#
FactoryBot.define do
  factory :announcement do
    name { Faker::TvShows::BreakingBad.character }
    content { Faker::Books::Lovecraft.sentence }
    type { Faker::Lorem.word }
    association :category

    trait :discarded do
      discarded_at { rand(1..1_000_000).days.ago }
    end

    trait :with_image do
      after :create do |announcement|
        file_path = Rails.root.join('spec', 
          'factories_files', 'test.png'), 'image/png'
          file = fixture_file_upload(file_path, 'image/png')
          announcement.image.attach(file)
        end
      end
  end
end
