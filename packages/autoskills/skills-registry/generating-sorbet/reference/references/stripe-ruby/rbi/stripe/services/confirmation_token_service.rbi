# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ConfirmationTokenService < StripeService
    # Retrieves an existing ConfirmationToken object
    sig {
      params(confirmation_token: String, params: T.any(::Stripe::ConfirmationTokenRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ConfirmationToken)
     }
    def retrieve(confirmation_token, params = {}, opts = {}); end
  end
end