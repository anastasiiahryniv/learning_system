class StudentDecorator < Draper::Decorator
  delegate_all

  include FullNameable
  include AvatarResizable
end
