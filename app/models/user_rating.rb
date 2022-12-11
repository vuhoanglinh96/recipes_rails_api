class UserRating < ApplicationRecord
  belongs_to :user
  belongs_to :recipe

  validates :star,
            numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }, presence: true
  validates :recipe, uniqueness: { scope: :user }
end
