class StaticPagesController < ApplicationController

  def home
  	render :layout => false #Don't want to use the default layout for landing page
  end

  def about
  end

  def contact
  end
end
