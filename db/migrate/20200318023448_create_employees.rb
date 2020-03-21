class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.integer :employee_id, null: false
      t.string :name, null: false
      t.boolean :admin, default: false, null: false

      t.timestamps
    end
  end
end
