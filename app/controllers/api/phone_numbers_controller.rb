class Api::PhoneNumbersController < Api::ApiController

	before_action :authorize_request
	before_action :set_person
	before_action :set_phone_number, only: [:show, :update, :destroy]

	def index
		@phone_numbers = @person.phone_numbers
		render json: @phone_numbers, status: :ok
	end

	def show
		render json: @phone_number, status: :ok
	end

	def create
		@phone_number = @person.phone_numbers.new(phone_number_params)

		if @phone_number.save
			render json: @phone_number, status: :created
		else
			render json: { errors: @phone_number.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		if @phone_number.update(phone_number_params)
			render json: @phone_number, status: :ok
		else
			render json: { errors: @phone_number.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@phone_number.destroy
		render json: { message: 'Deleted' }, status: :ok
	end

	private

	def set_person
		@person = @current_user.find(params[:person_id])
	end

	def set_phone_number
		@phone_number = @person.phone_numbers.find(params[:id])
	end

	def phone_number_params
		params.permit(:phone_number, :comment)
	end
end
