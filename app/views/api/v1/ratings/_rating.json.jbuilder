json.extract! rating, :id, :recipe_id, :comment, :rate_value, :created_at, :updated_at
json.url api_v1_rating_url(rating, format: :json)

json.user do
	json.email rating.user.email
	json.nickname rating.user.nickname
	json.image rating.user.image
end