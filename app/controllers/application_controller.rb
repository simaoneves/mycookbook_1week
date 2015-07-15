class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  require 'fileupload.rb'
  include FileUpload

  def is_authenticated?
    !session[:user_id].blank? || !session[:user_name].blank?
  end

end
