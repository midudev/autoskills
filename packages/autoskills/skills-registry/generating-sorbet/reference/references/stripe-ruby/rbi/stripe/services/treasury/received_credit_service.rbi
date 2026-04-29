# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class ReceivedCreditService < StripeService
      # Returns a list of ReceivedCredits.
      sig {
        params(params: T.any(::Stripe::Treasury::ReceivedCreditListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an existing ReceivedCredit by passing the unique ReceivedCredit ID from the ReceivedCredit list.
      sig {
        params(id: String, params: T.any(::Stripe::Treasury::ReceivedCreditRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::ReceivedCredit)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end