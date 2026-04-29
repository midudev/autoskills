# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Climate
    class ProductService < StripeService
      # Lists all available Climate product objects.
      sig {
        params(params: T.any(::Stripe::Climate::ProductListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of a Climate product with the given ID.
      sig {
        params(product: String, params: T.any(::Stripe::Climate::ProductRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Product)
       }
      def retrieve(product, params = {}, opts = {}); end
    end
  end
end