class CreateTickets < ActiveRecord::Migration[5.1]
  def change
    create_table :tickets do |t|
      t.references :ticket_type, foreign_key: {on_delete: :restrict}, null: false
      t.string :uid, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.jsonb :fields, null: false, default: ""

      t.timestamps null: false
    end

    add_index :tickets, :uid, unique: true
  end
end

