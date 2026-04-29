# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PromotionCodeService < StripeService
    # A promotion code points to an underlying promotion. You can optionally restrict the code to a specific customer, redemption limit, and expiration date.
    sig {
      params(params: T.any(::Stripe::PromotionCodeCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PromotionCode)
     }
    def create(params = {}, opts = {}); end

    # Returns a list of your promotion codes.
    sig {
      params(params: T.any(::Stripe::PromotionCodeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the promotion code with the given ID. In order to retrieve a promotion code by the customer-facing code use [list](https://docs.stripe.com/docs/api/promotion_codes/list) with the desired code.
    sig {
      params(promotion_code: String, params: T.any(::Stripe::PromotionCodeRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PromotionCode)
     }
    def retrieve(promotion_code, params = {}, opts = {}); end

    # Updates the specified promotion code by setting the values of the parameters passed. Most fields are, by design, not editable.
    sig {
      params(promotion_code: String, params: T.any(::Stripe::PromotionCodeUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PromotionCode)
     }
    def update(promotion_code, params = {}, opts = {}); end
  end
end