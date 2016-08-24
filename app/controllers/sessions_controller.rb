class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      if @user.use_two_factor
        if @user.two_factor_valid(params[:session][:code])
          session[:user_id] = @user.id
          if !(params[:redirect_to])
            redirect_to '/'
          else
            redirect_to params[:redirect_to]
          end
        else
          #@user.increment_login_attempts
          flash[:danger] = "Two factor authentication is enabled for this account. Incorrect token provided. Please try again."
          redirect_to '/login'
        end
      else
        session[:user_id] = @user.id
        if !(params[:redirect_to])
          redirect_to '/'
        else
          redirect_to params[:redirect_to]
        end
      end
    else
      if @user
        #@user.increment_login_attempts
        send_email(@user.email, "Dales Lab - Account Access", "Someone attempted to log into your account but the incorrect password was entered. If this was you please disregard this email.")
      end
      flash[:danger] = "Incorrect username/password provided."
      redirect_to '/login'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end
end
