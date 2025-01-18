class Student < ApplicationRecord
  include Authenticatable
  include Avatarable
  include FullNameable

  # Associations
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :comments, dependent: :destroy
end
