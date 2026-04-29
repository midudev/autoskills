# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      class MeterEventAdjustmentService < StripeService
        # Creates a meter event adjustment to cancel a previously sent meter event.
        sig {
          params(params: T.any(::Stripe::V2::Billing::MeterEventAdjustmentCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Billing::MeterEventAdjustment)
         }
        def create(params = {}, opts = {}); end
      end
    end
  end
end