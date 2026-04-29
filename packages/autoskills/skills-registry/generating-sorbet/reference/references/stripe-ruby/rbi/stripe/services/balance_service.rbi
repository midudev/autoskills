# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class BalanceService < StripeService
    # Retrieves the current account balance, based on the authentication that was used to make the request.
    #  For a sample request, see [Accounting for negative balances](https://docs.stripe.com/docs/connect/account-balances#accounting-for-negative-balances).
    sig {
      params(params: T.any(::Stripe::BalanceRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Balance)
     }
    def retrieve(params = {}, opts = {}); end
  end
end