class Dashboard::NewsController < DashboardController
	include Dashboard::NewsHelper

	load_and_authorize_resource :find_by => :slug
	skip_authorize_resource :only => :show
	before_filter :authenticate_user!, :except => [:show, :index]

	def index
		@news = News.all
	end

	def show
		@news = News.friendly.find(params[:id])
	end

	def new
		@news = News.new
	end

	def create
		@news = News.new(news_params)
		@news.user_id = current_user.id
		if @news.save
			redirect_to dashboard_news_path(@news)
		else
			render :new
		end
	end

	def destroy
		news = News.find(params[:id])
		news.destroy
		redirect_to dashboard_news_index_path
	end

	def edit
		@news = News.friendly.find(params[:id])
	end

	def update
		@news = News.friendly.find(params[:id])
		if @news.update(news_params)
			flash.notice = 'News #{news.title} Updated!'
			redirect_to dashboard_news_path(@news)
		else
			render :edit
		end
	end
end
