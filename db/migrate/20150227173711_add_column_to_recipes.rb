class AddColumnToRecipes < ActiveRecord::Migration

  def change
    add_column("recipes", "user_id", :integer, {:null => false} )
  end

end
