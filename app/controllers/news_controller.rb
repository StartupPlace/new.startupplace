class NewsController < ApplicationController
  
  def index
  	@tags = Tag.all
  	@news = News.find(:all, :order => "created_at DESC")
  end

  def show
  	@news = News.friendly.find(params['id'])
  end
  
end
