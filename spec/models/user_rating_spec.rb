require 'rails_helper'

RSpec.describe UserRating, type: :model do
  let(:user_rating) do
    build(:user_rating)
  end

  describe 'Assocations' do
    it { is_expected.to belong_to(:recipe) }

    it { is_expected.to belong_to(:user) }
  end

  describe 'Valid subject' do
    it 'is valid user_rating' do
      expect(user_rating).to be_valid
    end
  end

  describe 'Invalid length validations' do
    it 'is invalid greater than / equal to value' do
      user_rating.star = -10.0
      expect(user_rating).not_to be_valid
    end

    it 'is invalid less than / equal to value' do
      user_rating.amount = 7
      expect(user_rating).not_to be_valid
    end
  end

  describe 'Validate presence' do
    it { is_expected.to validate_presence_of(:star) }
  end
end
