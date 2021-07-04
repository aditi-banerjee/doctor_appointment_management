class User < ApplicationRecord
  has_secure_password
  #
  ## Role
  #
  enum role: {
    Doctor: 1,
    Patient: 2
  }

  #
  ##Associations
  #
  has_many :doctor_appointments, class_name: "Appointment", foreign_key: "doctor_id"
  has_many :patient_appointments, class_name: "Appointment", foreign_key: "patient_id"
  has_many :doctor_availablities,  class_name: "DoctorAvailablity", foreign_key: "doctor_id"
end
