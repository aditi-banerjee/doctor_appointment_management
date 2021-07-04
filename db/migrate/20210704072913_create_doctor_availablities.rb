class CreateDoctorAvailablities < ActiveRecord::Migration[5.2]
  def change
    create_table :doctor_availablities do |t|
      t.integer :doctor_id
      t.datetime :available_from
      t.datetime :available_to
      t.boolean  :is_available, default: true

      t.timestamps
    end
    add_index :doctor_availablities, :doctor_id
  end
end
