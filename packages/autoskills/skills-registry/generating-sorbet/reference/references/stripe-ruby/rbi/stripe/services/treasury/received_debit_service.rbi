# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class ReceivedDebitService < StripeService
      # Returns a list of ReceivedDebits.
      sig {
        params(params: T.any(::Stripe::Treasury::ReceivedDebitListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an existing ReceivedDebit by passing the unique ReceivedDebit ID from the ReceivedDebit list
      sig {
        params(id: String, params: T.any(::Stripe::Treasury::ReceivedDebitRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::ReceivedDebit)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end