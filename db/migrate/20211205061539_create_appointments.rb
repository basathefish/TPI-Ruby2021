class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.datetime :date, null: false
      t.belongs_to :professional, null: false, foreign_key: true
      t.string :name, null: false
      t.string :surname, null: false
      t.integer :phone, null: false
      t.string :note, null: true

      t.timestamps
    end
  end
end
