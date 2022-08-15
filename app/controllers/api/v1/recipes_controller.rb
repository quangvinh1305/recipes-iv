class Api::V1::RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_recipe, only: %i[ edit update destroy ]
  # before_action :show_recipe, only: %i[ show ]
  before_action :authenticate_user!, only: [:create, :update, :destroy]

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = ::Recipes::Show.call(recipe_params: params).result
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end


  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.json { render :show, status: :created, location: api_v1_recipe_url(@recipe) }
      else
        # format.html { render :new, status: :unprocessable_entity }
        render json: @recipe.errors, status: :unprocessable_entity
      end
    end
  end


  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to api_v1_recipe_url(@recipe), notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to api_v1_recipe_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    # def show_recipe
    #   @cooking_mode = params[:cooking_mode] == "1"
    #   return cooking_mode if params[:cooking_mode] == "1"
    #   non_cooking_mode
    # end

    # def cooking_mode 
    #   @recipe = Recipe.includes(:steps, :ingredients, :author).find(params[:id])
    # end

    # def non_cooking_mode
    #   @recipe = Recipe.includes(:ingredients, :author).find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def recipe_params
       params.require(:recipe).permit(:name, :id, :notes, steps_attributes: [:id, :description, :_destroy, ingredients_attributes: [:id, :amount, :unit, :name, :_destroy]]).merge(user_id: current_user.id)
    end
end
