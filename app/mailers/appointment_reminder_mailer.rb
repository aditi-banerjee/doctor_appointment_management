class AppointmentReminderMailer < ApplicationMailer
  default from: 'appointment_management@system.com'
  layout 'mailer'

  def reminder_mail(appointment)
    @appointment = appointment
    @patient = appointment.patient
    @doctor = appointment.doctor
    @doctor_availablity = appointment.doctor_availablity
    mail(
      to:  @patient.email,
      subject: 'Reminder for your Appointment.'
    )
  end
end
