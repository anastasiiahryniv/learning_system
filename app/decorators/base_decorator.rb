class BaseDecorator < Draper::Decorator
  delegate_all

  def full_name
    "#{object.name} #{object.surname}"
  end

  def img_resized
    object.avatar.variant(resize_to_limit: [200, 200])
  end
end
