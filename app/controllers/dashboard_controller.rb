class DashboardController < ApplicationController
	before_filter :authenticate_user!
	layout "dashboard"

	def index
	end
end
