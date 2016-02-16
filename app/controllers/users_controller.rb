class UsersController < ApplicationController
before_action :require_admin
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create

  end

  def destroy
    
  end
end
