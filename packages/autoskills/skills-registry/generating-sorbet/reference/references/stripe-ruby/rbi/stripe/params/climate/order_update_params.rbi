# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Climate
    class OrderUpdateParams < ::Stripe::RequestParams
      class Beneficiary < ::Stripe::RequestParams
        # Publicly displayable name for the end beneficiary of carbon removal.
        sig { returns(String) }
        def public_name; end
        sig { params(_public_name: String).returns(String) }
        def public_name=(_public_name); end
        sig { params(public_name: String).void }
        def initialize(public_name: nil); end
      end
      # Publicly sharable reference for the end beneficiary of carbon removal. Assumed to be the Stripe account if not set.
      sig { returns(T.nilable(T.any(String, Climate::OrderUpdateParams::Beneficiary))) }
      def beneficiary; end
      sig {
        params(_beneficiary: T.nilable(T.any(String, Climate::OrderUpdateParams::Beneficiary))).returns(T.nilable(T.any(String, Climate::OrderUpdateParams::Beneficiary)))
       }
      def beneficiary=(_beneficiary); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      sig {
        params(beneficiary: T.nilable(T.any(String, Climate::OrderUpdateParams::Beneficiary)), expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String])).void
       }
      def initialize(beneficiary: nil, expand: nil, metadata: nil); end
    end
  end
end