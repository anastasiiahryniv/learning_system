class CreateCourses < ActiveRecord::Migration[6.1]
  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "instructor_id", null: false
    t.bigint "student_id", null: false
    t.text "description"
    t.timestamps
  end

  add_foreign_key :courses, :users, column: instructor_id
  add_foreign_key :courses, :users, column: student_id
  add_index courses, [:instructor_id, :student_id ], unique: true
end
