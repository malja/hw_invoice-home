class AuthController < ApplicationController

	before_action :redirect_if_logged_in, only: [:new, :create]
	def new
	end

	def create
		user = User.find_by(email: params[:login][:email].downcase)

		if user && user.authenticate(params[:login][:password])
			logger.info("loggin in")
			session[:user_id] = user.id.to_s
			redirect_to app_path, notice: 'Successfully logged in!'
		else
			logger.error("failed to log in")
			flash.now[:alert] = 'Incorrect email or password. Please try again.'
			render :new, status: :unprocessable_entity
		end
	end

	def destroy
		session.delete(:user_id)
		redirect_to root_path, notice: 'Successfully logged out!'
	end

	private

	def redirect_if_logged_in
		redirect_to app_path if current_user
	end
end
