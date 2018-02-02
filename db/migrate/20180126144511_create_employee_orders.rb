class CreateEmployeeOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :employee_orders do |t|
      t.integer :order_id
      t.integer :employee_id

      t.timestamps
    end
  end
end
