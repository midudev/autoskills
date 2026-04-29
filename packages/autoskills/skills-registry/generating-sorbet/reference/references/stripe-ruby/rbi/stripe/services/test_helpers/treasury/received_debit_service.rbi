# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Treasury
      class ReceivedDebitService < StripeService
        # Use this endpoint to simulate a test mode ReceivedDebit initiated by a third party. In live mode, you can't directly create ReceivedDebits initiated by third parties.
        sig {
          params(params: T.any(::Stripe::TestHelpers::Treasury::ReceivedDebitCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::ReceivedDebit)
         }
        def create(params = {}, opts = {}); end
      end
    end
  end
end