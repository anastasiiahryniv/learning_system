class CourseUpdatingService
  def initialize(course, params)
    @course = course
    @params = params
  end

  def call
    @course.update(@params)
  end
end
