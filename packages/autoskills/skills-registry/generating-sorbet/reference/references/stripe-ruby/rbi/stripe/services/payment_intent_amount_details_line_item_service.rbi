# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentIntentAmountDetailsLineItemService < StripeService
    # Lists all LineItems of a given PaymentIntent.
    sig {
      params(intent: String, params: T.any(::Stripe::PaymentIntentAmountDetailsLineItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(intent, params = {}, opts = {}); end
  end
end