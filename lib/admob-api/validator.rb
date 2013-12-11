require 'admob-api/errors'

class AdMobApi
  module Validator
    AUTH_ERROR_MSG = [
      'Invalid email or password.',
      /^client_key has invalid value /,
      /^(client_key|email|password) is a required parameter./
    ]

    UNAUTHORIZED_ERROR_MSG = [
      /^token has invalid value /,
      'token is a required parameter.'
    ]

    def validate(res)
      res['warnings'].each { |w| puts "Warning: #{w['msg']}" }

      res['errors'].each do |e|
        case e['msg']
        when *AUTH_ERROR_MSG
          raise AdMobApi::AuthenticationError, e['msg']
        when *UNAUTHORIZED_ERROR_MSG
          raise AdMobApi::UnauthorizedError, 'Authentication required'
        else
          raise AdMobApi::ClientError, e['msg']
        end
      end
    end
  end
end
