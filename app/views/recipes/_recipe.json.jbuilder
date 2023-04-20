json.extract! recipe, :id, :user_id, :name, :prep_time, :cook_time, :description, :public, :created_at, :updated_at
json.url recipe_url(recipe, format: :json)
