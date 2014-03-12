class AccountsController < ApplicationController
	layout "account"
  def show
  	@user = User.find_by! username: params[:username]
  	if current_user
  		@is_owner = current_user.username == params[:username] ? true : false
  	else
  		@is_owner = false
  	end
  end
end

