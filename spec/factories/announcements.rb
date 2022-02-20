# frozen_string_literal: true

# == Schema Information
#
# Table name: announcements
#
#  id           :bigint           not null, primary key
#  content      :text             not null
#  discarded_at :datetime
#  image_url    :string           not null
#  name         :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_announcements_on_discarded_at  (discarded_at)
#
FactoryBot.define do
  factory :announcement do
    name { Faker::TvShows::BreakingBad.episode }
    content { Faker::Quote.famous_last_words }
    image_url { Faker::Internet.url }
  end
  factory :discarded, class: 'Announcement' do
    name { Faker::TvShows::BreakingBad.episode }
    content { Faker::Quote.famous_last_words }
    image_url { Faker::Internet.url }
    discarded_at { rand(1..1_000_000).days.ago }
  end
end
