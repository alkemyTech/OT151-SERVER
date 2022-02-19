# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  email        :string           not null
#  first_name   :string           not null
#  last_name    :string           not null
#  password     :string           not null
#  photo        :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_discarded_at  (discarded_at)
#
class User < ApplicationRecord
  # include app/models/concerns/deletable.rb helper
  include Discard::Model
  has_one :role, dependent: :destroy

  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }, presence: true, uniqueness: true

  validates :last_name, presence: true,
                       length: { in: 2..15 }

  validates :first_name, presence: true,
                        length: { in: 2..15 }

  validates :password, presence: true,
                       length: { minimum: 6 }
end
