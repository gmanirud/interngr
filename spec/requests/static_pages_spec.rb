require 'spec_helper'

describe "StaticPages" do

	describe "Landing page" do
		it "should have content 'multimedia platform'" do
		  visit root_path
		  expect(page).to have_content('multimedia platform')
		end

	    it "should have base title 'Interngration'" do
	    	visit root_path
	    	expect(page).to have_title('Interngration')
	    end

    end

    describe "Contact Page" do
		it "should have the title 'Contact Us | Interngration'" do
		  visit contact_path
		  expect(page).to have_content('Contact')
		end

	    it "should have title 'Contact Us'" do
		  visit contact_path
	      expect(page).to have_title('Contact Us | Interngration')
	    end
    end

    describe "About Us Page" do
		it "should have the title 'About Us | Interngration'" do
		  visit about_path
		  expect(page).to have_content('About')
		end

	    it "should have title 'About Us'" do
	    	visit about_path
	    	expect(page).to have_title('About Us | Interngration')
	    end
    end


end
