class User < ActiveRecord::Base
	before_save :encrypt_password
	validates_presence_of :password, :on => :create
	validates_presence_of :email
	validates_uniqueness_of :email
	def self.authenticate(email, password)
	  	user = find_by_email(email)
	  	puts "generated " + BCrypt::Engine.hash_secret(password, user.password_salt)
	  	puts "saved " + user.password
	  	if user && user.password == BCrypt::Engine.hash_secret(password, user.password_salt)
	    	user
	  	else
	    	nil
	  	end
	end

	def encrypt_password
		#only encrypts password during first time instantiation
		if password.present? && self.created_at.nil?
			self.password_salt = BCrypt::Engine.generate_salt
			puts self.password_salt
			self.password = BCrypt::Engine.hash_secret(password, self.password_salt)
		end
	end

end
