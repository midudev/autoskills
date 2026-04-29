# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class MeterEventSummaryListParams < ::Stripe::RequestParams
      # The customer for which to fetch event summaries.
      sig { returns(String) }
      def customer; end
      sig { params(_customer: String).returns(String) }
      def customer=(_customer); end
      # The timestamp from when to stop aggregating meter events (exclusive). Must be aligned with minute boundaries.
      sig { returns(Integer) }
      def end_time; end
      sig { params(_end_time: Integer).returns(Integer) }
      def end_time=(_end_time); end
      # A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
      sig { returns(T.nilable(String)) }
      def ending_before; end
      sig { params(_ending_before: T.nilable(String)).returns(T.nilable(String)) }
      def ending_before=(_ending_before); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
      sig { returns(T.nilable(Integer)) }
      def limit; end
      sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def limit=(_limit); end
      # The timestamp from when to start aggregating meter events (inclusive). Must be aligned with minute boundaries.
      sig { returns(Integer) }
      def start_time; end
      sig { params(_start_time: Integer).returns(Integer) }
      def start_time=(_start_time); end
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      # Specifies what granularity to use when generating event summaries. If not specified, a single event summary would be returned for the specified time range. For hourly granularity, start and end times must align with hour boundaries (e.g., 00:00, 01:00, ..., 23:00). For daily granularity, start and end times must align with UTC day boundaries (00:00 UTC).
      sig { returns(T.nilable(String)) }
      def value_grouping_window; end
      sig { params(_value_grouping_window: T.nilable(String)).returns(T.nilable(String)) }
      def value_grouping_window=(_value_grouping_window); end
      sig {
        params(customer: String, end_time: Integer, ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), start_time: Integer, starting_after: T.nilable(String), value_grouping_window: T.nilable(String)).void
       }
      def initialize(
        customer: nil,
        end_time: nil,
        ending_before: nil,
        expand: nil,
        limit: nil,
        start_time: nil,
        starting_after: nil,
        value_grouping_window: nil
      ); end
    end
  end
end