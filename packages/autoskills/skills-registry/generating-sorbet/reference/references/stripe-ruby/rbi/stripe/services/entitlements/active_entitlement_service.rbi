# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Entitlements
    class ActiveEntitlementService < StripeService
      # Retrieve a list of active entitlements for a customer
      sig {
        params(params: T.any(::Stripe::Entitlements::ActiveEntitlementListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieve an active entitlement
      sig {
        params(id: String, params: T.any(::Stripe::Entitlements::ActiveEntitlementRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Entitlements::ActiveEntitlement)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end