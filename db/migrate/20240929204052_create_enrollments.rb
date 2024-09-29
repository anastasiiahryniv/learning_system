class CreateEnrollments < ActiveRecord::Migration[6.1]
  def change
    create_table :enrollments do |t|
      t.bigint :student_id, null: false
      t.bigint :course_id, null: false

      t.timestamps
    end

    add_foreign_key :enrollments, :users, column: :student_id
    add_foreign_key :enrollments, :courses
    add_index :enrollments, [:student_id, :course_id], unique: true
  end
end