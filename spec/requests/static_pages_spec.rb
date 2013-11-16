require 'spec_helper'

describe "StaticPages" do

	describe "Landing page" do
		it "should have content 'Multimedia platform'" do
		  visit '/static_pages/home'
		  expect(page).to have_content('Multimedia platform to connect startups with students')
		end

	    it "should have base title 'Interngration'" do
	    	visit '/static_pages/home'
	    	expect(page).to have_title('Interngration')
	    end

    end

    describe "Contact Page" do
		it "should have the title 'Contact Us | Interngration'" do
		  visit '/static_pages/contact'
		  expect(page).to have_content('Contact')
		end

	    it "should have title 'Contact Us'" do
	    	visit '/static_pages/contact'
	    	expect(page).to have_title('Contact Us | Interngration')
	    end
    end

    describe "About Us Page" do
		it "should have the title 'About Us | Interngration'" do
		  visit '/static_pages/about'
		  expect(page).to have_content('About')
		end

	    it "should have title 'About Us'" do
	    	visit '/static_pages/about'
	    	expect(page).to have_title('About Us | Interngration')
	    end
    end


end
