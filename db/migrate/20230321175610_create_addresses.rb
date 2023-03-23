class CreateAddresses < ActiveRecord::Migration[6.1]
  def change
    create_table :addresses do |t|
      t.string :street, null: false
      t.string :town, null: false
      t.string :zip_code, null: false
      t.string :state, null: true
      t.string :country, null: false, limit: 2

      t.references :person, null: false, foreign_key: true
      t.timestamps
    end
  end
end
