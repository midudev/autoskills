# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class AuthorizationReverseParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The amount to reverse from the authorization. If not provided, the full amount of the authorization will be reversed. This amount is in the authorization currency and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(T.nilable(Integer)) }
      def reverse_amount; end
      sig { params(_reverse_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def reverse_amount=(_reverse_amount); end
      sig { params(expand: T.nilable(T::Array[String]), reverse_amount: T.nilable(Integer)).void }
      def initialize(expand: nil, reverse_amount: nil); end
    end
  end
end