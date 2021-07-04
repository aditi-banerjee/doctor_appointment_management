class Api::V1::DoctorAppointment::AppointmentsController < Api::V1::BaseController
  before_action :check_role, except: [:index, :show, :delete]
  #
  ##Get list of available time slots
  #
  def index
    if (@current_user.role == "Doctor")
      @appointments = @current_user.doctor_appointments
    elsif @current_user.role == "Patient"
      @appointments = @current_user.patient_appointments
    end
    if @appointments.present?
      render json:{
        data: @appointments,
        rstatus: 1,
        status: 200,
        messages: "Ok"
      }
    else
      render json:{
        data:{
          messages: "There is no appointments available"
        },
        rstatus: 0,
        status: 404
      }
    end
  end

  def create
    @appointment = @current_user.patient_appointments.new(patient_appointments_params)
    if @appointment.save
      @appointment.doctor_availablity.update(is_available: false)
      SendReminderMailJob.set(wait_until: (@appointment.doctor_availablity.available_from - 30.minutes)).perform_later(@appointment)
      render json:{
        data: @appointment,
        rstatus: 1,
        status: 200,
        messages: "Ok"
      }
    else
      render json:{
        data:{
          messages: @appointment.errors.full_messages
        },
        rstatus: 0,
        status: 404
      }
    end
  end

  def show
    @appointment = @current_user.patient_appointments.find_by(id: params[:id])
    if @appointment.present?
      render json:{
        data: @appointment,
        rstatus: 1,
        status: 200,
        messages: "Ok"
      }
    else
      render json:{
        data:{
          messages: @appointment.errors.full_messages
        },
        rstatus: 0,
        status: 404
      }
    end
  end

  private
    def patient_appointments_params
      params.require(:applications).permit(
        :doctor_id,
        :patient_id,
        :doctor_availablity_id,
        :status
      )
    end

    def check_role
      unless @current_user.role == "Patient"
      render(status: 404, inline: "User must be Patient")
    end
end
