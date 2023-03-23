class UsersController < ApplicationController
	before_action :redirect_if_logged_in, only: [:new, :create]
	before_action :authorize, except: [:new, :create]
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
		@user.email.downcase!

		if @user.save
			UserMailer.welcome_email(@user).deliver_later
			logger.info("user created #{@user.email}")
			redirect_to login_path, notice: 'User was successfully created.'
		else
			logger.error("user not created #{@user.errors.full_messages}")
			flash.now[:alert] = @user.errors.full_messages.first
			render :new, status: :unprocessable_entity
		end
	end

	def edit
	end

	def update
		if @user.update(user_params)
			redirect_to user_url(@user), notice: 'User was successfully updated.'
		else
			flash.now[:alert] = @user.errors.full_messages
			render :edit
		end
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		UserMailer.goodbye_email(@user).deliver_later
		redirect_to root_path, method: :delete, notice: 'Account was successfully destroyed.'
	end

	private

	def set_user
		@user = current_user
	end

	def user_params
		params.require(:user).permit(:email, :password, :password_confirmation)
	end

	def redirect_if_logged_in
		redirect_to app_path if current_user
	end
end