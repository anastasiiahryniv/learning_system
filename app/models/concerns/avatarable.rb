module Avatarable
  extend ActiveSupport::Concern

  included do
    has_one_attached :avatar, dependent: :destroy

    validates :avatar,
              attached: true,
              content_type: { in: ['image/png', 'image/jpg', 'image/jpeg'],
                              message: I18n.t('avatar_type_validation_message') },
              size: { between: (1.kilobyte)..(5.megabytes), message: I18n.t('avatar_size_validation_message') }

    after_commit :avatar_with_fallback, on: %i[create update]
  end

  def avatar_with_fallback
    avatar.attached? ? avatar : 'default_profile.png'
  end
end
