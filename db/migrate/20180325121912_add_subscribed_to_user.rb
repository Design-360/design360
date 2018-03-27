class AddSubscribedToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :subscribed, :integer, default:0
  end
end
