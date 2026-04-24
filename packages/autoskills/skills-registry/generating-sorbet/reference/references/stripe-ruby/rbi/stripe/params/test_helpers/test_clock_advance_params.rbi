# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    class TestClockAdvanceParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The time to advance the test clock. Must be after the test clock's current frozen time. Cannot be more than two intervals in the future from the shortest subscription in this test clock. If there are no subscriptions in this test clock, it cannot be more than two years in the future.
      sig { returns(Integer) }
      def frozen_time; end
      sig { params(_frozen_time: Integer).returns(Integer) }
      def frozen_time=(_frozen_time); end
      sig { params(expand: T.nilable(T::Array[String]), frozen_time: Integer).void }
      def initialize(expand: nil, frozen_time: nil); end
    end
  end
end