class SessionsController < ApplicationController

	def new
		
	end

	def create
		student = Student.find_by(email: params[:session][:email].downcase)
		recruiter = Recruiter.find_by(email: params[:session][:email].downcase)

		if student && student.authenticate(params[:session][:password]) #Student signed in successfully
			sign_in student
			redirect_back_or student
		else
			flash.now[:error] = 'Invalid email and/or password'
		    render 'new'
	
		end
	end

	def destroy #When signed out
		sign_out
		redirect_to root_url
	end


end
