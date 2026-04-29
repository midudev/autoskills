# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      class MeterEventSessionService < StripeService
        # Creates a meter event session to send usage on the high-throughput meter event stream. Authentication tokens are only valid for 15 minutes, so you will need to create a new meter event session when your token expires.
        sig {
          params(params: T.any(::Stripe::V2::Billing::MeterEventSessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Billing::MeterEventSession)
         }
        def create(params = {}, opts = {}); end
      end
    end
  end
end