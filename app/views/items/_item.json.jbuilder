json.call(item, :id, :name, :liked, :likes_count)

json.tags item.tags, :id, :name, :created_at, :updated_at
json.pictures item.pictures, :id, :image_url, :image_info, :created_at, :updated_at
