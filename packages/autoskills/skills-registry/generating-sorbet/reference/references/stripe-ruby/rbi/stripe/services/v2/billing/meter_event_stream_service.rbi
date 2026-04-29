# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      class MeterEventStreamService < StripeService
        # Creates meter events. Events are processed asynchronously, including validation. Requires a meter event session for authentication. Supports up to 10,000 requests per second in livemode. For even higher rate-limits, contact sales.
        #
        # ** raises TemporarySessionExpiredError
        sig {
          params(params: T.any(::Stripe::V2::Billing::MeterEventStreamCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).void
         }
        def create(params = {}, opts = {}); end
      end
    end
  end
end