class Student < ApplicationRecord
  include Authenticatable
  include Avatarable

  # Associations
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
end
