module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar, dependent: :destroy

    validates :avatar,
              attached: true,
              content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'], message: 'must be a PNG, JPG, or JPEG' },
              size: { between: 1.kilobyte..5.megabytes, message: 'must be between 1 KB and 5 MB' }

    after_commit :avatar_with_fallback, on: %i[create update]
  end

  def avatar_with_fallback
    avatar.attached? ? avatar : 'default_profile.png'
  end
end
