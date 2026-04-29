# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class AuthorizationRespondParams < ::Stripe::RequestParams
      # Whether to simulate the user confirming that the transaction was legitimate (true) or telling Stripe that it was fraudulent (false).
      sig { returns(T::Boolean) }
      def confirmed; end
      sig { params(_confirmed: T::Boolean).returns(T::Boolean) }
      def confirmed=(_confirmed); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      sig { params(confirmed: T::Boolean, expand: T.nilable(T::Array[String])).void }
      def initialize(confirmed: nil, expand: nil); end
    end
  end
end