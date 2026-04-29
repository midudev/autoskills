# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class CreditGrantService < StripeService
      # Creates a credit grant.
      sig {
        params(params: T.any(::Stripe::Billing::CreditGrantCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def create(params = {}, opts = {}); end

      # Expires a credit grant.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::CreditGrantExpireParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def expire(id, params = {}, opts = {}); end

      # Retrieve a list of credit grants.
      sig {
        params(params: T.any(::Stripe::Billing::CreditGrantListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a credit grant.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::CreditGrantRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def retrieve(id, params = {}, opts = {}); end

      # Updates a credit grant.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::CreditGrantUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def update(id, params = {}, opts = {}); end

      # Voids a credit grant.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::CreditGrantVoidGrantParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def void_grant(id, params = {}, opts = {}); end
    end
  end
end