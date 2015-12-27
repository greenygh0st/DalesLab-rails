class BlogsController < ApplicationController
  def index
    @blogs = Blog.all
    @popularblogs = @blogs.sort_by do |item|
      item[:views]
    end
  end

  def show
    @blog = Blog.find_by :urllink params(:urllink)
    @blog.views += 1 #update the number of post views by one
    @blog.save #if the save doesn't work just ignore it for now
  end

  def new
    @blog = Blog.new
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.urllink = @blog.title.gsub(/[^0-9A-Za-z]/, '').str.gsub(/\s/,'-').gsub!(/[-]+/, "-") #remove special characters, swap spaces for dashes and then strip extra dashes
    if @blog.save
      #eventually trigger the notifications to others
      redirect_to '/[:urllink]'
  end
end
