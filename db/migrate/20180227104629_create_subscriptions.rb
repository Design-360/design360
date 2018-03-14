class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.references :chat
      t.references :subscriber, polymorphic: true, index: true

      t.timestamps
    end
  end
end
