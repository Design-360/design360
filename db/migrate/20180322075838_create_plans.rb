class CreatePlans < ActiveRecord::Migration[5.1]
  def change
    create_table :plans do |t|
      t.integer :amount
      t.string :name
      t.string :interval
      t.integer :trial_period
      t.text :stripe_response

      t.timestamps
    end
  end
end
