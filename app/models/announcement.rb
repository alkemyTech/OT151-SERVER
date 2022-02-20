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
class Announcement < ApplicationRecord
  include Discard::Model
  validates :name, presence: true, length: { minimum: 3 }
  validates :content, presence: true, length: { minimum: 3 }
  validates :image_url, presence: true,
                        length: { minimum: 3 }
  # :image_url does not allow blank spaces, in any position of the string
  validates :image_url, format: { without: /\s/, message: 'must contain no spaces' }
end
