# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module BillingPortal
    class SessionService < StripeService
      # Creates a session of the customer portal.
      sig {
        params(params: T.any(::Stripe::BillingPortal::SessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::BillingPortal::Session)
       }
      def create(params = {}, opts = {}); end
    end
  end
end