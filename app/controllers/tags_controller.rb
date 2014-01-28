class TagsController < ApplicationController
 
	def show
		@tags = Tag.all
	  	@tag = Tag.find(params[:id])
	end

	def destroy
		@tag = Tag.find(params[:id])
		@tag.destroy

		redirect_to tags_path
	end
end
