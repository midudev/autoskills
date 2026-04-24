# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Entitlements
    class FeatureService < StripeService
      # Creates a feature
      sig {
        params(params: T.any(::Stripe::Entitlements::FeatureCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Entitlements::Feature)
       }
      def create(params = {}, opts = {}); end

      # Retrieve a list of features
      sig {
        params(params: T.any(::Stripe::Entitlements::FeatureListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a feature
      sig {
        params(id: String, params: T.any(::Stripe::Entitlements::FeatureRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Entitlements::Feature)
       }
      def retrieve(id, params = {}, opts = {}); end

      # Update a feature's metadata or permanently deactivate it.
      sig {
        params(id: String, params: T.any(::Stripe::Entitlements::FeatureUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Entitlements::Feature)
       }
      def update(id, params = {}, opts = {}); end
    end
  end
end