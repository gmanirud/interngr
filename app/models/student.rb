class Student < ActiveRecord::Base
	
	#use the before_save callback to make all email address lowercase before saving to db
	before_save {self.email = email.downcase}

	validates :fname, presence: true, length: {maximum: 20}
	validates :lname, presence: true, length: {maximum: 30}

	 VALID_EMAIL_REGEX = /[\w+\-.]+@mail.utoronto\.[a-z]+/i

	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	validates :year, presence: true
	validates :school, presence: true
	validates :discipline, presence: true
	has_secure_password
	validates :password, length:  {minimum: 6}


end
