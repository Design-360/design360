class AddOrderCountToPlan < ActiveRecord::Migration[5.1]
  def change
    add_column :plans, :order_count, :integer,default:0
  end
end
