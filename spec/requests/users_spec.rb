require 'rails_helper'

describe 'user' do
  let!(:user) { create(:user) }

  describe 'login' do
    before(:each) { stub_facebook }
    context 'with valid data' do
      let(:data) { { facebook_id: 'user_id', facebook_token: 'whatever' } }
      let!(:response) { post '/login', data }

      it 'should succeed' do
        expect(status).to eq(200)
      end

      it 'should return user' do
        expect(body).to have_json_path('id')
        expect(body).to have_json_path('displayName')
      end

      it 'should include facebook token' do
        expect(body).to have_json_path('facebookToken')
      end
    end

    context 'with invalid data' do
      let(:data) { { facebook_id: 'wrong_id', facebook_token: 'whatever' } }
      let!(:response) { post '/login', data }

      it 'should fail authentication' do
        expect(status).to eq(401)
      end
    end
  end
end
