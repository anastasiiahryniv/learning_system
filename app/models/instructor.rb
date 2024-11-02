class Instructor < ApplicationRecord
  include Authenticatable
  # Associations
  has_many :courses, dependent: :destroy
  # Roles
  enum role: { instructor: 'instructor', instructor_admin: 'instructor_admin' }
end
