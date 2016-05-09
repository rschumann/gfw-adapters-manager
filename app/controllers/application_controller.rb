class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  http_basic_authenticate_with name: ENV['MANAGER_USER'], password: ENV['MANAGER_PASSWORD'] if ENV['MANAGER_ACCESS'].present? && ENV['MANAGER_ACCESS'].include?('private')

  protect_from_forgery with: :exception
end
