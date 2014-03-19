require 'spec_helper'

#Spec for the student model

describe Student do
	before {@test_student = Student.new(fname: "Bob", lname: "Loblaw", password: "interngrpass", password_confirmation: "interngrpass", email: "bob@mail.utoronto.ca", year: 1, school: "University of Toronto", discipline: "ECE")}
	subject {@test_student}

	it {should respond_to (:fname)}
	it {should respond_to (:lname)}
	it {should respond_to (:email)}
	it {should respond_to (:year)}
	it {should respond_to (:school)}
	it {should respond_to (:discipline)}
	it {should respond_to (:password_digest)}
  it {should respond_to (:password_confirmation)}
  it {should respond_to (:remember_token)}
	it {should respond_to (:authenticate)}
  it {should respond_to (:admin)}

	it {should be_valid}
  it {should_not be_admin}

  describe "with admin attribute set to true" do
    before do
      @test_student.save!
      @test_student.toggle!(:admin)
    end

    it {should be_admin}
  end

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
		before {@test_student.fname = "a"*31}
		it {should_not be_valid}
	end

	describe "last name is too long" do
		before {@test_student.lname = "a"*31}
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
      addresses = %w[user@mail.utoronto.COM]
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

  #Authentication tests
  describe "with a password that's too short" do
    before { @test_student.password = @test_student.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @test_student.save }
    let(:found_student) { Student.find_by(email: @test_student.email) }

    describe "with valid password" do
      it { should eq found_student.authenticate(@test_student.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_student.authenticate("wrongpassword") }

      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }
    end
  end

  describe "remember token" do
    before {@test_student.save}
    its(:remember_token) {should_not be_blank}
    end
end
