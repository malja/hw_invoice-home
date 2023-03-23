class EmailsController < ApplicationController
	before_action :authorize
	before_action :set_person
	before_action :set_email, only: [:edit, :update, :destroy]

	def new
		@email = @person.emails.new
	end

	def create
		@email = @person.emails.new(email_params)

		if @email.save
			redirect_to person_path(@person), notice: 'Email was successfully created.'
		else
			render :new
		end
	end

	def edit
	end

	def update
		if @email.update(email_params)
			redirect_to person_path(@person), notice: 'Email was successfully updated.'
		else
			render :edit
		end
	end

	def destroy
		@email.destroy
		redirect_to person_path(@person), notice: 'Email was successfully destroyed.'
	end

	private

	def set_person
		@person = current_user.people.find_by_id(params[:person_id])
		redirect_to app_path, alert: 'Person not found.' unless @person
	end

	def set_email
		@email = @person.emails.find(params[:id])
	end

	def email_params
		puts(params)
		params.require(:email).permit(:email_address, :comment)
	end
end