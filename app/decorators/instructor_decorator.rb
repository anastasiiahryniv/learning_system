class InstructorDecorator < Draper::Decorator
  include FullNameable
  include AvatarResizable

  delegate_all
end
