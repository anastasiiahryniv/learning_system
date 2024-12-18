class Instructor < ApplicationRecord
  include Authenticatable
  include Avatarable

  # Associations
  has_many :courses, dependent: :destroy
  # Roles
  enum role: { instructor: 10, instructor_admin: 20 }
end
