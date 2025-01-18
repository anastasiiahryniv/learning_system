class Comment < ApplicationRecord
  belongs_to :course
  belongs_to :student, optional: true
  belongs_to :instructor, optional: true

  validates :body, presence: true

  has_rich_text :body
end
