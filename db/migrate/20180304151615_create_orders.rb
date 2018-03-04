class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :uid, null: false
      t.integer :payment_type, null: false, default: 0
      t.datetime :date, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.boolean :legal_entity, null: false, default: false
      t.string :company, null: false, default: ""
      t.string :company_uid, null: false, default: ""
      t.string :company_vat_uid, null: false, default: ""
      t.string :country, null: false, default: ""
      t.string :city, null: false, default: ""
      t.string :zip, null: false, default: ""
      t.string :address, null: false, default: ""

      t.timestamps null: false
    end

    add_index :orders, :uid, unique: true
  end
end
