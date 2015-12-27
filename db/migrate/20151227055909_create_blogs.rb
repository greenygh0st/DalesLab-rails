class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :title
      t.string :subtitle
      t.string :category
      t.string :content
      t.string :type
      t.timestamps null: false
    end
  end
end
