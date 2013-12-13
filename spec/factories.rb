FactoryGirl.define do 
	factory :student do
		fname "Test"
		lname "Student"
		email "test@mail.utoronto.ca"
		school "University of Toronto"
		discipline "ECE"
		year "3"
		password "login123"
		password_confirmation "login123"
	end
end

