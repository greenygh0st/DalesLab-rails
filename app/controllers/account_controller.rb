class AccountController < ApplicationController
  helper_method :google_authenticator_qrcode

  #/account/change_password GET
  def change_password
  end

  #/account/change_password POST
  def update_password
    if current_user && current_user.authenticate(params[:password_change][:password])
      current_user.password = params[:password_change][:new_password]
      current_user.password_confirmation = params[:password_change][:password_confirmation]
      if current_user.save
        flash[:info] = "Password updated."
        redirect_to '/account/change_password'
      else
        flash[:danger] = "Password could not be updated."
      end
    else
      flash[:danger] = "Password could not be updated."
    end
  end

  #/account/enable_tfa GET
  def enable_tfa
    #show Google image and require current password
    if current_user.auth_secret == nil
      current_user.assign_auth_secret
      if !current_user.save
        #redirect_to verify_tfa
        flash[:danger] = "New auth_secret could not be saved."
      end
    end
  end

    #/account/enable_tfa POST
  def enable_tfa_post
    if current_user && current_user.authenticate(params[:enable_tfa][:password])
      redirect_to "/account/verify_tfa"
    else
      flash[:danger] = "Incorrect password. You have been logged out."
      session[user_id] = nil
      redirect_to '/'
    end
  end

  #/account/disable_tfa POST
  def disable_tfa
    #disable TFA boolean and blank out auth_secret
    #not implemented
  end

  #/account/verify_tfa GET
  def verify_tfa
    #try entering the code from the authenticator and we will see if it is correct
  end

  #/account/verify_tfa POST
  def verify_tfa_post
    #if we get the right code back then actually enable tfa
    if current_user.two_factor_valid(params[:tfa][:code])
      current_user.use_two_factor = true
      if current_user.save
        #redirect_to based enable_tfa
        redirect_to '/account/enable_tfa'
      else
        flash[:warning] = "TFA could not be enabled."
      end
    else
      flash[:danger] = "Incorrect code please try again!"
    end
  end

  def google_authenticator_qrcode(user)
    data = "otpauth://totp/daleslab?secret=#{user.auth_secret}"
    data = Rack::Utils.escape(data)
    return "https://chart.googleapis.com/chart?chs=200x200&chld=M|0&cht=qr&chl=#{data}"
  end

  def forgot_password
    #@user = User.new()
  end

  def forgot_password_create
    o = [('a'..'z'), ('A'..'Z')].map { |i| i.to_a }.flatten
    #string = (0...50).map { o[rand(o.length)] }.join
    #Digest::SHA256.hexdigest (0...50).map { o[rand(o.length)] }.join
    @user = User.find_by email: forgot_params[:email]
    if @user != nil && (!@user.use_two_factor || (@user.use_two_factor && @user.two_factor_valid(params[:code])))
      @user.password_reset_token = Digest::SHA256.hexdigest (0...50).map { o[rand(o.length)] }.join
      if @user.save
        send_email(@user.email, "Dale's Lab - Forgotten Password", "<h1>Forgot Your Password..?</h1><p>No worries. Just click the link below and you will be able to reset your password.</p><p><a href=\'http://localhost:3000/password-reset/#{@user.password_reset_token}\'>Password Reset</a></p>")
        flash[:success] = "If your email exists in our system you will receive an email with intructions on how to reset your password shortly."
        redirect_to '/login'
      else
        flash[:danger] = "An error occured and a password reset request could not be created."
        redirect_to '/login'
      end
    else
      flash[:success] = "If your email exists in our system you will receive an email with intructions on how to reset your password shortly."
      redirect_to '/login'
    end
  end

  def password_reset
    #render form
    link = params[:password_reset_token]
    if /^[a-z0-9]+$/.match(link) == nil
      flash[:danger] = "Invalid password reset token."
      redirect_to '/login'
    else
      @user = User.find_by password_reset_token: link
      @id = link
      if @user != nil
        render 'password_reset'
      else
        flash[:danger] = "Either this user does not exist or no password request was requested."
        redirect_to '/login'
      end
    end
  end

  def password_reset_do
    link = params[:password_reset_token]
    if /^[a-z0-9]+$/.match(link) == nil
      flash[:danger] = "Invalid password reset token."
      redirect_to '/login'
    else
      @user = User.find_by password_reset_token: link
      if @user != nil
        @user.update_attributes(reset_params)
        @user.password_reset_token = ""
        @user.save
        flash[:success] = "Password reset successful. Please login below."
        redirect_to '/login'
      else
        flash[:danger] = "Either this user does not exist or no password request was requested."
        redirect_to '/login'
      end
    end
  end

  #form accept params
  private
  def reset_params
    params.require(:user).permit(:password, :password_confirmation, :password_reset_token)
  end
  private
  def forgot_params
    params.require(:forgot_password).permit(:email, :code)
  end

end
