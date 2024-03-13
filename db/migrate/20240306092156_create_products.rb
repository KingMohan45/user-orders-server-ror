class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      t.string :code
      t.string :name
      t.string :category

      t.timestamps
    end
    add_index :products, :code
    add_index :products, :category
  end
end
