class Api::V1::DoctorAppointment::DoctorAvailablitiesController < Api::V1::BaseController
  before_action :check_role, except: [:index, :show]
  #
  ##Get list of available time slots
  #
  def index
    if (@current_user.role == "Doctor" && @current_user.id == params[:doctor_id])
      @doctor_availablities = DoctorAvailablity.where(doctor_id: params[:doctor_id])
    elsif @current_user.role == "Patient"
      @doctor_availablities = DoctorAvailablity.where(doctor_id: params[:doctor_id], is_available: true)
    end
    if @doctor_availablities.present?
      render json:{
        data: @doctor_availablities,
        rstatus: 1,
        status: 200,
        messages: "Ok"
      }
    else
      render json:{
        data:{
          messages: "You are not authorised to see the available_slots."
        },
        rstatus: 0,
        status: 404
      }
    end
  end

  def create
    @doctor_availablity = @current_user.doctor_availablities.new(doctor_availablity_params)
    if @doctor_availablity.save
      render json:{
        data: @doctor_availablity,
        rstatus: 1,
        status: 200,
        messages: "Ok"
      }
    else
      render json:{
        data:{
          messages: @doctor_availablity.errors.full_messages
        },
        rstatus: 0,
        status: 404
      }
    end
  end

  def update
    @doctor_availablity = @current_user.doctor_availablities.find_by(params[:id])
    if @doctor_availablity.update(available_from: params[:doctor_availablity][:available_from], available_to: params[:doctor_availablity][:available_to])
      render json:{
        data: @doctor_availablity,
        rstatus: 1,
        status: 200,
        messages: "Ok"
      }
    else
      render json:{
        data:{
          messages: @doctor_availablity.errors.full_messages
        },
        rstatus: 0,
        status: 404
      }
    end
  end

  def show
    @doctor_availablity = DoctorAvailablity.find_by(id: params[:id])
    if @doctor_availablity.present?
      render json:{
        data: @doctor_availablity,
        rstatus: 1,
        status: 200,
        messages: "Ok"
      }
    else
      render json:{
        data:{
          messages: @doctor_availablity.errors.full_messages
        },
        rstatus: 0,
        status: 404
      }
    end
  end

  def delete
    @doctor_availablity = DoctorAvailablity.find_by(id: params[:id])
    if @doctor_availablity.present?
      @doctor_availablity.delete
      render json:{
        data:{
          messages: "Deleted successfully"
        },
        rstatus: 1,
        status: 200
      }
    else
      render json:{
        data:{
          messages: @doctor_availablity.errors.full_messages
        },
        rstatus: 0,
        status: 404
      }
    end
  end

  private
    def doctor_availablity_params
      params.require(:doctor_availablity).permit(
        :doctor_id,
        :available_from,
        :available_to
      )
    end

    def check_role
      unless @current_user.role == "Doctor"
        render(status: 404, inline: "User must be Doctor")
      end
    end
end
