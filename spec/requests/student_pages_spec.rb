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

			it {should have_selector('div.pagination')}
			it "should list each student" do
				Student.paginate(page: 1).each do |student|
					expect(page).to have_selector('li', text: student.fname)
			end
		end

		describe "delete links" do
			it {should_not have_link('delete')}
			describe "as an admin user" do
				let(:admin) { FactoryGirl.create(:admin) }
				before do
          			sign_in admin
          			visit students_path
        		end
				it {should have_link('delete', href: student_path(Student.first))}
				it "should be able to delete another user" do
					expect do
						click_link('delete', match: :first)
					end.to change(Student, :count).by(-1)
				end
				it {should_not have_link('delete', href: student_path(admin)} #Dont let admin delete themselves
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

		describe "with valid information" do
			before do
				fill_in "First Name",      with: "John"
				fill_in "Last Name",       with: "Smith"
				fill_in "School",          with: "University of Toronto"
				fill_in "Discipline",      with: "ECE"
				#fill_in "Year",            with: "3"
				fill_in "student_email",   with: "student@mail.utoronto.ca"
				fill_in "Password",        with: "login123", :match => :prefer_exact
				fill_in "Confirmation",    with: "login123", :match => :prefer_exact
				click_button submit
			end

			it "should create a new student" do
				expect {click_button submit}.to change(Student, :count).by(1)
			end

			describe "after saving the student" do
				before {click_button submit}
				let(:student) {Student.find_By(email: 'student@mail.utoronto.ca')}

				it {should have_link('sign_out')}
				it {should have_title (student.fname)}
				it { should have_selector('div.alert.alert-success', text: 'Welcome') }
			end

			describe "followed by a signout" do #After signing out, the signin button should appear again
				before {click_link 'Sign out'} 
				it {should have_link('Sign in')}
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

		describe "with valid information" do
			let(:new_name) {"New Name"}
			before do
				fill_in "First Name", with: new_name
				click_button "Save changes"
			end

			it {should have_title(new_name)}
			it { should have_selector('div.alert.alert-success') }
			it {should have_link('Sign out', href: signout_path) }
			specify { expect(user.reload.name).to  eq new_name }

		end
	end
end