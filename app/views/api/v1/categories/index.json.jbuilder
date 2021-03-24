json.categories @categories.each do |category|
  json.call(category,
            :id,
            :name,
            :created_at,
            :updated_at)
end
