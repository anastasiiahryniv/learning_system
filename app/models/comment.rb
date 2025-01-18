class Comment < ApplicationRecord
  belongs_to :courses
  belongs_to :instructors
  belongs_to :students
end
