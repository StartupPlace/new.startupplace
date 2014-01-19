module Dashboard::NewsHelper

	def news_params
		params.require(:news).permit(:title, :body)
	end

end
