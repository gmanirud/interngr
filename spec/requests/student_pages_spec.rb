require 'spec_helper'

describe "Student pages" do
	subject {page}

	describe "signup page" do
		before {visit student_signup_path}
		it {should have_content('Student Signup')}
		it {should have_title('Sign up | Interngration')}
	end
end