class SubscriptionsController < ApplicationController
  def create #subscriptions/
    @subscription = Subscription.new(subscription_params)
    @subscription.verification_string = Digest::SHA256.hexdigest subscription_params[:email]
    @subscription.verified = false

    exists = Subscription.find_by verification_string: @subscription.verification_string

    if exists != nil #make sure it doesn't already exist people dont need to be getting duplicate emails
      render 'aready_exists'
    else
      if @subscription.save
        #email the user through send grid here
        render 'verification'
      end
    end
  end

  def verify #subscriptions/:verify/verify
    email_hash = params[:verify]
    if /^[a-z0-9]+$/.match(email_hash)
      #sec violation
      redirect_to :controller => 'pages', :action => 'secviolation'
    end

    @subscription = Subscription.find_by verification_string: email_hash
    if @subscription != nil
      @subscription.verified = true
      if @subscription.save
        #email the user through send grid here
        render 'verify_success'
      end
    else
      #subscription does not exist
      render 'no_subscription'
    end
  end

  def delete #subscriptions/:verify/delete
    @subscription = Subscription.find(params[:verify]).delete
    @email = @subscription.email

    if @subscription.delete
      #email the user through send grid here
      render 'sub_removed'
    else
      render 'no_subscription'
    end
  end

  private
  def subscription_params
    params.require(:subscription).permit(:email)
  end
end
