# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class TransactionLineItemService < StripeService
      # Retrieves the line items of a committed standalone transaction as a collection.
      sig {
        params(transaction: String, params: T.any(::Stripe::Tax::TransactionLineItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(transaction, params = {}, opts = {}); end
    end
  end
end