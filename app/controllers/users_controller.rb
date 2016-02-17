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

  def list_hook_keys
    @keys = WebHookKey.all
    @newkey = WebHookKey.new
  end

  def create_hook_key
    @key = WebHookKey.new(key_params)
  end

  def destroy_hook_key
    @key = WebHookKey.find_by_id(params[:id])
    if @key.destroy
      flash[:success] = "WebHook key removed."
      redirect_to :action => 'list_hook_keys'
    else
      flash[:danger] = "ERROR: WebHook key could not be removed."
      redirect_to :action => 'list_hook_keys'
    end
  end

  private
  def key_params
    params.require(:web_hook_key).permit(:name)
  end

end
