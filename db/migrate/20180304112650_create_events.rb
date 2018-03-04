class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :uid, null: false
      t.string :name, null: false
      t.boolean :active, null: false, default: false
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
