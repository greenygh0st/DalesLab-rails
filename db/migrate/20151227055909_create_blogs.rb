class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      #information we get from the user
      t.string :title
      t.string :subtitle
      t.string :category # aka #infosec, #culture, #airsoft (seperate with spaces)
      t.string :content
      t.boolean :is_published, default:false
      t.boolean :friends_and_family, default: false
      t.boolean :allow_comments, default: false
      t.string :top_image
      #information we generate
      t.string :kind_of #actual type: blog post, quote, tweet, etc...
      t.integer :views #gets incremented every time the page is viewed. Handled in the show controller

      t.string :urllink
      t.string :firstimage

      t.references :user

      t.datetime :published_at
      t.timestamps null: false
    end
  end
end
