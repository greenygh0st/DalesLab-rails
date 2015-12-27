class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
  end

  def show
    @blog = Blog.find(params(:id))
  end

  def new
  end

  def create
  end
end
