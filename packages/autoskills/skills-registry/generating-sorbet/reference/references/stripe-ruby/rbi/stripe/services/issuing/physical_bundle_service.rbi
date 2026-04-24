# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class PhysicalBundleService < StripeService
      # Returns a list of physical bundle objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::PhysicalBundleListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a physical bundle object.
      sig {
        params(physical_bundle: String, params: T.any(::Stripe::Issuing::PhysicalBundleRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::PhysicalBundle)
       }
      def retrieve(physical_bundle, params = {}, opts = {}); end
    end
  end
end