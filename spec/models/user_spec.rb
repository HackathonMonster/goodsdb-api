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

require 'rails_helper'

describe User, type: :model do
  subject(:user) { create(:user) }

  it { is_expected.to respond_to(:first_name) }
  it { is_expected.to respond_to(:last_name) }
  it { is_expected.to respond_to(:display_name) }
  it { is_expected.to respond_to(:email) }
  it { is_expected.to respond_to(:profile_picture) }
  it { is_expected.to respond_to(:facebook_id) }
  it { is_expected.to respond_to(:facebook_token) }

  it { is_expected.to have_many(:items) }

  it { is_expected.to validate_uniqueness_of(:facebook_id) }

  describe '#facebook_authenticate' do
    before(:each) { stub_facebook }

    context 'with invalid facebook token' do
      before(:each) do
        allow_any_instance_of(Koala::Facebook::API).to receive(:get_object)
          .and_raise(Koala::Facebook::AuthenticationError.new('auth', 'error'))
      end
      subject(:user) { User.facebook_authenticate('user_id', 'random_token') }

      it { is_expected.to be_falsy }
    end

    context 'with invalid facebook id' do
      subject { User.facebook_authenticate('wrong_id', 'random_token') }
      it { is_expected.to be_falsy }
    end

    context 'with valid facebook id' do
      subject(:user) { User.facebook_authenticate('user_id', 'random_token') }

      it { is_expected.not_to be_falsy }
      its(:id) { is_expected.not_to be_nil }
      its(:facebook_token) { is_expected.not_to be_nil }

      user_profile.each do |key, value|
        key = case key
              when 'name' then 'display_name'
              when 'id'   then 'facebook_id'
              else key
            end.to_sym
        it "should assign #{key}" do
          expect(user.send(key)).not_to be_nil
          expect(user.send(key)).to eq(value) unless key == :birthday
        end
      end

      it 'should return same user every time' do
        expect(User.facebook_authenticate('user_id', 'facebook_token').id).to eq(user.id)
        expect(User.facebook_authenticate('user_id', 'other_token').id).to eq(user.id)
      end

      it 'should udpate facebook token' do
        expect(user.facebook_token).to eq('random_token')
        User.facebook_authenticate('user_id', 'facebook_token')
        expect(user.reload.facebook_token).to eq('facebook_token')
        User.facebook_authenticate('user_id', 'other_token')
        expect(user.reload.facebook_token).to eq('other_token')
      end
    end
  end
end
