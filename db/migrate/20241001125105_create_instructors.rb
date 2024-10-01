class CreateInstructors < ActiveRecord::Migration[6.1]
  def change
    create_table :instructors do |t|
      t.string :status, null: false
      t.string :name, null: false
      t.string :surname, null: false
      t.string :email, null: false
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
      t.datetime :remember_created_at

      t.timestamps
    end

    add_index :instructors, :email, unique: true
    add_index :instructors, :reset_password_token, unique: true
  end
end
