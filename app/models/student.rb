class Student < ActiveRecord::Base
	
	#use the before_save callback to make all email address lowercase before saving to db
	before_save {self.email = email.downcase}
	#user the before_create callback to create the remember me cookie 
	before_create :create_remember_token

	validates :fname, presence: true, length: {maximum: 30}
	validates :lname, presence: true, length: {maximum: 30}

	 VALID_EMAIL_REGEX = /[\w+\-.]+@mail.utoronto\.[a-z]+/i

	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	validates :year, presence: true
	validates :school, presence: true
	validates :discipline, presence: true
	has_secure_password
	validates :password, length:  {minimum: 6}

	def Student.new_remember_token
		SecureRandom.urlsafe_base64

	end

	def Student.hash(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

	  def create_remember_token
	  	self.remember_token = Student.hash(Student.new_remember_token)
	  end

end
