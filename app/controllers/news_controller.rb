class NewsController < ApplicationController
  
  def index
  	@tags = Tag.all
  	@news = News.all
  end

  def show
  	@news = News.friendly.find(params['id'])
  end
  
end
