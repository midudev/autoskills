# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerSessionService < StripeService
    # Creates a Customer Session object that includes a single-use client secret that you can use on your front-end to grant client-side API access for certain customer resources.
    sig {
      params(params: T.any(::Stripe::CustomerSessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CustomerSession)
     }
    def create(params = {}, opts = {}); end
  end
end