class SendReminderMailJob < ActiveJob::Base
  def perform(appointment)
    AppointmentReminderMailer.reminder_mail(appointment).deliver_now
  end
end
