# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class MeterEventService < StripeService
      # Creates a billing meter event.
      sig {
        params(params: T.any(::Stripe::Billing::MeterEventCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::MeterEvent)
       }
      def create(params = {}, opts = {}); end
    end
  end
end