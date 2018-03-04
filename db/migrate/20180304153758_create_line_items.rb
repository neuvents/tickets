class CreateLineItems < ActiveRecord::Migration[5.1]
  def change
    create_table :line_items do |t|
      t.references :ticket, foreign_key: {on_delete: :restrict}, null: false
      t.references :order, foreign_key: {on_delete: :restrict}, null: false
      t.integer :price, null: false
      t.string :currency, limit: 3, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps null: false
    end
  end
end
