class Enrollment < ApplicationRecord
  paginates_per 15

  # Constants
  MAX_GRADE = 10
  MIN_GRADE = 0

  # Associations
  belongs_to :student
  belongs_to :course, counter_cache: :students_count

  # Validations
  validates :grade, presence: true,
                    numericality: { only_integer: true,
                                    greater_than_or_equal_to: MIN_GRADE,
                                    less_than_or_equal_to: MAX_GRADE }

  # Enrollments
  enum status: { draft: 10, active: 20, inactive: 30, pending: 40 }

  after_initialize :set_default_grade, if: :new_record?
  after_initialize :set_pending_status, if: :new_record?

  private

  def set_default_grade
    self.grade ||= 0
  end

  def set_pending_status
    self.status = :pending
  end
end
