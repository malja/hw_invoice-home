class Api::UsersController < Api::ApiController

	before_action :authorize_request

	def index
		@users = User.all
		data = @users.map do |user|
			{
				id: user.id,
				email: user.email,
				created_at: user.created_at
			}
		end

		render json: data, status: :ok
	end

	def update
		if @user.update(user_params)
			render json: @user, status: :ok
		else
			render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.permit(:email, :password, :password_confirmation)
	end

end