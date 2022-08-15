json.extract! recipe, :id, :name, :notes, :created_at, :updated_at
json.url api_v1_recipe_url(recipe, format: :json)

json.author do 
	json.email recipe.author.email
end