class Api::UsersController < Api::ApiController

	before_action :authorize_request

	def update
		if @user.update(user_params)
			render json: @user, status: :ok
		else
			render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

end