class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :auth_token
      t.string :password_salt

      t.timestamps null: false
    end
  end
end
