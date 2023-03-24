class Api::AddressesController < Api::ApiController

	before_action :authorize_request
	before_action :set_person
	before_action :set_address, only: [:show, :update, :destroy]

	def index
		@addresses = @person.addresses
		render json: @addresses, status: :ok
	end

	def show
		render json: @address, status: :ok
	end

	def create
		@address = @person.addresses.new(address_params)

		if @address.save
			render json: @address, status: :created
		else
			render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		if @address.update(address_params)
			render json: @address, status: :ok
		else
			render json: { errors: @address.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def destroy
		@address.destroy
		render json: { message: 'Deleted' }, status: :ok
	end

	private

	def set_person
		@person = @current_user.people.find(params[:person_id])
	end

	def set_address
		@address = @person.addresses.find(params[:id])
	end

	def address_params
		params.require(:address).permit(:street, :town, :zip_code, :state, :country)
	end
end
