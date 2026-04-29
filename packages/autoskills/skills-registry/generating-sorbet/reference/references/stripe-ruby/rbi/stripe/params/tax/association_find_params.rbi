# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class AssociationFindParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Valid [PaymentIntent](https://docs.stripe.com/api/payment_intents/object) id
      sig { returns(String) }
      def payment_intent; end
      sig { params(_payment_intent: String).returns(String) }
      def payment_intent=(_payment_intent); end
      sig { params(expand: T.nilable(T::Array[String]), payment_intent: String).void }
      def initialize(expand: nil, payment_intent: nil); end
    end
  end
end