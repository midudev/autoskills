# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ProductFeatureService < StripeService
    # Creates a product_feature, which represents a feature attachment to a product
    sig {
      params(product: String, params: T.any(::Stripe::ProductFeatureCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ProductFeature)
     }
    def create(product, params = {}, opts = {}); end

    # Deletes the feature attachment to a product
    sig {
      params(product: String, id: String, params: T.any(::Stripe::ProductFeatureDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ProductFeature)
     }
    def delete(product, id, params = {}, opts = {}); end

    # Retrieve a list of features for a product
    sig {
      params(product: String, params: T.any(::Stripe::ProductFeatureListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(product, params = {}, opts = {}); end

    # Retrieves a product_feature, which represents a feature attachment to a product
    sig {
      params(product: String, id: String, params: T.any(::Stripe::ProductFeatureRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ProductFeature)
     }
    def retrieve(product, id, params = {}, opts = {}); end
  end
end