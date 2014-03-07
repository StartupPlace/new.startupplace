class AccountsController < ApplicationController
	layout "dashboard"
  def show
  	@user = User.find(params[:id])
  end
end

