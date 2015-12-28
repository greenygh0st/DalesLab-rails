class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :email
      t.string :verification_string
      t.boolean :verified
      t.timestamps null: false
    end
  end
end
