# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class DebitReversalService < StripeService
      # Reverses a ReceivedDebit and creates a DebitReversal object.
      sig {
        params(params: T.any(::Stripe::Treasury::DebitReversalCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::DebitReversal)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of DebitReversals.
      sig {
        params(params: T.any(::Stripe::Treasury::DebitReversalListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a DebitReversal object.
      sig {
        params(debit_reversal: String, params: T.any(::Stripe::Treasury::DebitReversalRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::DebitReversal)
       }
      def retrieve(debit_reversal, params = {}, opts = {}); end
    end
  end
end