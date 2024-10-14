class CreateEnrollments < ActiveRecord::Migration[6.1]
  def change
    create_table :enrollments do |t|
      t.bigint :student_id, null: false
      t.bigint :course_id, null: false
      t.integer :status
      t.integer :grade

      t.timestamps
    end

    add_foreign_key :enrollments, :students
    add_foreign_key :enrollments, :courses
    add_index :enrollments, [:student_id, :course_id], unique: true
  end
end
