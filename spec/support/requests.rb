module SpecHelpers
  module Request
    def json_headers
      { 'CONTENT_TYPE' => 'application/json' }
    end

    def get_with_auth(path, params = {}, headers = {})
      add_auth_headers!(headers)
      get path, params, headers
    end

    def post_with_auth(path, params = {}, headers = {})
      add_auth_headers!(headers)
      post path, params, headers
    end

    def put_with_auth(path, params = {}, headers = {})
      add_auth_headers!(headers)
      put path, params, headers
    end

    def delete_with_auth(path, params = {}, headers = {})
      add_auth_headers!(headers)
      delete path, params, headers
    end

    def add_auth_headers!(headers)
      @current_user ||= create(:user)
      headers.merge!('X-Token' => @current_user.facebook_token)
    end

    def current_user
      @current_user ||= create(:user)
    end
  end
end
