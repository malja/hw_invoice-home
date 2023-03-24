class Api::PeopleController < Api::ApiController
	before_action :authorize_request
	before_action :set_person, only: [:show, :update, :destroy]

	def index
		@people = @current_user.people
		render json: @people, status: :ok
	end

	def show
		render json: @person, status: :ok
	end

	def create
		@person = @current_user.people.new(person_params)

		if @person.save
			render json: @person, status: :created
		else
			render json: { errors: @person.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		if @person.update(person_params)
			render json: @person, status: :ok
		else
			render json: { errors: @person.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@person.destroy
		render json: { message: 'Deleted' }, status: :ok
	end

	private

	def set_person
		@person = @current_user.people.find(params[:id])
	end

	def person_params
		params.require(:person).permit(:salutation, :first_name, :middle_name, :last_name, :ssn, :birth_date, :comment)
	end
end