class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.belongs_to :course, null: false, foreign_key: true
      t.belongs_to :instructor, foreign_key: true
      t.belongs_to :student, foreign_key: true

      t.timestamps
    end
  end
end
