class Recipe < ApplicationRecord
  include ConstantValidatable

  # jitera-anchor-dont-touch: relations

  has_many :ingredients, dependent: :destroy
  has_many :user_ratings, dependent: :destroy

  belongs_to :category

  belongs_to :user

  # jitera-anchor-dont-touch: enum
  enum difficulty: %w[easy normal challenging], _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :title, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :descriptions, length: { maximum: 65_535, minimum: 0, message: I18n.t('.out_of_range_error') },
                           presence: true

  validates :time, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :difficulty, presence: true

  accepts_nested_attributes_for :ingredients

  scope :search_by_title, ->(title) { where('title LIKE ?', "%#{title}%") if title.present? }
  scope :search_by_start_time, ->(start_time) { where('CAST(time AS UNSIGNED) >= CAST(? AS UNSIGNED)', start_time) if start_time.present? }
  scope :search_by_end_time, ->(end_time) { where('CAST(time AS UNSIGNED) <= CAST(? AS UNSIGNED)', end_time) if end_time.present? }
  scope :search_by_difficulty, ->(difficulty) { where(difficulty: difficulty) if difficulty.present? }

  def self.associations
    [:ingredients]
  end

  # jitera-anchor-dont-touch: reset_password

  class << self
  end
end
