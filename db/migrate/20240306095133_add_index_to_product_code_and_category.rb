class AddIndexToProductCodeAndCategory < ActiveRecord::Migration[7.1]
  def change
    remove_index :products, :category
    remove_index :products, :code
    add_index :products, :category, unique: true
    add_index :products, :code, unique: true
  end
end
