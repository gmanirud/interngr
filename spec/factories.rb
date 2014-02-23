FactoryGirl.define do 
	factory :student do
		sequence(:fname) {|n| "Student_#{n}"} 
		sequence(:lname) {|n| "Test_#{n}"} 
		sequence(:email) {|n| "Student_#{n}.test_#{n}@mail.utoronto.ca"}
		school "University of Toronto"
		discipline "ECE"
		year "3"
		password "login123"
		password_confirmation "login123"

		factory :admin do
			admin true
		end
	end
end

