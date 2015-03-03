class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def is_authenticated?
    !session[:user_id].blank? || !session[:user_name].blank?
  end

  def upload_file(object)
    uploaded_io = params[object][:photo_url]
    file_path = rename_file uploaded_io.original_filename
    File.open(Rails.root.join('public', 'uploads', file_path), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    # Global variables start with $
    $photo = Hash.new()
    $photo[:photo_url] = '/uploads/' + file_path
  end

end
