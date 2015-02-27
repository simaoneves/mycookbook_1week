class RecipesController < ApplicationController

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.find(params[:id])
  end

  def new
    @recipe = Recipe.new()
  end

  def create
    @recipe = Recipe.new(recipe_params)
    if @recipe.save
      redirect_to(@recipe, :notice => "Recipe Successfully created!")
    else
      flash[:error] = "Something went wrong, please try again!"
      render 'new'
    end
  end

  def edit
    @recipe = Recipe.find(params[:id])
  end

  def update
    
  end

  def delete
    
  end

  def destroy
    
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :visible)
  end

end
