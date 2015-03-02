class AddColumnPhotoUrlToRecipes < ActiveRecord::Migration

  def change
    add_column("recipes", "photo_url", :string, {:null => false} )
  end

end
