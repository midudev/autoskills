# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class TransactionService < StripeService
      # Retrieves a list of Transaction objects.
      sig {
        params(params: T.any(::Stripe::Treasury::TransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an existing Transaction.
      sig {
        params(id: String, params: T.any(::Stripe::Treasury::TransactionRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::Transaction)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end