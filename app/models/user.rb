class User < ApplicationRecord
  validates :name, :surname, :email, presence: true
  validates :email, uniqueness: true
end
