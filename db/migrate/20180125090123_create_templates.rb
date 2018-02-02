class CreateTemplates < ActiveRecord::Migration[5.1]
  def change
    create_table :templates do |t|
      t.string :name

      t.timestamps
    end
    add_attachment :templates, :image
  end
end
