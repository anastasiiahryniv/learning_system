class Student < ApplicationRecord
  include Authenticatable
  include Avatarable
  include FullNameable
  include UserRoles

  # Associations
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :comments, as: :author, dependent: :destroy
end
