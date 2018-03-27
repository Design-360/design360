class CreatePlanSubscribers < ActiveRecord::Migration[5.1]
  def change
    create_table :plan_subscribers do |t|
      t.references :user, foreign_key: true
      t.text :stripe_response
      t.references :plan, foreign_key: true

      t.timestamps
    end
  end
end
