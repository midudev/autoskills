# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class CreditReversalService < StripeService
      # Reverses a ReceivedCredit and creates a CreditReversal object.
      sig {
        params(params: T.any(::Stripe::Treasury::CreditReversalCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::CreditReversal)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of CreditReversals.
      sig {
        params(params: T.any(::Stripe::Treasury::CreditReversalListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an existing CreditReversal by passing the unique CreditReversal ID from either the CreditReversal creation request or CreditReversal list
      sig {
        params(credit_reversal: String, params: T.any(::Stripe::Treasury::CreditReversalRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::CreditReversal)
       }
      def retrieve(credit_reversal, params = {}, opts = {}); end
    end
  end
end