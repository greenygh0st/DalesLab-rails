class CreatePortfolios < ActiveRecord::Migration
  def change
    create_table :portfolios do |t|
      t.string :title
      t.string :description
      t.string :link, default: ""
      t.string :category

      t.references :user
      t.timestamps null: false
    end
  end
end
