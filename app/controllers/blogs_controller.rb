class BlogsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update]

  def index
    @blogs = Blog.all
    @popularblogs = @blogs.take(3).sort_by do |item|
      item[:views]
    end
    #need to get the top 5 most common tags
      rawtags = []
      tags = Hash.new(0)

      @blogs.each do |blog|
        (rawtags << blog.category.split(" ")).flatten!
      end

      rawtags.each do |tag|
          tags[tag] += 1 #key is the word, count is the value
      end

      tags = tags.sort_by do |tag, count|
          count
      end
      @commontags = tags.reverse #.first(5) #may want to limit in the future??
    #then this goes in the view
    #<% @commontags.each do |t, f| %>
    #<%= t %>
    #<% end %>
    #end of getting the most common tags

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
    @blog.firstimage = get_first_image(@blog.content) #should work...
    #how to determine type (kind_of) of post (blog, singleimage, slideshow, quote)
    #blog = 1-2 photos more than 50 words in post, content field not empty
    #single image = 1-2 photos less than 50 words in post, content field not empty
    #slideshow = more than 4 photos in a post, content field not empty
    #quote = content field is empty
    images_c = get_image_count(@blog.content)
    words_c = word_count(@blog.content)
    if words == 0
      @blog.kind_of = "quote"
    elsif words_c > 0 && words_c <= 50 && images_c < 4
      @blog.kind_of = "singleimage"
    elsif words_c > 50 && images_c < 4
      @blog.kind_of = "blog"
    elsif words_c > 0 && images_c >= 4
      @blog.kind_of = "slideshow"
    end

    if @blog.save
      #eventually trigger the notifications to others
      redirect_to @blog, :notice => 'Blog post created.'
    else
      render 'new'
    end
  end
end
