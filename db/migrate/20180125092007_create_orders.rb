class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.integer :duration
      t.integer :amount
      t.integer :status, default: 0
      t.integer :rating
      t.text :review
      t.integer :template_id
      t.string :design_type
      t.text :size_format
      t.text :content
      t.string :color
      t.text :description
      

      t.timestamps
    end
  end
end
