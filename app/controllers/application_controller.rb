require 'sendgrid-ruby'
include SendGrid

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :require_user
  helper_method :require_member
  helper_method :require_editor
  helper_method :require_admin

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    if !current_user
      redirect_to '/login?redirect_to=#{params[:redirect_to]}'
    else
      flash[:danger] = "You are not authorized to view that page."
      redirect_to '/'
    end
  end

  def require_member
    if !current_user
      redirect_to '/login?redirect_to=#{params[:redirect_to]}'
    elsif (current_user && !(!current_user.member? || !current_user.admin?))
      redirect_to '/membership'
    end
  end

  def require_editor
    redirect_to '/' unless current_user && current_user.editor?
  end

  def require_admin
    redirect_to '/' unless current_user && current_user.admin?
  end

  def get_first_image string
    doc = Nokogiri::HTML( string )
    img_srcs = doc.css('img').map{ |i| i['src'] }
    string = img_srcs[0]
  end

  def get_all_images string
    doc = Nokogiri::HTML( string )
    img_srcs = doc.css('img').map{ |i| i['src'] }
    return img_srcs
  end

  def get_image_count(string)
    doc = Nokogiri::HTML( string )
    img_srcs = doc.css('img').map{ |i| i['src'] }
    return img_srcs.count
  end

  def word_count(string)
    words = string.split(" ")
    return words.length
  end

  def send_email(to, subject, message)
    #message.gsub!('localhost:3000', 'daleslab.com') if ENV["RAILS_ENV"] != nil && ENV["RAILS_ENV"] == 'production'
    data = JSON.parse('{
      "personalizations": [
        {
          "to": [
            {
              "email": "'+to+'"
            }
          ],
          "subject": "Dale\'s Lab - '+subject+'"
        }
      ],
      "from": {
        "email": "noreply@daleslab.com"
      },
      "content": [
        {
          "type": "text/html",
          "value": "'+message+'<p><b><strong>Please do not reply to this email.</strong></b><p/><p>Sincerely,</p><p>Dale</p>"
        }
      ]
    }')
    sg = SendGrid::API.new(api_key: ENV['DALESLAB_SENDGRID_API_KEY'])
    response = sg.client.mail._('send').post(request_body: data)
    puts response.status_code
    puts response.body
    puts response.headers

    if response.status_code.to_i == 202 || response.status_code.to_i == 200
      puts 'Email sent successfully.'
      return true
    else
      return false
    end
    #ENV['DALESLAB_SENDGRID_API_KEY']
  end

end
