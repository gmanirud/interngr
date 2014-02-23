namespace :db do
	desc "Fill database with sample users"

	task populate: :environment do
		Student.create!(fname: "Sample",
						lname: "Student",
						year: "3",
						school: "University of Toronto",
						discipline: 'ENGSCI',
						email: "test@mail.utoronto.ca",
						password: "foobar",
						password_confirmation: "foobar",
						admin: true)
		99.times do |n|
			fname  = Faker::Name.name
			lname = Faker::Name.name
			year = "1"
			school ="University of Toronto"
			discipline = "ECE"
			email = "sample-#{n+1}@mail.utoronto.ca"
      		password  = "password"

      		Student.create!(fname: fname,
      					lname: lname,
      					year: year,
      					school: school,
      					discipline: discipline,
						email: email,
						password: password,
						password_confirmation: password)
      	end
	end
end