class StaticPagesController < ApplicationController
  def home
  	@news = News.find(:all, :limit => 10, :order => "created_at DESC")
  end

  def about
  end

  def ideastartup
  end

end
