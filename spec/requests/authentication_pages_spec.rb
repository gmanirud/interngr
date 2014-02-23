require 'spec_helper'

describe "Authentication" do
	describe "with valid information" do
      let(:student) { FactoryGirl.create(:student) }
      before { sign_in student }

      it { should have_title(student.fname) }
      it { should have_link('Students',    href: students_path }
      it { should have_link('Profile',     href: student_path(student)) }
      it { should have_link('My Account',  href: edit_student_path(student)) }
      it { should have_link('Sign out',    href: student_signout_path) }
      it { should_not have_link('Sign in', href: student_signin_path) }
	end

  describe "authorization" do
    describe "for non signed in users" do
      let(:student) {FactoryGirl.create(:student)}

        describe "in the Student controller" do
          describe "visiting the edit page" do
            before {visit edit_student_path(student)}
            it {should have_title('Sign in')}
          end

          describe "visiting the Students index"
            before {visit students_path}
            it {should have_title('Sign in')}
          end

          describe "submitting to the update action" do
            before {patch student_path(student)}
            specify { expect(response).to redirect_to(student_signin_path) }
          end
        end 

      describe "when attempting to visit a protected page" do
        before do
          visit edit_student_path(user)
          fill_in "Email",    with: student.email
          fill_in "Password", with: student.password
          click_button "Sign in"
        end
      describe "after sigining in" do
        it "should render the desired protected page" do
        expect(page).to have_title('Edit user')
      end

    end
    describe "as wrong user" do
      let(:student) {FactoryGirl.create(:student)}
      let(:wrong_student) {FactoryGirl.create(:student, email: "wrong@mail.utoronto.ca")}
      before { sign_in student, no_capybara: true }

      describe "submitting a GET request to the Users#edit action" do
        before { get edit_student_path(wrong_student)}
        specify {expect(response.body).not_to match(full_title('Edit user'))}
        specify {expect(response).to redirect_to(root_url)}
      end

      describe "submitting a PATCH request to the Users#update action" do
        before {patch student_path(wrong_student)}
        specify {expect(response).to redirect_to(root_url)}
      end
    end

  describe "as a non-admin user" do
    let(:student) {FactoryGirl.create(:student)}
    let(:non_admin) {FactoryGirl.create(:student)}

    before { sign_in non_admin, no_capybara: true }

    describe "submitting a DELETE request to the Users#destroy action" do
      before {delete student_path(student)}
      specify { expect(response).to redirect_to(root_url) }
    end
  end
end
