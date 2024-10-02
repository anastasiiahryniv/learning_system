class Instructor < ApplicationRecord
  # Constants
  MAX_NAME_LENGTH = 50

  # Associations
  has_many :courses, dependent: :destroy

  # Validations
  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }
  validates :surname, presence: true, length: { maximum: MAX_NAME_LENGTH }
  validates :email, uniqueness: true, presence: true

  # Enrollments
  enum status: { pending: 10, active: 20, inactive: 30 }
end
