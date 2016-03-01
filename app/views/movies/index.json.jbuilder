json.array!(@movies) do |movie|
  json.extract! movie, :id, :name, :description, :production_year
  json.url movie_url(movie, format: :json)
end
