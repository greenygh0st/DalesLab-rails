class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :subtitle
      t.string :category # aka #infosec, #culture, #airsoft
      t.string :content
      t.string :kind_of #actual type: blog post, quote, tweet, etc...
      t.integer :views #gets incremented every time the page is viewed. Handled in the show controller

      t.string :urllink
      t.string :firstimage

      #t.boolean :published

      t.references :user
      t.timestamps null: false
    end
  end
end
