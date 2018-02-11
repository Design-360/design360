class CreateAttachments < ActiveRecord::Migration[5.1]
  def change
    create_table :attachments do |t|
      t.integer :order_id
      t.integer :employee_id
      t.integer :avatar_type

      t.timestamps
    end
    add_attachment :attachments, :avatar
  end
end
