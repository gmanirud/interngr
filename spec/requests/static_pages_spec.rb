require 'spec_helper'

describe "StaticPages" do

	describe "Landing page" do
		it "should have the title 'Interngration - Multimedia platform to'" do
		  visit '/static_pages/home'
		  expect(page).to have_content('Interngration - Multimedia platform')
		end
    end

    describe "Contact Page" do
		it "should have the title 'Contact Us- Interngration'" do
		  visit '/static_pages/contact'
		  expect(page).to have_content('Contact')
		end
    end

    describe "About Us Page" do
		it "should have the title 'About Us - Interngration'" do
		  visit '/static_pages/about'
		  expect(page).to have_content('About')
		end
    end


end


