class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.belongs_to :courses, null: false, foreign_key: true
      t.belongs_to :instructors, null: false, foreign_key: true
      t.belongs_to :students, null: false, foreign_key: true

      t.timestamps
    end
  end
end
