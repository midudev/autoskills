# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Entitlements
    class FeatureCreateParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A unique key you provide as your own system identifier. This may be up to 80 characters.
      sig { returns(String) }
      def lookup_key; end
      sig { params(_lookup_key: String).returns(String) }
      def lookup_key=(_lookup_key); end
      # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The feature's name, for your own purpose, not meant to be displayable to the customer.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      sig {
        params(expand: T.nilable(T::Array[String]), lookup_key: String, metadata: T.nilable(T::Hash[String, String]), name: String).void
       }
      def initialize(expand: nil, lookup_key: nil, metadata: nil, name: nil); end
    end
  end
end