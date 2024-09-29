class Enrollment < ApplicationRecord
  belongs_to :student, class_name: 'Student'
  belongs_to :course
end
