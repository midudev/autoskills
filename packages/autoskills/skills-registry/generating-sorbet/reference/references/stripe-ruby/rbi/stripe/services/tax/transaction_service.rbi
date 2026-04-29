# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class TransactionService < StripeService
      attr_reader :line_items
      # Creates a Tax Transaction from a calculation, if that calculation hasn't expired. Calculations expire after 90 days.
      sig {
        params(params: T.any(::Stripe::Tax::TransactionCreateFromCalculationParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Transaction)
       }
      def create_from_calculation(params = {}, opts = {}); end

      # Partially or fully reverses a previously created Transaction.
      sig {
        params(params: T.any(::Stripe::Tax::TransactionCreateReversalParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Transaction)
       }
      def create_reversal(params = {}, opts = {}); end

      # Retrieves a Tax Transaction object.
      sig {
        params(transaction: String, params: T.any(::Stripe::Tax::TransactionRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Transaction)
       }
      def retrieve(transaction, params = {}, opts = {}); end
    end
  end
end