# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerBalanceTransactionService < StripeService
    # Creates an immutable transaction that updates the customer's credit [balance](https://docs.stripe.com/docs/billing/customer/balance).
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerBalanceTransactionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CustomerBalanceTransaction)
     }
    def create(customer, params = {}, opts = {}); end

    # Returns a list of transactions that updated the customer's [balances](https://docs.stripe.com/docs/billing/customer/balance).
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerBalanceTransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(customer, params = {}, opts = {}); end

    # Retrieves a specific customer balance transaction that updated the customer's [balances](https://docs.stripe.com/docs/billing/customer/balance).
    sig {
      params(customer: String, transaction: String, params: T.any(::Stripe::CustomerBalanceTransactionRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CustomerBalanceTransaction)
     }
    def retrieve(customer, transaction, params = {}, opts = {}); end

    # Most credit balance transaction fields are immutable, but you may update its description and metadata.
    sig {
      params(customer: String, transaction: String, params: T.any(::Stripe::CustomerBalanceTransactionUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CustomerBalanceTransaction)
     }
    def update(customer, transaction, params = {}, opts = {}); end
  end
end