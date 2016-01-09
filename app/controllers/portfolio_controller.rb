class PortfolioController < ApplicationController
  def index
    @portfolio_items = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new()
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user = current_user
    if @portfolio.save
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
      redirect_to action: 'index'
    else
      render 'edit'
    end
  end

  private
  def portfolio_params
    params.require(:portfolio).permit(:title, :image, :description, :link)
  end
end
