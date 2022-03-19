# == Schema Information
#
# Table name: comments
#
#  id              :bigint           not null, primary key
#  body            :text             not null
#  discarded_at    :datetime
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  announcement_id :bigint           not null
#  user_id         :bigint           not null
#
# Indexes
#
#  index_comments_on_announcement_id  (announcement_id)
#  index_comments_on_discarded_at     (discarded_at)
#  index_comments_on_user_id          (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (announcement_id => announcements.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :comment do
    body { Faker::FunnyName.two_word_name }
    user
    announcement
  end
end
