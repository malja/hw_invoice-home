class Api::EmailsController < Api::ApiController
	before_action :authorize_request
	before_action :set_person
	before_action :set_email, only: [:show, :update, :destroy]

	def index
		@emails = @person.emails
		render json: @emails, status: :ok
	end

	def show
		render json: @email, status: :ok
	end

	def create
		@email = @person.emails.new(email_params)

		if @email.save
			render json: @email, status: :created
		else
			render json: { errors: @email.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		if @email.update(email_params)
			render json: @email, status: :ok
		else
			render json: { errors: @email.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@email.destroy
		render json: { message: 'Deleted' }, status: :ok
	end

	private

	def set_person
		@person = @current_user.people.find_by_id(params[:person_id])
		redirect_to app_path, alert: 'Person not found.' unless @person
	end

	def set_email
		@email = @person.emails.find(params[:id])
	end

	def email_params
		params.permit(:email_address, :comment)
	end
end