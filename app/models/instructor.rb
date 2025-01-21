class Instructor < ApplicationRecord
  include Authenticatable
  include Avatarable
  include FullNameable

  # Associations
  has_many :courses, dependent: :destroy
  has_many :comments, as: :authorable, dependent: :destroy
  # Roles
  enum role: { instructor: 10, instructor_admin: 20 }
end
