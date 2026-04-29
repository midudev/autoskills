# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class MeterEventSummaryService < StripeService
      # Retrieve a list of billing meter event summaries.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::MeterEventSummaryListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(id, params = {}, opts = {}); end
    end
  end
end