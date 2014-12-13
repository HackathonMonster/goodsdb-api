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
#  created_at      :datetime
#  updated_at      :datetime
#

require_relative '../support/dummy'

include SpecHelpers::Dummy

FactoryGirl.define do
  factory :user, aliases: [:author] do
    sequence(:first_name) { |n| "sample-first-name-#{n}" }
    sequence(:last_name)  { |n| "sample-last-name-#{n}" }
    sequence(:display_name) { |n| "sample-display-name-#{n}" }
    sequence(:email) { |n| "sample-email-#{n}@email.foo" }
    sequence(:facebook_id) { |n| "facebook_id-#{n}" }
    sequence(:facebook_token) { |n| "facebook_token-#{n}" }
    profile_picture '/images/dummy/user-64x64.jpg'

    trait :with_random_data do
      first_name { Faker::Name.first_name }
      last_name { Faker::Name.last_name }
      display_name { Faker::Name.name }
      email { Faker.with_locale(:en) { Faker::Internet.email } }
      profile_picture { Faker::Avatar.image }
    end

    factory :random_user, traits: [:with_random_data]
  end
end
