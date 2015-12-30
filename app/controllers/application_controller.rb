class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    redirect_to '/login' unless current_user
  end

  def require_member
    redirect_to '/' unless current_user.editor?
  end

  def require_editor
    redirect_to '/' unless current_user.editor?
  end

  def require_admin
    redirect_to '/' unless current_user.admin?
  end

  def get_first_image string
    images = []
    linked = string.gsub( %r{http://[^\s<]+} ) do |url|
      if url[/(?:png|jpe?g|gif|svg)$/]
        images << url
      else
        #do nothing
      end
    end
    string = images[0]
  end

  def get_image_count(string)
    count = 0
    linked = string.gsub( %r{http://[^\s<]+} ) do |url|
      if url[/(?:png|jpe?g|gif|svg)$/]
        count += 1
      else
        #do nothing
      end
    end
    return count
  end

  def word_count(string)
    words = string.split(" ")
    return words.length
  end
end
