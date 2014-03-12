xml.instruct!
 
xml.urlset(xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9") do
  xml.url do
    xml.loc root_url
    xml.changefreq("hourly")
    xml.priority "1.0"
  end
  @static_pages.each do |page_url|
    xml.url do
      xml.loc page_url
      xml.changefreq("monthly")
    end
  end
  @news.each do |news|  
    xml.url do
      xml.loc news_url(news)
      xml.changefreq("daily")
      xml.priority "0.8"
      xml.lastmod news.updated_at.strftime("%Y-%m-%dT%H:%M:%S.%2N%:z")
    end
  end
end