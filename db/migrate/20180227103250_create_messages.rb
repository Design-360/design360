class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.string :content
      t.references :message_sender, polymorphic: true, index: true
      t.references :chat, index: true

      t.timestamps
    end
  end
end
