class AddIndexEmployeesEmployeeId < ActiveRecord::Migration[6.0]
  def change
    add_index :employees, :employee_id, unique: true
  end
end
