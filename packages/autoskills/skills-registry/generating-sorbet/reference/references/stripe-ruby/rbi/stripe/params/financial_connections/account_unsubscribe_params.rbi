# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    class AccountUnsubscribeParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The list of account features from which you would like to unsubscribe.
      sig { returns(T::Array[String]) }
      def features; end
      sig { params(_features: T::Array[String]).returns(T::Array[String]) }
      def features=(_features); end
      sig { params(expand: T.nilable(T::Array[String]), features: T::Array[String]).void }
      def initialize(expand: nil, features: nil); end
    end
  end
end