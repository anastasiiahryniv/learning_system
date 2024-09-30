class Course < ApplicationRecord
  belongs_to :instructor, class_name: 'Instructor'
  has_many :enrollments, dependent: :destroy
  has_many :students, through: :enrollments

  validates :name, presence: true
end
