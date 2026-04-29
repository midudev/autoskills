# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class DisputeService < StripeService
    # Closing the dispute for a charge indicates that you do not have any evidence to submit and are essentially dismissing the dispute, acknowledging it as lost.
    #
    # The status of the dispute will change from needs_response to lost. Closing a dispute is irreversible.
    sig {
      params(dispute: String, params: T.any(::Stripe::DisputeCloseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Dispute)
     }
    def close(dispute, params = {}, opts = {}); end

    # Returns a list of your disputes.
    sig {
      params(params: T.any(::Stripe::DisputeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the dispute with the given ID.
    sig {
      params(dispute: String, params: T.any(::Stripe::DisputeRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Dispute)
     }
    def retrieve(dispute, params = {}, opts = {}); end

    # When you get a dispute, contacting your customer is always the best first step. If that doesn't work, you can submit evidence to help us resolve the dispute in your favor. You can do this in your [dashboard](https://dashboard.stripe.com/disputes), but if you prefer, you can use the API to submit evidence programmatically.
    #
    # Depending on your dispute type, different evidence fields will give you a better chance of winning your dispute. To figure out which evidence fields to provide, see our [guide to dispute types](https://docs.stripe.com/docs/disputes/categories).
    sig {
      params(dispute: String, params: T.any(::Stripe::DisputeUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Dispute)
     }
    def update(dispute, params = {}, opts = {}); end
  end
end