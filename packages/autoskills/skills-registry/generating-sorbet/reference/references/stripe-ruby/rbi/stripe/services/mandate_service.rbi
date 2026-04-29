# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class MandateService < StripeService
    # Retrieves a Mandate object.
    sig {
      params(mandate: String, params: T.any(::Stripe::MandateRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Mandate)
     }
    def retrieve(mandate, params = {}, opts = {}); end
  end
end