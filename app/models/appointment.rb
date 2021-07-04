class Appointment < ApplicationRecord
  #
  ##Associations
  #
  belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
  belongs_to :patient, class_name: "User", foreign_key: "patient_id"
  belongs_to :doctor_availablity

  #
  ## status
  #
  enum role: {
    Booked: 1,
    Cancelled: 2
  }

  #
  ##Validations
  #
  validates :doctor_availablity, presence: true, uniqueness: {scope: [:patient_id, :doctor_id]}

end
