class AddAuthorableToComments < ActiveRecord::Migration[6.1]
  def change
    remove_column :comments, :student_id, :bigint
    remove_column :comments, :instructor_id, :bigint
    add_reference :comments, :authorable, polymorphic: true, index: true
  end
end
