module Dashboard::NewsHelper

	def news_params
		params.require(:news).permit(:title, :body, :tag_list, :image)
	end

end
