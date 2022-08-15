json.extract! recipe, :id, :name, :notes, :created_at, :updated_at, :current_cooking_step
json.cooking_steps recipe.steps if recipe.cooking_mode

json.author do 
	json.email recipe.author.email
end

json.ingredients do 
	json.array! recipe.ingredients_converted, :unit_processed, :name, :amount, :unit, :step_id
end

json.url api_v1_recipe_url(recipe, format: :json)