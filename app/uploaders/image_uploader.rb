class ImageUploader < CarrierWave::Uploader::Base
  include ::CarrierWave::Backgrounder::Delay
  include Cloudinary::CarrierWave
end
