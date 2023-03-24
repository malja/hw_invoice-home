class PhoneNumbersController < ApplicationController

	before_action :authorize
	before_action :set_person
	before_action :set_phone_number, only: [:edit, :update, :destroy]


	def new
		@phone_number = @person.phone_numbers.new
	end

	def create
		@phone_number = @person.phone_numbers.new(phone_number_params)

		if @phone_number.save
			redirect_to person_path(@person), notice: 'Phone number was successfully created.'
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @phone_number.update(phone_number_params)
			redirect_to person_path(@person), notice: 'Phone number was successfully updated.'
		else
			render :edit
		end
	end

	def destroy
		@phone_number.destroy
		redirect_to person_path(@person), notice: 'Phone number was successfully destroyed.'
	end

	private

	def set_person
		@person = current_user.find(params[:person_id])
	end

	def set_phone_number
		@phone_number = @person.phone_numbers.find(params[:id])
	end

	def phone_number_params
		params.require(:phone_number).permit(:phone_number, :comment)
	end
end
