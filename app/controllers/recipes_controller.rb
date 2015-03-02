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

    uploaded_io = params[:recipe][:photo_url]
    file_path = treat_file_name uploaded_io.original_filename
    File.open(Rails.root.join('public', 'uploads', file_path), 'wb') do |file|
      file.write(uploaded_io.read)
    end

    photo = Hash.new()
    photo[:photo_url] = '/uploads/' + file_path

    final_hash = recipe_params.merge(photo)

    @recipe = Recipe.new(final_hash)
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
    if @recipe.update_attributes(recipe_params)
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

  def treat_file_name(file)
    Time.now.strftime("%Y%m%d-%H%M%S-") + file.gsub(" ", "_")
  end

  def recipe_params
    params.require(:recipe).permit(:name, :description, :visible, :user_id, :photo_url)
  end

end
