module GoodsDbApi
  class BaseError < StandardError
  end

  class AuthenticationError < BaseError
  end
end
