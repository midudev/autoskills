# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ProductFeatureCreateParams < ::Stripe::RequestParams
    # The ID of the [Feature](https://docs.stripe.com/api/entitlements/feature) object attached to this product.
    sig { returns(String) }
    def entitlement_feature; end
    sig { params(_entitlement_feature: String).returns(String) }
    def entitlement_feature=(_entitlement_feature); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig { params(entitlement_feature: String, expand: T.nilable(T::Array[String])).void }
    def initialize(entitlement_feature: nil, expand: nil); end
  end
end