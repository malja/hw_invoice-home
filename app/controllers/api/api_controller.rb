class Api::ApiController < ActionController::API

	helper_method :authorize_request

	def authorize_request
		header = request.headers['Authorization']
		header = header.split(' ').last if header
		begin
			@decoded = Api::JsonWebToken.decode(header)
			@current_user = User.find(@decoded[:user_id])
		rescue ActiveRecord::RecordNotFound => e
			render json: { errors: e.message }, status: :unauthorized
		rescue ::JWT::DecodeError => e
			render json: { errors: e.message }, status: :unauthorized
		end
	end
end