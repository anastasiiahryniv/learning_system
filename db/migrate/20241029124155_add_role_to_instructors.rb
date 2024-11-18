class AddRoleToInstructors < ActiveRecord::Migration[6.1]
  def change
    add_column :instructors, :role, :integer, default: 10
  end
end
