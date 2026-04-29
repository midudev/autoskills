# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountLoginLinkService < StripeService
    # Creates a login link for a connected account to access the Express Dashboard.
    #
    # You can only create login links for accounts that use the [Express Dashboard](https://docs.stripe.com/connect/express-dashboard) and are connected to your platform.
    sig {
      params(account: String, params: T.any(::Stripe::AccountLoginLinkCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::LoginLink)
     }
    def create(account, params = {}, opts = {}); end
  end
end