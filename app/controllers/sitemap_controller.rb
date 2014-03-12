class SitemapController < ApplicationController
  respond_to :xml
  def index
  	@static_pages = [about_url, ideastartup_url]
    @news = News.order("created_at DESC")
  end
end
