# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Entitlements
    # An active entitlement describes access to a feature for a customer.
    class ActiveEntitlement < APIResource
      # The [Feature](https://docs.stripe.com/api/entitlements/feature) that the customer is entitled to.
      sig { returns(T.any(String, ::Stripe::Entitlements::Feature)) }
      def feature; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # A unique key you provide as your own system identifier. This may be up to 80 characters.
      sig { returns(String) }
      def lookup_key; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Retrieve a list of active entitlements for a customer
      sig {
        params(params: T.any(::Stripe::Entitlements::ActiveEntitlementListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end