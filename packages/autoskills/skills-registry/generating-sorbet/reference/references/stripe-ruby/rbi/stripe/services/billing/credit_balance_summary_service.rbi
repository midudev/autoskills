# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class CreditBalanceSummaryService < StripeService
      # Retrieves the credit balance summary for a customer.
      sig {
        params(params: T.any(::Stripe::Billing::CreditBalanceSummaryRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditBalanceSummary)
       }
      def retrieve(params = {}, opts = {}); end
    end
  end
end