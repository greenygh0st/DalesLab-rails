class WebHooksController < ApplicationController
  respond_to :json #make sure our controller only responds to JSON requests
  def Twitter
    auth_key = request.headers["Hook-Auth"]
    if WebHookKey.find_by_key(auth_key)
      #create a quote post
      #for now we just want to log the request body
      Rails.logger.info "Woot! The webhook got called: #{Time.now.year}"
    else
      #do nothing for now...maybe log it later??
      render head :unauthorized, :status => :unauthorized
    end
  end

  #TODO Add more awesome hooks. :)
end
