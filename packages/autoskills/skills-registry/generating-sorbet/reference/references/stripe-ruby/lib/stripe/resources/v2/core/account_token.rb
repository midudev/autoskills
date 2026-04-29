# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      # Account tokens are single-use tokens which tokenize company/individual/business information, and are used for creating or updating an Account.
      class AccountToken < APIResource
        OBJECT_NAME = "v2.core.account_token"
        def self.object_name
          "v2.core.account_token"
        end

        # Time at which the token was created. Represented as a RFC 3339 date & time UTC value in millisecond precision, for example: 2022-09-18T13:22:18.123Z.
        attr_reader :created
        # Time at which the token will expire.
        attr_reader :expires_at
        # Unique identifier for the token.
        attr_reader :id
        # Has the value `true` if the token exists in live mode or the value `false` if the object exists in test mode.
        attr_reader :livemode
        # String representing the object's type. Objects of the same type share the same value of the object field.
        attr_reader :object
        # Determines if the token has already been used (tokens can only be used once).
        attr_reader :used

        def self.inner_class_types
          @inner_class_types = {}
        end

        def self.field_remappings
          @field_remappings = {}
        end
      end
    end
  end
end
