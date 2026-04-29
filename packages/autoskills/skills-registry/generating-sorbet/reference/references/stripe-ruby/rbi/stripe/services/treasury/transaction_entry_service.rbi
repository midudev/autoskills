# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class TransactionEntryService < StripeService
      # Retrieves a list of TransactionEntry objects.
      sig {
        params(params: T.any(::Stripe::Treasury::TransactionEntryListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a TransactionEntry object.
      sig {
        params(id: String, params: T.any(::Stripe::Treasury::TransactionEntryRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::TransactionEntry)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end