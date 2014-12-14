# == Schema Information
#
# Table name: pictures
#
#  id         :integer          not null, primary key
#  image      :string(255)
#  item_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Picture < ActiveRecord::Base
  belongs_to :item

  validates :item, presence: true

  mount_uploader :image, ImageUploader
  store_in_background :image

  after_commit :save_info

  def self.build_all(images, item)
    return none if images.blank?
    images.map do |image|
      item.pictures.build(image: image)
    end
  end

  def image_info
    @image_info ||= JSON.parse(info || '{}')
  end

  private

  def fetch_info
    @client ||= DocomoImageRecognition::Client.new(ENV['DOCOMO_API_KEY'])
    @client.recognize_from_url(image_url)
  rescue DocomoImageRecognition::ApiError => e
    logger.error e.body
    {}
  end

  def save_info
    return if image_processing
    update_attribute(:info, JSON.dump(fetch_info))
  end
end
