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
require 'rails_helper'

RSpec.describe User, type: :model do
  # testing discard gem
  let(:user) do
    FactoryBot.create(:user)
  end

  describe '#discard' do
    subject(:discard) { user.discard }

    it 'sets the discarded_at attribute' do
      expect { discard }.to change(user, :discard).from(true)
    end
  end

  context 'with invalid attributes' do
    it 'returns failure when email is missing' do
      user = build(:user, email: '')
      expect(user).not_to be_valid
    end

    it 'returns failure when email format is wrong' do
      user = build(:user, email: 'thisisnotanemail')
      expect(user).not_to be_valid
    end

    it 'returns failure when email already exists in db' do
      user = build(:user, email: 'original@email.com').save
      user2 = build(:user, email: 'original@email.com')
      expect(user2).not_to be_valid
    end

    it 'returns failure when first name is missing' do
      user = build(:user, first_name: '')
      expect(user).not_to be_valid
    end

    it 'returns failure when first name exceeds length' do
      user = build(:user, first_name: 'sixteencharacter')
      expect(user).not_to be_valid
    end

    it "returns failure when first name doesn't reach min lenght" do
      user = build(:user, first_name: '1')
    end

    it 'returns failure when last name is missing' do
      user = build(:user, last_name: '')
      expect(user).not_to be_valid
    end

    it 'returns failure when last name exceeds length' do
      user = build(:user, last_name: 'sixteencharacter')
      expect(user).not_to be_valid
    end

    it "returns failure when last name doesn't reach min lenght" do
      user = build(:user, last_name: '1')
    end

    it 'returns failure when password is missing' do
      user = build(:user, password: '')
    end

    it "returns failure when password doesn't reach min length" do
      user = build(:user, password: '123')
    end
  end
end
