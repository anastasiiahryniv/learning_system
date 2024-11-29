class Course < ApplicationRecord
  # Pagination
  paginates_per 15

  # Constants
  MAX_COURSE_NAME_LENGTH = 100
  MAX_DESCRIPTION_LENGTH = 500

  # Associations
  belongs_to :instructor
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments, counter_cache: true

  has_many :taggables, dependent: :destroy
  has_many :tags, through: :taggables

  # Validations
  validates :name, presence: true, length: { maximum: MAX_COURSE_NAME_LENGTH }
  validates :description, length: { maximum: MAX_DESCRIPTION_LENGTH }

  # Enrollments
  enum status: { draft: 10, active: 20, inactive: 30 }

  after_create :set_status

  def self.ransackable_attributes(auth_object = nil)
    %w[created_at description id instructor_id name status updated_at students_count]
  end

  def self.ransackable_associations(auth_object = nil)
    %w[enrollments instructor students]
  end

  private

  def set_status
    update(status: :inactive)
  end
end
