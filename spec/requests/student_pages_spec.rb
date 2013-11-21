require 'spec_helper'

describe "Student pages" do
	subject {page}

	describe "signup page" do
		before {visit signup_path}
		it {should have_content('Student Signup')}
		it {should have_title(full_title('Sign up'))}
	end
end