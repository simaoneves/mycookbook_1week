class RecipesController < ApplicationController

  def index
    @recipes = Recipe.visible
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new()
  end

  def create
    upload_file :recipe if params[:recipe][:photo_url]

    @recipe = Recipe.new(recipe_params.merge($photo))
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

    if params[:recipe][:photo_url]
      remove_file @recipe.photo_url unless @recipe.photo_url.empty?
      upload_file :recipe
    end

    if @recipe.update_attributes(recipe_params.merge($photo))
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

  def remove_file(file)
    File.delete("./public#{file}")
  end

  def rename_file(file)
    Time.now.strftime("%Y%m%d-%H%M%S-") + file.gsub(" ", "_")
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :visible, :user_id, :photo_url)
  end

end
