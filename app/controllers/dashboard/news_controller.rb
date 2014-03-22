class Dashboard::NewsController < DashboardController
	include Dashboard::NewsHelper

	before_filter :authenticate_user!
	load_and_authorize_resource :find_by => :slug
	skip_authorize_resource :only => :show

	def index
		@news = News.where("user_id = ?", current_user.id)
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
		news = News.friendly.find(params[:id])
		news.destroy
		redirect_to dashboard_news_index_path
	end

	def edit
		@news = News.friendly.find(params[:id])
	end

	def update
		@news = News.friendly.find(params[:id])
		if @news.update(news_params)
			flash.notice = 'El artículo se actualizó con éxito!'
			redirect_to dashboard_news_path(@news)
		else
			render :edit
		end
	end
end
