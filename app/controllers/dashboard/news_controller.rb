class Dashboard::NewsController < ApplicationController
	include Dashboard::NewsHelper

	layout "dashboard"

	def index
		@news = News.all
	end

	def show
		@news = News.find(params[:id])
	end

	def new
		@news = News.new
	end

	def create
		@news = News.new(news_params)
		@news.save

		redirect_to dashboard_news_path(@news)
	end

end
