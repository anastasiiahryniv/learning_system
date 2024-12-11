module AvatarResizable
  extend ActiveSupport::Concern

  def avatar_resize(size: [200, 200])
    object.avatar.variant(resize_to_limit: size)
  end
end
