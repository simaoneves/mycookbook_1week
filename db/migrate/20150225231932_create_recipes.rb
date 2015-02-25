class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.boolean :visible, :default => true
      t.text :description, :limit => 2048
      t.string :name, :null => false, :limit => 60

      t.timestamps null: false
    end
  end
end