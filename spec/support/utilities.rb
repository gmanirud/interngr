def full_title(page_title)
	base_title = "Interngration"
	if page_title.empty?
		base_title
	else
		"#{base_title} | #{page_title}"
	end
end

def sign_in(student, options={})
	if options[:no_capybara]
		#sign in w/o using capybara
		remember_token = Student.new_remember_token
		cookie[:remember_token] = remember_token
		Student.update_attribute(:remember_token, Student.encrypt(remember_token))

	else
		visit student_signin_path
		fill_in "Email",      with: student.email
		fill_in "Password",   with: student.password
		click_button "Sign in"
	end
end