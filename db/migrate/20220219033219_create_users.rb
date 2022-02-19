class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :password, null: false
      t.string :photo
      t.datetime :discarded_at
      t.index :discarded_at
      t.timestamps
    end
    end
  end

