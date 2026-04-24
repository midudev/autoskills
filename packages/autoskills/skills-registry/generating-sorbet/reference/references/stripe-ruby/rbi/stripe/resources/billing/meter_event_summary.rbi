# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    # A billing meter event summary represents an aggregated view of a customer's billing meter events within a specified timeframe. It indicates how much
    # usage was accrued by a customer for that period.
    #
    # Note: Meters events are aggregated asynchronously so the meter event summaries provide an eventually consistent view of the reported usage.
    class MeterEventSummary < APIResource
      # Aggregated value of all the events within `start_time` (inclusive) and `end_time` (inclusive). The aggregation strategy is defined on meter via `default_aggregation`.
      sig { returns(Float) }
      def aggregated_value; end
      # End timestamp for this event summary (exclusive). Must be aligned with minute boundaries.
      sig { returns(Integer) }
      def end_time; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The meter associated with this event summary.
      sig { returns(String) }
      def meter; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Start timestamp for this event summary (inclusive). Must be aligned with minute boundaries.
      sig { returns(Integer) }
      def start_time; end
    end
  end
end