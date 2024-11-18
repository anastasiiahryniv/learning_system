class CourseDecorator < Draper::Decorator
  delegate_all

  def truncated_name
    object.name.truncate(40).to_s
  end

  def truncated_description
    object.description.truncate(40).to_s
  end
end
