# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerCashBalanceTransactionService < StripeService
    # Returns a list of transactions that modified the customer's [cash balance](https://docs.stripe.com/docs/payments/customer-balance).
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerCashBalanceTransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(customer, params = {}, opts = {}); end

    # Retrieves a specific cash balance transaction, which updated the customer's [cash balance](https://docs.stripe.com/docs/payments/customer-balance).
    sig {
      params(customer: String, transaction: String, params: T.any(::Stripe::CustomerCashBalanceTransactionRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CustomerCashBalanceTransaction)
     }
    def retrieve(customer, transaction, params = {}, opts = {}); end
  end
end