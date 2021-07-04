class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.integer :doctor_id
      t.integer :patient_id
      t.integer :doctor_availablity_id
      t.integer :status, default: 1

      t.timestamps
    end
    add_index :appointments, :doctor_id
    add_index :appointments, :patient_id
    add_index :appointments, :doctor_availablity_id
  end
end
