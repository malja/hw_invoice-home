class AddressesController < ApplicationController

	before_action :authorize
	before_action :set_person
	before_action :set_address, only: [:edit, :update, :destroy]

	def new
		@address = @person.addresses.new
	end

	def create
		@address = @person.addresses.new(address_params)

		if @address.save
			redirect_to person_path(@person), notice: 'Address was successfully created.'
		else
			render :new, alert: 'Could not save address.'
		end
	end

	def edit
	end

	def update
		if @address.update(address_params)
			redirect_to person_path(@person), notice: 'Address was successfully updated.'
		else
			render :edit, alert: 'Could not update address.'
		end
	end

	def destroy
		@address.destroy
		redirect_to person_path(@person), notice: 'Address was successfully destroyed.'
	end

	private

	def set_person
		@person = current_user.people.find_by_id(params[:person_id])
		redirect_to app_path, alert: 'Person not found.' unless @person
	end

	def set_address
		@address = @person.addresses.find(params[:id])
	end

	def address_params
		params.require(:address).permit(:street, :town, :zip_code, :state, :country)
	end
end
