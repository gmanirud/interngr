require 'spec_helper'

describe "Student pages: " do
	subject {page}

	describe "signup page" do
		before {visit student_signup_path}
		it {should have_content('Student Signup')}
		it {should have_title('Sign up | Interngration')}
	end

	describe "profile pages" do
		let(:student) {FactoryGirl.create(:student)}
		before {visit student_path(student)}

		it {should have_content(student.fname)}
		it {should have_content(student.lname)}
		it {should have_title(student.fname)}
	end

	describe "student signing up" do

		before {visit student_signup_path}
		let(:submit) {"Create my account"}

		describe "with invalid information" do
			it "should not create a new student" do
				expect {click_button submit}.not_to change(Student, :count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "First Name",      with: "Bob"
				fill_in "Last Name",       with: "Loblaw"
				fill_in "School",          with: "University of Toronto"
				fill_in "Discipline",      with: "ECE"
				#fill_in "Year",            with: "3"
				fill_in "Password",        with: "login123", :match => :prefer_exact
				fill_in "Confirmation",    with: "login123", :match => :prefer_exact
			end

			it "should create a new student" do
				expect {click_button submit}.to change(Student, :count).by(1)
			end
		end
	end

end