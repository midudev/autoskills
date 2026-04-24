# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    class TestClockService < StripeService
      # Starts advancing a test clock to a specified time in the future. Advancement is done when status changes to Ready.
      sig {
        params(test_clock: String, params: T.any(::Stripe::TestHelpers::TestClockAdvanceParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def advance(test_clock, params = {}, opts = {}); end

      # Creates a new test clock that can be attached to new customers and quotes.
      sig {
        params(params: T.any(::Stripe::TestHelpers::TestClockCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def create(params = {}, opts = {}); end

      # Deletes a test clock.
      sig {
        params(test_clock: String, params: T.any(::Stripe::TestHelpers::TestClockDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def delete(test_clock, params = {}, opts = {}); end

      # Returns a list of your test clocks.
      sig {
        params(params: T.any(::Stripe::TestHelpers::TestClockListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a test clock.
      sig {
        params(test_clock: String, params: T.any(::Stripe::TestHelpers::TestClockRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TestHelpers::TestClock)
       }
      def retrieve(test_clock, params = {}, opts = {}); end
    end
  end
end