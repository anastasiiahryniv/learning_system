module AvatarManager
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar, dependent: :destroy
    after_commit :avatar_default, on: %i[create update]
  end

  def avatar_default
    '/default_profile.png' unless avatar.attached?
  end
end
