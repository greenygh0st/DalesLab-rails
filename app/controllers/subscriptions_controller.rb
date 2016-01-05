class SubscriptionsController < ApplicationController
  def create #subscriptions/
    @subscription = Subscription.new(subscription_params)
    @subscription.verification_string = Digest::SHA256.hexdigest subscription_params[:email]
    @subscription.verified = false

    exists = Subscription.find_by verification_string: @subscription.verification_string

    if exists != nil #make sure it doesn't already exist people dont need to be getting duplicate emails
      render 'already_exists'
    else
      if @subscription.save
        #email the user through send grid here
        send_email(@subscription.email, "Email Verification", "<h1>Email Verification</h1><p>Thank you for signing up to receive my updates! Click <a href=\"http://localhost:3000/subscription/#{@subscription.verification_string}/verify\">here</a> to recieve update emails.</p><p>Thanks again!</p>")
        render 'verification'
      end
    end
  end

  def verify #subscriptions/:verify/verify
    email_hash = params[:verify]
    if /^[a-z0-9]+$/.match(email_hash) == nil
      #sec violation
      redirect_to :controller => 'pages', :action => 'secviolation'
    end

    @subscription = Subscription.find_by verification_string: email_hash
    if @subscription != nil
      @subscription.verified = true
      if @subscription.save
        #email the user through send grid here
        flash[:success] = "Your email #{@subscription.email} has been verified. Thanks for subscribing!"
        redirect_to :controller => 'blogs', :action => 'index'
      end
    else
      #subscription does not exist
      flash[:error] = "Email subscription not found."
      redirect_to :controller => 'blogs', :action => 'index'
    end
  end

  def delete #subscriptions/:verify/delete
    @subscription = Subscription.find(params[:verify]).delete
    @email = @subscription.email

    if @subscription.delete
      #email the user through send grid here
      send_email(@subscription.email, "Dale's Lab Subscription Removal Confirmation", "<h1>Subscription Removal Confirmation</h1><p>This is to confirm that your email has been removed from our subscriptions system.</p><p>Sorry to see you go!</p>")
      flash[:success] = "Subscription for #{@email} removed."
      redirect_to :controller => 'blogs', :action => 'index'
    else
      flash[:error] = "This subscription does not exist. Probably because it was already removed."
      redirect_to :controller => 'blogs', :action => 'index'
    end
  end

  private
  def subscription_params
    params.require(:subscription).permit(:email)
  end
end
