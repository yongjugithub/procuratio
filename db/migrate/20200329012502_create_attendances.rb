class CreateAttendances < ActiveRecord::Migration[6.0]
  def change
    create_table :attendances do |t|
      t.datetime :ride_at
      t.text :ride_in
      t.boolean :attr_one
      t.boolean :attr_two
      t.boolean :attr_three
      t.boolean :attr_four
      t.boolean :attr_five
      t.boolean :attr_six
      t.boolean :attr_seven
      t.boolean :attr_eight
      t.boolean :attr_nine
      t.boolean :attr_ten
      t.boolean :attr_eleven
      t.boolean :attr_twelve
      t.text :memo
      t.integer :point
      t.references :employee, foreign_key: true

      t.timestamps
    end
    add_index :attendances, [:employee_id, :created_at]
  end
end
