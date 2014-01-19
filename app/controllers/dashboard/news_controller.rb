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

	def destroy
		news = News.find(params[:id])
		news.destroy
		redirect_to dashboard_news_index_path
	end

	def edit
		@news = News.find(params[:id])
	end

	def update
		@news = News.find(params[:id])
		@news.update(news_params)

		flash.notice = 'News #{news.title} Updated!'

		redirect_to dashboard_news_path(@news)
	end

end
