require 'spec_helper'

describe "Student pages: " do
	subject {page}

	describe "index" do
		before do
			sign_in FactoryGirl.create(:student)
			FactoryGirl.create(:student, fname: "Bob", email: "bob@mail.utoronto.ca")
			FactoryGirl.create(:student, fname: "Jack", email: "Jack@mail.utoronto.ca")
			visit students_path
		end

		it {should have_title('All Students')}
		it {should have_content('All Students')}

		it "should list each student" do
			Student.all.each do |student|
				expect(page).to have_selector('li', text: student.fname)
			end
		end

		describe "pagination" do
			before(:all) {30.times {FactoryGirl.create(:student)}}
			after(:all) {Student.delete_all}

			it {should have_selector('ul.pagination')}
			it "should list each student" do
				Student.paginate(page: 1).each do |student|
					expect(page).to have_selector('li', text: student.fname)
				end
			end
		end
	end

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
	end

	describe "edit" do
		let(:student) {FactoryGirl.create(:student)}
		 before do 
		 	sign_in student
		 	visit edit_student_path(student)
		 end
		 
		 describe "page" do
		 	it { should have_content("Update your profile") }
		 end

		 describe "with invalid information" do
		 	before {click_button "Save changes"}
		 	it {should have_content('error')}
		 end
	end
end