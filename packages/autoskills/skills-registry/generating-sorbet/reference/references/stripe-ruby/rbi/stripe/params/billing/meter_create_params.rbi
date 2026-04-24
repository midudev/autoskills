# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class MeterCreateParams < ::Stripe::RequestParams
      class CustomerMapping < ::Stripe::RequestParams
        # The key in the meter event payload to use for mapping the event to a customer.
        sig { returns(String) }
        def event_payload_key; end
        sig { params(_event_payload_key: String).returns(String) }
        def event_payload_key=(_event_payload_key); end
        # The method for mapping a meter event to a customer. Must be `by_id`.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig { params(event_payload_key: String, type: String).void }
        def initialize(event_payload_key: nil, type: nil); end
      end
      class DefaultAggregation < ::Stripe::RequestParams
        # Specifies how events are aggregated. Allowed values are `count` to count the number of events, `sum` to sum each event's value and `last` to take the last event's value in the window.
        sig { returns(String) }
        def formula; end
        sig { params(_formula: String).returns(String) }
        def formula=(_formula); end
        sig { params(formula: String).void }
        def initialize(formula: nil); end
      end
      class ValueSettings < ::Stripe::RequestParams
        # The key in the usage event payload to use as the value for this meter. For example, if the event payload contains usage on a `bytes_used` field, then set the event_payload_key to "bytes_used".
        sig { returns(String) }
        def event_payload_key; end
        sig { params(_event_payload_key: String).returns(String) }
        def event_payload_key=(_event_payload_key); end
        sig { params(event_payload_key: String).void }
        def initialize(event_payload_key: nil); end
      end
      # Fields that specify how to map a meter event to a customer.
      sig { returns(T.nilable(Billing::MeterCreateParams::CustomerMapping)) }
      def customer_mapping; end
      sig {
        params(_customer_mapping: T.nilable(Billing::MeterCreateParams::CustomerMapping)).returns(T.nilable(Billing::MeterCreateParams::CustomerMapping))
       }
      def customer_mapping=(_customer_mapping); end
      # The default settings to aggregate a meter's events with.
      sig { returns(Billing::MeterCreateParams::DefaultAggregation) }
      def default_aggregation; end
      sig {
        params(_default_aggregation: Billing::MeterCreateParams::DefaultAggregation).returns(Billing::MeterCreateParams::DefaultAggregation)
       }
      def default_aggregation=(_default_aggregation); end
      # The meter’s name. Not visible to the customer.
      sig { returns(String) }
      def display_name; end
      sig { params(_display_name: String).returns(String) }
      def display_name=(_display_name); end
      # The name of the meter event to record usage for. Corresponds with the `event_name` field on meter events.
      sig { returns(String) }
      def event_name; end
      sig { params(_event_name: String).returns(String) }
      def event_name=(_event_name); end
      # The time window which meter events have been pre-aggregated for, if any.
      sig { returns(T.nilable(String)) }
      def event_time_window; end
      sig { params(_event_time_window: T.nilable(String)).returns(T.nilable(String)) }
      def event_time_window=(_event_time_window); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Fields that specify how to calculate a meter event's value.
      sig { returns(T.nilable(Billing::MeterCreateParams::ValueSettings)) }
      def value_settings; end
      sig {
        params(_value_settings: T.nilable(Billing::MeterCreateParams::ValueSettings)).returns(T.nilable(Billing::MeterCreateParams::ValueSettings))
       }
      def value_settings=(_value_settings); end
      sig {
        params(customer_mapping: T.nilable(Billing::MeterCreateParams::CustomerMapping), default_aggregation: Billing::MeterCreateParams::DefaultAggregation, display_name: String, event_name: String, event_time_window: T.nilable(String), expand: T.nilable(T::Array[String]), value_settings: T.nilable(Billing::MeterCreateParams::ValueSettings)).void
       }
      def initialize(
        customer_mapping: nil,
        default_aggregation: nil,
        display_name: nil,
        event_name: nil,
        event_time_window: nil,
        expand: nil,
        value_settings: nil
      ); end
    end
  end
end