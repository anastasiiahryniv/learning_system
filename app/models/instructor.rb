class Instructor < ApplicationRecord
  include Authenticatable
  # Associations
  has_many :courses, dependent: :destroy
end
