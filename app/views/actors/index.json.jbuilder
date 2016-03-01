json.array!(@actors) do |actor|
  json.extract! actor, :id, :name, :wiki
  json.url actor_url(actor, format: :json)
end
