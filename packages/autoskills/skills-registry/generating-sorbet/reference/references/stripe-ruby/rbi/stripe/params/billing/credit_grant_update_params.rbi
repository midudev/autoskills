# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class CreditGrantUpdateParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The time when the billing credits created by this credit grant expire. If set to empty, the billing credits never expire.
      sig { returns(T.nilable(T.any(String, Integer))) }
      def expires_at; end
      sig {
        params(_expires_at: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
       }
      def expires_at=(_expires_at); end
      # Set of key-value pairs you can attach to an object. You can use this to store additional information about the object (for example, cost basis) in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      sig {
        params(expand: T.nilable(T::Array[String]), expires_at: T.nilable(T.any(String, Integer)), metadata: T.nilable(T::Hash[String, String])).void
       }
      def initialize(expand: nil, expires_at: nil, metadata: nil); end
    end
  end
end