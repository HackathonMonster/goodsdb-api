Cloudinary.config do |config|
  config.cloud_name = 'dtdu3sqtl'
  config.api_key = ENV['CLOUDINARY_API_KEY']
  config.api_secret = ENV['CLOUDINARY_API_SECRET']
  config.enhance_image_tag = true
  config.static_image_support = true
end
