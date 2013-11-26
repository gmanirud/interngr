class Student
	attr_accessor :fname, :lname, :email, :year, :school, :discipline

	def initialize (personal_info = {}, edu_info = {})
		@fname = personal_info[:fname]
		@lname = personal_info[:lname]
		@email = personal_info[:email]
		@year = edu_info[:year]
		@school = edu_info[:school]
		@discipline = edu_info[:discipline]
	end
