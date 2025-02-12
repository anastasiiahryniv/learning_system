class Comment < ApplicationRecord
  belongs_to :course
  belongs_to :authorable, polymorphic: true

  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :parent, class_name: 'Comment', optional: true
  has_many :replies, class_name: 'Comment', foreign_key: :parent_id, dependent: :destroy

  has_rich_text :body
end
