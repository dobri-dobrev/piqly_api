class ApplicationController < ActionController::API
	before_filter :authenticate_with_auth_token
	
	def authenticate_with_auth_token
		auth_token = request.headers['X-Api-Key']
    	@user = User.where(auth_token: auth_token).first if auth_token
    	unless @user
    		render :json => {'error' => 'authentication error'}, :status => 401
    		return false
    	end
	end
	# def generate_api_key
	# 	loop do
	# 		token = SecureRandom.base64.tr('+/=', 'Qrt')
	# 		break token unless User.exists?(auth_token: token).any?
	# 	end
	# end
end
