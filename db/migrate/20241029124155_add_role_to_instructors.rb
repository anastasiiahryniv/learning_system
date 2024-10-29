class AddRoleToInstructors < ActiveRecord::Migration[6.1]
  def change
    add_column :instructors, :role, :string, default: "instructor"
  end
end
