# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class EphemeralKeyService < StripeService
    # Creates a short-lived API key for a given resource.
    sig {
      params(params: T.any(::Stripe::EphemeralKeyCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::EphemeralKey)
     }
    def create(params = {}, opts = {}); end

    # Invalidates a short-lived API key for a given resource.
    sig {
      params(key: String, params: T.any(::Stripe::EphemeralKeyDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::EphemeralKey)
     }
    def delete(key, params = {}, opts = {}); end
  end
end