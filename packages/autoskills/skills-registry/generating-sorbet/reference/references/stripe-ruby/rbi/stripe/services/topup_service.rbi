# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TopupService < StripeService
    # Cancels a top-up. Only pending top-ups can be canceled.
    sig {
      params(topup: String, params: T.any(::Stripe::TopupCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Topup)
     }
    def cancel(topup, params = {}, opts = {}); end

    # Top up the balance of an account
    sig {
      params(params: T.any(::Stripe::TopupCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Topup)
     }
    def create(params = {}, opts = {}); end

    # Returns a list of top-ups.
    sig {
      params(params: T.any(::Stripe::TopupListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of a top-up that has previously been created. Supply the unique top-up ID that was returned from your previous request, and Stripe will return the corresponding top-up information.
    sig {
      params(topup: String, params: T.any(::Stripe::TopupRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Topup)
     }
    def retrieve(topup, params = {}, opts = {}); end

    # Updates the metadata of a top-up. Other top-up details are not editable by design.
    sig {
      params(topup: String, params: T.any(::Stripe::TopupUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Topup)
     }
    def update(topup, params = {}, opts = {}); end
  end
end