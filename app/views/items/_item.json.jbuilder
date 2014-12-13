json.call(item, :id, :name)

json.tags item.tags, :id, :name, :created_at, :updated_at
json.pictures item.pictures, :id, :image_url, :created_at, :updated_at
