class Course < ApplicationRecord
  # Constants
  MAX_NAME_LENGTH = 100
  MAX_DESCRIPTION_LENGTH = 500

  # Associations
  belongs_to :instructor
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  # Validations
  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }
  validates :description, length: { maximum: MAX_DESCRIPTION_LENGTH }

  # Enrollments
  enum status: { draft: 10, active: 20, inactive: 30 }
end
