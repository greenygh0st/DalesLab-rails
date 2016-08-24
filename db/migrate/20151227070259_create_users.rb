class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.string :role
      t.string :image
      t.string :auth_secret #for two factor
      t.boolean :use_two_factor, default:false
      t.integer :login_attempts, default:0
      t.boolean :account_locked, default:false
      t.timestamps null: false
    end
  end
end
