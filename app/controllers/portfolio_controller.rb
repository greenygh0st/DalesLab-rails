class PortfolioController < ApplicationController
#this is pretty much a straight up rails conventions driven controller..nothing too crazy here. :)
  before_action :require_admin, only: [:new, :create, :edit, :update]

  def index
    @portfolio_items = Portfolio.all.order('created_at DESC')
  end

  def new
    @portfolio = Portfolio.new()
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user = current_user
    if @portfolio.save
      flash[:success] = "Portfolio item #{@portfolio.title.downcase} created."
      redirect_to action: 'index'
    else
      render 'new'
    end
  end

  def edit
    @portfolio = Portfolio.find_by id: params[:id]
  end

  def update
    @portfolio = Portfolio.find_by id: params[:id]
    if @portfolio.update_attributes(portfolio_params)
      flash[:success] = "Portfolio item #{@portfolio.title.downcase} updated."
      redirect_to action: 'index'
    else
      flash[:danger] = "ERROR: Portfolio item #{@portfolio.title.downcase} updated."
      render 'edit'
    end
  end

  def destroy
    @portfolio = Portfolio.find_by id: params[:id]
    if @portfolio.destroy
      flash[:success] = "Portfolio item removed."
      redirect_to action: 'index'
    else
      flash[:danger] = "ERROR: The portfolio item could not be removed."
    end
  end
  
  private
  def portfolio_params
    params.require(:portfolio).permit(:title, :image, :category, :description, :link)
  end
end
