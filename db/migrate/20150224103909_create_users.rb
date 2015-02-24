class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name, :limit => 20
      t.string :last_name, :limit => 20
      t.string :email, :limit => 35
      t.string :password_digest
      t.text :bio, :default => "Hi, i'm your Biography, update me please!"

      t.timestamps null: false
    end
  end
end
