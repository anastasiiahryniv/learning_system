class Student < ApplicationRecord
  # Constants
  MAX_NAME_LENGTH = 50

  # Associations
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments

  # Validations
  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }
  validates :surname, presence: true, length: { maximum: MAX_NAME_LENGTH }
  validates :email, uniqueness: true, presence: true

  # Enrollments
  enum status: {}
end
