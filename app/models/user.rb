# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  first_name      :string(255)
#  last_name       :string(255)
#  display_name    :string(255)
#  email           :string(255)
#  profile_picture :string(255)
#  facebook_id     :string(255)
#  facebook_token  :string(255)
#  token           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  has_many :items, foreign_key: 'owner_id'

  validates :facebook_id, uniqueness: true

  before_create :generate_token

  acts_as_voter

  def self.facebook_authenticate(facebook_id, facebook_token)
    graph = Koala::Facebook::API.new(facebook_token)
    profile = graph.get_object('me')
    return false unless profile['id'] == facebook_id
    u = where(facebook_id: facebook_id).first_or_create do |user|
      user.send(:initialize_from_profile, profile)
    end
    u.update_attribute(:facebook_token, facebook_token) && u
  rescue Koala::Facebook::AuthenticationError
    false
  end

  def add_status(items)
    vote_ids = votes.pluck(:votable_id).to_set
    items.each { |i| i.liked = vote_ids.include?(i.id) }
  end

  private

  def generate_token
    self.token = loop do
      token = SecureRandom.urlsafe_base64(40)
      break token unless User.exists?(token: token)
    end
  end

  def initialize_from_profile(profile)
    self.email           = profile['email']
    self.first_name      = profile['first_name']
    self.last_name       = profile['last_name']
    self.display_name    = profile['name']
    self.profile_picture = "//graph.facebook.com/#{facebook_id}/picture"
  end
end
