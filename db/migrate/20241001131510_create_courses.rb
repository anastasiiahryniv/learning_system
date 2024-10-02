class CreateCourses < ActiveRecord::Migration[6.1]
  create_table "courses", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "instructor_id", null: false
    t.text "description"
    t.integer "status", default: 30
    t.timestamps
  end

  add_foreign_key :courses, :instructors
  add_index :courses, :instructor_id
end
