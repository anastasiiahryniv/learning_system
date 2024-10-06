class Student < ApplicationRecord
  include Authenticatable
  # Associations
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
end
