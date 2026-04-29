# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class TokenUpdateParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Specifies which status the token should be updated to.
      sig { returns(String) }
      def status; end
      sig { params(_status: String).returns(String) }
      def status=(_status); end
      sig { params(expand: T.nilable(T::Array[String]), status: String).void }
      def initialize(expand: nil, status: nil); end
    end
  end
end