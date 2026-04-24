# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class TokenService < StripeService
      # Lists all Issuing Token objects for a given card.
      sig {
        params(params: T.any(::Stripe::Issuing::TokenListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves an Issuing Token object.
      sig {
        params(token: String, params: T.any(::Stripe::Issuing::TokenRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Token)
       }
      def retrieve(token, params = {}, opts = {}); end

      # Attempts to update the specified Issuing Token object to the status specified.
      sig {
        params(token: String, params: T.any(::Stripe::Issuing::TokenUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Token)
       }
      def update(token, params = {}, opts = {}); end
    end
  end
end