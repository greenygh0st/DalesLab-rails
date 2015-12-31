class BlogsController < ApplicationController
  before_action :require_admin, only: [:new, :create, :edit, :update]

  def index
    @blogs = Blog.all.order('created_at DESC')
    @popularblogs = @blogs.where(["kind_of != ? ", "quote"]).take(3).sort_by do |item|
      item[:views]
    end
    #need to get the top 5 most common tags
      rawtags = []
      tags = Hash.new(0)

      @blogs.each do |blog|
        (rawtags << blog.category.split(" ")).flatten! #get a list of every tag ever used
      end

      rawtags.each do |tag|
          tags[tag] += 1 #key is the word, count is the value
      end

      tags = tags.sort_by do |tag, count|
          count
      end
      @commontags = tags.reverse.first(20)
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
    @blog = Blog.new()
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.urllink = @blog.title.downcase.gsub(/[^0-9A-Za-z ]/, '').sub(/\s+\Z/, "").gsub(' ','-').gsub(/[-]+/, "-") #transform to lowercase, remove special characters, swap spaces for dashes and then strip repeated dashes
    @blog.firstimage = get_first_image(@blog.content) #should work...
    #how to determine type (kind_of) of post (blog, singleimage, slideshow, quote)
    #blog = 1-2 photos more than 50 words in post, content field not empty
    #single image = 1-2 photos less than 50 words in post, content field not empty
    #slideshow = more than 4 photos in a post, content field not empty
    #quote = content field is empty
    images_c = get_image_count(@blog.content)
    words_c = word_count(@blog.content)
    if words_c == 0
      @blog.kind_of = "quote"
    elsif words_c > 0 && words_c <= 25 && images_c < 4
      @blog.kind_of = "singleimage"
    elsif words_c > 25 && images_c < 4
      @blog.kind_of = "blog"
    elsif words_c > 0 && images_c >= 4
      @blog.kind_of = "slideshow"
    end

    #information that we need to update to prevent errors :)
    @blog.views = 0
    @blog.allow_comments = true
    @blog.is_published = true
    @blog.user = current_user #set the current user as the blogs author

    if @blog.save
      #eventually trigger the notifications to others
      redirect_to action: "show", urllink: @blog.urllink, :notice => 'Blog post created successfully.'
    else
      render 'new'
    end
  end

  def edit
    #find the post and attach it to the form
    link = params[:urllink]
    @blog = Blog.find_by urllink: link
  end

  def update
    #find the post
    link = params[:urllink]
    @blog = Blog.find_by urllink: link

    #update the things we deterine
    @blog.urllink = blog_params[:title].downcase.gsub(/[^0-9A-Za-z ]/, '').sub(/\s+\Z/, "").gsub(' ','-').gsub(/[-]+/, "-") #transform to lowercase, remove special characters, swap spaces for dashes and then strip repeated dashes
    @blog.firstimage = get_first_image(blog_params[:content]) #should work...
    #how to determine type (kind_of) of post (blog, singleimage, slideshow, quote)
    #blog = 1-2 photos more than 50 words in post, content field not empty
    #single image = 1-2 photos less than 50 words in post, content field not empty
    #slideshow = more than 4 photos in a post, content field not empty
    #quote = content field is empty
    images_c = get_image_count(blog_params[:content])
    words_c = word_count(blog_params[:content])
    if words_c == 0
      @blog.kind_of = "quote"
    elsif words_c > 0 && words_c <= 25 && images_c < 4
      @blog.kind_of = "singleimage"
    elsif words_c > 25 && images_c < 4
      @blog.kind_of = "blog"
    elsif words_c > 0 && images_c >= 4
      @blog.kind_of = "slideshow"
    end
    #err
    #@blog.user = current_user #set the current user as the blogs author - should do an edited by thing later
      if @blog.update_attributes(blog_params)
        redirect_to action: "show", urllink: @blog.urllink, :notice => 'Blog post updated successfully.'
      else
        render 'edit'
      end
  end

  private
  def blog_params
    params.require(:blog).permit(:title, :subtitle, :top_image, :category, :content)
  end

end
