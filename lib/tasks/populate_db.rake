namespace :db do
  include FactoryGirl::Syntax::Methods

  desc 'Populates the DB with dummy data'
  task populate: :environment do
    next if User.exists?(token: 'dummy_token')
    data = Settings.user.dummy_facebook_data
    user = build(:user, facebook_id: data.facebook_id, facebook_token: data.facebook_token)
    user.send(:initialize_from_profile, data.info)
    user.save!
    user.update_attribute(:token, 'dummy_token')
  end
end
