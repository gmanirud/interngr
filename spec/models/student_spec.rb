require 'spec_helper'

#Spec for the student model

describe Student do
	before {@test_student = Student.new(fname: "Bob", lname: "Loblaw", email: "bob@mail.utoronto.ca", year: 1, school: "University of Toronto", discipline: "ECE")}
	subject {@test_student}

	it {should respond_to (:fname)}
	it {should respond_to (:lname)}
	it {should respond_to (:email)}
	it {should respond_to (:year)}
	it {should respond_to (:school)}
	it {should respond_to (:discipline)}
	it {should be_valid}

	#presence tests

	describe "first name is not present" do
		before {@test_student.fname = " "}
		it {should_not be_valid}
	end

	describe "last name is not present" do
		before {@test_student.lname = " "}
		it {should_not be_valid}
	end

	describe "email is not present" do
		before {@test_student.email = " "}
		it {should_not be_valid}
	end

	describe "school is not present" do
		before {@test_student.school = " "}
		it {should_not be_valid}
	end

	describe "discipline is not present" do
		before {@test_student.discipline = " "}
		it {should_not be_valid}
	end

	#length validation tests
	describe "first name is too long" do
		before {@test_student.fname = "a"*20}
		it {should_not be_valid}
	end

	describe "last name is too long" do
		before {@test_student.lname = "a"*30}
		it {should_not be_valid}
	end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @test_student.email = invalid_address
        expect(@test_student).not_to be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @test_student.email = valid_address
        expect(@test_student).to be_valid
      end
    end
  end

  describe "email address is already taken" do
  	before do
  		student_with_dup_email = @test_student.dup
  		student_with_dup_email.email = @test_student.email.upcase
  		student_with_dup_email.save
  	end
  	it {should_not be_valid}
  end

end
