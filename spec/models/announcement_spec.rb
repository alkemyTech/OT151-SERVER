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
require 'rails_helper'

RSpec.describe Announcement, type: :model do
  # soft delete tests
  context 'an undiscarded Announcement' do
    let(:announcement) { create(:announcement) }

    it 'is included in the default scope' do
      expect(Announcement.all).to eq([announcement])
    end

    it 'is included in kept scope' do
      expect(Announcement.kept).to eq([announcement])
    end

    it 'is included in undiscarded scope' do
      expect(Announcement.undiscarded).to eq([announcement])
    end

    it 'is not included in discarded scope' do
      expect(Announcement.discarded).to eq([])
    end
  end

  context 'discarded Post' do
    let(:discarded) { create(:discarded) }

    it 'is included in the default scope' do
      expect(Announcement.all).to eq([discarded])
    end

    it 'is not included in kept scope' do
      expect(Announcement.kept).to eq([])
    end

    it 'is not included in undiscarded scope' do
      expect(Announcement.undiscarded).to eq([])
    end

    it 'is included in discarded scope' do
      expect(Announcement.discarded).to eq([discarded])
    end
  end

  # validation test
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_least(3) }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to validate_length_of(:content).is_at_least(3) }
  it { is_expected.to validate_presence_of(:image_url) }
  it { is_expected.to validate_length_of(:image_url).is_at_least(3) }
  it { is_expected.not_to allow_value('string with empty spaces').for(:image_url) }
  it { is_expected.not_to allow_value(' ').for(:image_url) }
  it { is_expected.not_to allow_value(' string with empty spaces ').for(:image_url) }
end
