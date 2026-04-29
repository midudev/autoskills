# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class MeterEventAdjustmentService < StripeService
      # Creates a billing meter event adjustment.
      sig {
        params(params: T.any(::Stripe::Billing::MeterEventAdjustmentCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::MeterEventAdjustment)
       }
      def create(params = {}, opts = {}); end
    end
  end
end