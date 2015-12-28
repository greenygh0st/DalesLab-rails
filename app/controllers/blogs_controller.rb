class BlogsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update]

  def index
    @blogs = Blog.all
    @popularblogs = @blogs.sort_by do |item|
      item[:views]
    end
  end

  def show
    link = params[:urllink]
    @blog = Blog.find_by urllink: link
    @blog.views += 1 #update the number of post views by one
    @blog.save #if the save doesn't work just ignore it for now
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.urllink = @blog.title.downcase.gsub(/[^0-9A-Za-z]/, '').str.gsub(/\s/,'-').gsub!(/[-]+/, "-") #transform to lowercase, remove special characters, swap spaces for dashes and then strip repeated dashes
    if @blog.save
      #eventually trigger the notifications to others
      redirect_to @blog, :notice => 'Blog post created.'
    else
      render 'new'
    end
  end
end
