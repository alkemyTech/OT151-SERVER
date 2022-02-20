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
#  index_users_on_email         (email) UNIQUE
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

  context 'with model, test validations' do
    context 'with attribute, validate presence' do
      it { is_expected.to validate_presence_of(:email) }
      it { is_expected.to validate_presence_of(:first_name) }
      it { is_expected.to validate_presence_of(:last_name) }
      it { is_expected.to validate_presence_of(:password) }
    end

    context 'with attribute, validate length' do
      it { is_expected.to validate_length_of(:first_name) }
      it { is_expected.to validate_length_of(:last_name) }
      it { is_expected.to validate_length_of(:password) }
    end
  end
end
