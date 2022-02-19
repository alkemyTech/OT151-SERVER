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
FactoryBot.define do
  factory :user do
    first_name { 'example name' }
    last_name { 'examplelastname' }
    password { 'example password' }
    email { 'example@email.com' }
  end
end
