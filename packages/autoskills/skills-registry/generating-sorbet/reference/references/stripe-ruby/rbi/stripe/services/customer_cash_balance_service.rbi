# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerCashBalanceService < StripeService
    # Retrieves a customer's cash balance.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerCashBalanceRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CashBalance)
     }
    def retrieve(customer, params = {}, opts = {}); end

    # Changes the settings on a customer's cash balance.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerCashBalanceUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CashBalance)
     }
    def update(customer, params = {}, opts = {}); end
  end
end