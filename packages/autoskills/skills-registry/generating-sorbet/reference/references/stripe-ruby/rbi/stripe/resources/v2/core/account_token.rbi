# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      # Account tokens are single-use tokens which tokenize company/individual/business information, and are used for creating or updating an Account.
      class AccountToken < APIResource
        # Time at which the token was created. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
        sig { returns(String) }
        def created; end
        # Time at which the token will expire.
        sig { returns(String) }
        def expires_at; end
        # Unique identifier for the token.
        sig { returns(String) }
        def id; end
        # Has the value `true` if the token exists in live mode or the value `false` if the object exists in test mode.
        sig { returns(T::Boolean) }
        def livemode; end
        # String representing the object's type. Objects of the same type share the same value of the object field.
        sig { returns(String) }
        def object; end
        # Determines if the token has already been used (tokens can only be used once).
        sig { returns(T::Boolean) }
        def used; end
      end
    end
  end
end