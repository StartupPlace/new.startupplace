class NewsController < ApplicationController
  def index
  	@tags = Tag.all
  	@news = News.all
  end

  def show
  	@news = News.find(params['id'])
  end
end
