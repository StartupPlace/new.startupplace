class NewsController < ApplicationController
  def index
  	@news = News.all
  end

  def show
  end
end
