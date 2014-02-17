json.array!(@pesos) do |peso|
  json.extract! peso, 
  json.url peso_url(peso, format: :json)
end
