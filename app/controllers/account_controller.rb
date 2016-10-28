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

end
