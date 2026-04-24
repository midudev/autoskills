# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Climate
    class SupplierService < StripeService
      # Lists all available Climate supplier objects.
      sig {
        params(params: T.any(::Stripe::Climate::SupplierListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a Climate supplier object.
      sig {
        params(supplier: String, params: T.any(::Stripe::Climate::SupplierRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Supplier)
       }
      def retrieve(supplier, params = {}, opts = {}); end
    end
  end
end