class UsersController < ApplicationController
  skip_before_filter :authenticate_with_auth_token, :only => [:login, :signup]
  def login
    @user = User.authenticate(params[:email], params[:password])
    if @user
      if @user.auth_token == ""
        @user.auth_token = generate_token()
        @user.save
      end
      render :json => {'token' => @user.auth_token}, :status => 200  
    else
      render :json => {'error' => 'authentication error'}, :status => 401
    end
  end

  def logout
    @user.auth_token = ""
    @user.save!
    render :json => {'success' => true}, :status => 200
  end

  def signup
    @user = User.new()
    @user.email = params[:email]
    @user.password = params[:password]
    
    @user.auth_token = generate_token()
    if @user.save
      render :json => {'token' => @user.auth_token}, :status => 200  
    else
      puts "VERY WEIRD"
      render :json => {'error' => 'email exists'}, :status => 422
    end
  end
  

  
  private
    def generate_token
      token = ""
      loop do
        token = SecureRandom.base64.tr('0+/=', 'bRat')
        break token unless User.exists?(auth_token: token)
      end
      return token
    end
end
