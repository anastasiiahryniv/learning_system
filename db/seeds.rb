require 'faker'
PASSWORD = "Test123!"
# Create or find the instructor
Instructor.find_or_create_by(email: "instructor@mail.com") do |instructor|
  instructor.name = Faker::Name.first_name
  instructor.surname = Faker::Name.last_name
  instructor.status = "pending"
  instructor.password = PASSWORD
  instructor.password_confirmation = PASSWORD
  instructor.role = "instructor"
end

Instructor.find_or_create_by(email: "instructor_admin@mail.com") do |instructor|
  instructor.name = Faker::Name.first_name
  instructor.surname = Faker::Name.last_name
  instructor.status = "pending"
  instructor.password = PASSWORD
  instructor.password_confirmation = PASSWORD
  instructor.role = "instructor_admin"
end

Student.find_or_create_by(email: "student@mail.com") do |student|
  student.name = Faker::Name.first_name
  student.surname = Faker::Name.last_name
  student.status = "pending"
  student.password = PASSWORD
  student.password_confirmation = PASSWORD
end

Course.find_or_create_by(name: "Ruby on Rails") do |course|
  course.description = "A course for learning Ruby on Rails"
  course.status = "inactive"
  course.instructor = Instructor.first
  course.student = Student.first# Assuming this instructor was created in the previous step
end

Enrollment.find_or_create_by(student: Student.first, course: Course.first) do |enrollment|
  enrollment.status = "inactive"
  enrollment.grade = 5
end
