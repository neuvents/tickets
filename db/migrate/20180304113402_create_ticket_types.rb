class CreateTicketTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :ticket_types do |t|
      t.references :event, foreign_key: {on_delete: :restrict}, null: false
      t.string :name, null: false
      t.boolean :active, null: false, default: false
      t.integer :price, null: false
      t.string :currency, limit: 3, null: false
      t.jsonb :fields, null: false, default: ""

      t.timestamps null: false
    end
  end
end
