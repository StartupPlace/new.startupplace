class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :get_layout

	def get_layout
		module_name = self.class.to_s.split("::").first
		return (module_name.eql?("Devise") ? "dashboard" : "application")
	end
end
