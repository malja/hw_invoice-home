class PeopleController < ApplicationController
	before_action :set_person, only: [:show, :edit, :update, :destroy]
	before_action :authorize
	def index
		@people = current_user.people
	end

	def show
	end

	def new
		@person = current_user.people.new
	end

	def create
		@person = current_user.people.new(person_params)

		if @person.save
			redirect_to @person, notice: 'Person was successfully created.'
		else
			flash.now.alert = 'Could not save person.'
			logger.warn("Could not save person. #{person.errors.full_messages}")
			render :new
		end
	end

	def edit
	end

	def update
		if @person.update(person_params)
			redirect_to people_url, notice: 'Person was successfully updated.'
		else
			redirect_to @person, alert: 'Could not update person.'
		end
	end

	def destroy
		@person.destroy
		redirect_to people_url, notice: 'Person was successfully destroyed.'
	end

	private

	def set_person
		@person = current_user.people.find_by_id(params[:id])
		redirect_to app_path, alert: 'Person not found.' unless @person
	end

	def person_params
		params.require(:person).permit(:salutation, :first_name, :middle_name, :last_name, :ssn, :birth_date, :comment)
	end
end