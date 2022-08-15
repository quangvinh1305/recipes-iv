module Recipes 
  class Show
  	prepend ::SimpleCommand
  	def initialize(recipe_params:)
      @recipe_params = recipe_params
  	end
    attr_reader :recipe_params
    def call
      recipe = approriate_recipe
      recipe.cooking_mode = cooking_mode?
      recipe.conver_to_unit = recipe_params[:conver_to_unit]
      recipe
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def approriate_recipe
      return cooking_mode if cooking_mode?
      non_cooking_mode
    end

    def cooking_mode 
      recipe = Recipe.includes(:steps, :ingredients, :author).find(recipe_params[:id])
      recipe.current_cooking_step = recipe.steps[recipe_params[:order].to_i] if recipe_params[:order].present?
      recipe
      # @recipe.ingredients = @recipe.ingredients.where(order: params[:order]) if params[:order].present?
    end

    def cooking_mode?
      recipe_params[:cooking_mode] == "1"
    end

    def non_cooking_mode
      recipe = Recipe.includes(:ingredients, :author).find(recipe_params[:id])
    end
  end
end