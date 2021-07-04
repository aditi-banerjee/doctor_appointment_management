class Api::V1::DoctorAppointment::UsersController < Api::V1::BaseController
	skip_before_action :verify_authenticity_token, only: [:login]
	#
	## Login
	#
  def login
		begin
			@search  = params[:email]
			conditions = ['']
			conditions[0] << '(email = ? or name = ?)'
			conditions << "#{@search}"
			conditions << "#{@search}"
			## Find user with email or user_name
		  user = User.find_by(conditions)
			if (user.present?)
				  if user.authenticate(params[:password])
				    render json: payload(user)
				  else
				    render json:{errors: ['Invalid Username/Password']}, status: :unauthorized
				  end
			else
				render json:{errors: ['User not found Please register first']}, status: :unauthorized
			end
		rescue Exception => e
			render json: {
				data:{
					messages: e.message
				},
				rstatus:0,
				status: 404
			}
		end
	end

	#
	## Get the params and user data
	#
  private
	  def payload(user)
			begin
		    return nil unless user and user.id
		    {
		      auth_token: JsonWebToken.encode({user_id: user.id}),
		      user: {
						id: user.id,
						email: user.email,
						name: user.name,
						role:			user.role
					},
					status: 200,
					messages: "Ok"
		    }
			rescue Exception => e
				render json: {
					data:{
						messages: e.message
					},
					rstatus:0,
					status: 404
				}
			end
	  end
end
