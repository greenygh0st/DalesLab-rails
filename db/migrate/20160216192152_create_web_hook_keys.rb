class CreateWebHookKeys < ActiveRecord::Migration
  def change
    create_table :web_hook_keys do |t|
      t.string :name
      t.string :key
      t.timestamps null: false
    end
  end
end
