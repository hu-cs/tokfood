json.array!(@recipes) do |recipe|
  json.extract! recipe, :id, :title, :creator, :url, :ingredients, :serving, :notes
  json.url recipe_url(recipe, format: :json)
end
