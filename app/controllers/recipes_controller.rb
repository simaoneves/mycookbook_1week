class RecipesController < ApplicationController

  def index
    @recipes = Recipe.visible
    @recipes.each do |recipe|
      recipe.description = recipe.description.truncate(120)
    end
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new()
  end

  def create

    file_to_upload = params[:recipe][:photo_url]
    hash_with_photo_path = file_to_upload ? upload_file(file_to_upload, 'uploads', :photo_url) : Hash.new

    @recipe = Recipe.new(recipe_params.merge(hash_with_photo_path))
    if @recipe.save
      redirect_to(@recipe, :notice => "Recipe successfully created!")
    else
      flash[:error] = "Something went wrong, please try again!"
      render 'new'
    end

  end

  def copy_recipe
    if params[:id].present?
      @recipe_copy = Recipe.find(params[:id])
      redirect_to(root_path, :error => "Wrong parameter") unless @recipe_copy.visible
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    @recipe = Recipe.find(params[:id])
    file_to_upload = params[:recipe][:photo_url]

    remove_file @recipe.photo_url if !@recipe.photo_url.empty? && file_to_upload
    hash_with_photo_path = file_to_upload ? upload_file(file_to_upload, 'uploads', :photo_url) : Hash.new    

    if @recipe.update_attributes(recipe_params.merge(hash_with_photo_path))
      redirect_to(@recipe, :notice => "Recipe successfully updated!")
    else
      flash[:error] = "Something went wrong with the update, please try again!"
      render 'edit'
    end
  end

  def destroy
    recipe = Recipe.find(params[:id]).destroy
    remove_file recipe.photo_url
    redirect_to(recipes_path, :notice => "Recipe #{recipe.name} successffully deleted!")
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :visible, :user_id, :photo_url)
  end

end
