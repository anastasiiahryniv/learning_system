class Enrollment < ApplicationRecord
  # Constants
  MAX_NAME_LENGTH = 50
  MAX_GRADE = 10
  MIN_GRADE = 1

  # Associations
  belongs_to :student
  belongs_to :course

  # Validations
  validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }
  validates :grade, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: MIN_GRADE,
                                    less_than_or_equal_to: MAX_GRADE }

  # Enrollments
  enum status: { draft: 10, active: 20, inactive: 30 }
end