# frozen_string_literal: true

# == Schema Information
#
# Table name: members
#
#  id            :bigint           not null, primary key
#  description   :text
#  discarded_at  :datetime
#  facebook_url  :string
#  instagram_url :string
#  linkedin_url  :string
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_members_on_discarded_at  (discarded_at)
#
require 'rails_helper'

RSpec.describe Member, type: :model do
  let(:member) do
    FactoryBot.create(:member)
  end

  describe '#discard' do
    it 'sets discarded_at' do
      expect do
        member.discard
      end.to change(member, :discarded_at)
    end

    it 'sets discarded_at in DB' do
      expect do
        member.discard
      end.to change { member.reload.discarded_at }
    end
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name) }
    it { is_expected.to validate_length_of(:description) }
  end
end
