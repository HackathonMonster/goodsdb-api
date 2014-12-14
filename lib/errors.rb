module GoodsDbApi
  class BaseError < StandardError
  end

  class AuthenticationError < BaseError
  end

  class AuthorizationError < BaseError
  end
end
