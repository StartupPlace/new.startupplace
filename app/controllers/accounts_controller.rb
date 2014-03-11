class AccountsController < ApplicationController
	layout "dashboard"
  def show
  	@user = User.find_by! username: params[:username]
  end
end

