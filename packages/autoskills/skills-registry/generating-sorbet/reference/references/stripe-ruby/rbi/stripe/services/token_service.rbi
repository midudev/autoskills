# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TokenService < StripeService
    # Creates a single-use token that represents a bank account's details.
    # You can use this token with any v1 API method in place of a bank account dictionary. You can only use this token once. To do so, attach it to a [connected account](https://docs.stripe.com/api#accounts) where [controller.requirement_collection](https://docs.stripe.com/api/accounts/object#account_object-controller-requirement_collection) is application, which includes Custom accounts.
    sig {
      params(params: T.any(::Stripe::TokenCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Token)
     }
    def create(params = {}, opts = {}); end

    # Retrieves the token with the given ID.
    sig {
      params(token: String, params: T.any(::Stripe::TokenRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Token)
     }
    def retrieve(token, params = {}, opts = {}); end
  end
end