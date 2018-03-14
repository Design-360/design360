class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :notify, polymorphic: true, index: true
      t.references :recipient, polymorphic: true, index: true
      t.references :actor, polymorphic: true, index: true
      t.integer :status

      t.timestamps
    end
  end
end
