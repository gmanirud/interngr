class StaticPagesController < ApplicationController

  def student_landing_page
  	render :layout => false #Don't want to use the default layout for landing page
  end

   def recruiter_landing_page
  	render :layout => false #Don't want to use the default layout for landing page
  end

  def about
  end

  def contact
  end

end
