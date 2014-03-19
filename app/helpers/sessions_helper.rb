module SessionsHelper

	def sign_in(student)
		remember_token = Student.new_remember_token #create a new token
		cookies.permanent[:remember_token] = remember_token #place it in the browser cookies
		student.update_attribute(:remember_token, Student.hash(remember_token)) #save encrypted cookie to the db
		self.current_student = student #set current user to given user
 	end

 	def signed_in? #check if a user is signed in
 		!current_student.nil?
 	end

 	def current_student=(student)
 		@current_student = student
 	end

 	def current_student
 		remember_token = Student.hash(cookies[:remember_token])
 		@current_student ||= Student.find_by(remember_token: remember_token)
 	end

 	def current_student?(student)
 			student == current_student
 	end

 	def sign_out
 		current_student.update_attribute(:remember_token, Student.hash(Student.new_remember_token))
 		cookies.delete(:remember_token)
 		self.current_student = nil
 	end

 	def redirect_back_or(default)
 		redirect_to(session[:return_to] || default)
 		session.delete(:return_to)
 	end

 	def store_location
 		session[:return_to] = request.url if request.get? #store location of requested URL, only if its a GET request
 	end


end
