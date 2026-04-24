# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    class ConfirmationTokenService < StripeService
      # Creates a test mode Confirmation Token server side for your integration tests.
      sig {
        params(params: T.any(::Stripe::TestHelpers::ConfirmationTokenCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ConfirmationToken)
       }
      def create(params = {}, opts = {}); end
    end
  end
end