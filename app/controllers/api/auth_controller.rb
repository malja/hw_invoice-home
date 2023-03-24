class Api::AuthController < Api::ApiController
	before_action :set_params, only: [:create]

	def create
		user = User.find_by(email: params[:email].downcase)

		if user && user.authenticate(params[:password])
			token = Api::JsonWebToken.encode(user_id: user.id)
			time = Time.now + 24.hours.to_i
			render json: { token: token, expires: time.strftime("%d-%m-%Y %H:%M:%S") }, status: :ok
		else
			render json: { error: 'unauthorized' }, status: :unauthorized
		end
	end

	private

	def set_params
		params.permit(:email, :password)
	end
end
