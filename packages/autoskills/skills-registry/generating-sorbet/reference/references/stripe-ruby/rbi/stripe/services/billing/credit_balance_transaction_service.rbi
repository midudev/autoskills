# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class CreditBalanceTransactionService < StripeService
      # Retrieve a list of credit balance transactions.
      sig {
        params(params: T.any(::Stripe::Billing::CreditBalanceTransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a credit balance transaction.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::CreditBalanceTransactionRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditBalanceTransaction)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end