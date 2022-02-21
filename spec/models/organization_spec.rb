# frozen_string_literal: true

# == Schema Information
#
# Table name: organizations
#
#  id            :bigint           not null, primary key
#  about_us_text :string
#  address       :string
#  discarded_at  :datetime
#  email         :string           not null
#  image_url     :string
#  name          :string           not null
#  phone         :integer
#  welcome_text  :text             not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_organizations_on_discarded_at  (discarded_at)
#  index_organizations_on_email         (email) UNIQUE
#
require 'rails_helper'

RSpec.describe Organization, type: :model do
  describe 'soft delete' do
    context 'with an undiscarded Organization' do
      subject(:target) { create(:target) }

      it 'is included in the default scope' do
        expect(described_class.all).to eq([target])
      end

      it 'is included in kept scope' do
        expect(described_class.kept).to eq([target])
      end

      it 'is included in undiscarded scope' do
        expect(described_class.undiscarded).to eq([target])
      end

      it 'is not included in discarded scope' do
        expect(described_class.discarded).to eq([])
      end
    end

    context 'with discarded Organization' do
      subject(:target) { create(:target, :discarded) }

      it 'is included in the default scope' do
        expect(described_class.all).to eq([target])
      end

      it 'is not included in kept scope' do
        expect(described_class.kept).to eq([])
      end

      it 'is not included in undiscarded scope' do
        expect(described_class.undiscarded).to eq([])
      end

      it 'is included in discarded scope' do
        expect(described_class.discarded).to eq([target])
      end
    end
  end

  describe 'validations' do
    subject(:target) { create(:target) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(2) }
    it { is_expected.to validate_presence_of(:welcome_text) }
    it { is_expected.to validate_length_of(:welcome_text).is_at_least(2) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to allow_value(Faker::Internet.email).for(:email) }
    it { is_expected.not_to allow_value('example.mail.com').for(:email) }
    it { is_expected.not_to allow_value('@example.mail').for(:email) }
    it { is_expected.not_to allow_value('').for(:email) }
  end
end
