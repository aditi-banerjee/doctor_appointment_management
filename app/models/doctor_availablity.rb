class DoctorAvailablity < ApplicationRecord
  #
  ##Associations
  #
  belongs_to :doctor, class_name: "User", foreign_key: "doctor_id"
  has_one :doctor_appointment

  #
  ## Validations
  #
  validate  :valid_doctor
  validates :available_from, presence: { message: "must be a valid date/time" }, uniqueness: { scope: :doctor_id }
  validates :available_to, presence: {message: "must be a valid date/time"}, uniqueness: { scope: :doctor_id }
  validate  :valid_available_slot

  private
    def valid_doctor
      errors.add(:doctor, "can only add availablity") unless
          doctor.role != "Doctor"
    end

    def valid_available_slot
      errors.add(:available_from, "must be before end time") unless
          available_from < available_to
    end
end
