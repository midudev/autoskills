# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class AuthorizationIncrementParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The amount to increment the authorization by. This amount is in the authorization currency and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(Integer) }
      def increment_amount; end
      sig { params(_increment_amount: Integer).returns(Integer) }
      def increment_amount=(_increment_amount); end
      # If set `true`, you may provide [amount](https://docs.stripe.com/api/issuing/authorizations/approve#approve_issuing_authorization-amount) to control how much to hold for the authorization.
      sig { returns(T.nilable(T::Boolean)) }
      def is_amount_controllable; end
      sig { params(_is_amount_controllable: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def is_amount_controllable=(_is_amount_controllable); end
      sig {
        params(expand: T.nilable(T::Array[String]), increment_amount: Integer, is_amount_controllable: T.nilable(T::Boolean)).void
       }
      def initialize(expand: nil, increment_amount: nil, is_amount_controllable: nil); end
    end
  end
end