class AdMobApi
  class ClientError < StandardError; end
  class AuthenticationError < ClientError; end
  class UnauthorizedError < ClientError; end
end
