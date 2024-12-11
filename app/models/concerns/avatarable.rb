module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar, dependent: :destroy
    after_commit :avatar_with_fallback, on: %i[create update]
  end

  def avatar_with_fallback
    avatar.attached? ? avatar : 'default_profile.png'
  end
end
