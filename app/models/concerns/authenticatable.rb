module Authenticatable
  extend ActiveSupport::Concern
  # Constants
  MAX_NAME_LENGTH = 50

  included do
    # Devise methods
    # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :validatable

    # Validations
    validates :name, presence: true, length: { maximum: MAX_NAME_LENGTH }
    validates :surname, presence: true, length: { maximum: MAX_NAME_LENGTH }
    validates :email, uniqueness: true, presence: true

    # Enrollments
    enum status: { pending: 10, active: 20, inactive: 30 }

    after_create :set_status
  end

  def set_status
    update(status: :active)
  end
end
