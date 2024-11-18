class Tag < ApplicationRecord
  has_many :taggables, dependent: :destroy
  has_many :courses, through: :taggables

  validates :name, presence: true
end
