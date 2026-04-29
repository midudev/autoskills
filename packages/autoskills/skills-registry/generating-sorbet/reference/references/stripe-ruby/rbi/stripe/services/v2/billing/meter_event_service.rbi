# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      class MeterEventService < StripeService
        # Creates a meter event. Events are validated synchronously, but are processed asynchronously. Supports up to 1,000 events per second in livemode. For higher rate-limits, please use meter event streams instead.
        sig {
          params(params: T.any(::Stripe::V2::Billing::MeterEventCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Billing::MeterEvent)
         }
        def create(params = {}, opts = {}); end
      end
    end
  end
end