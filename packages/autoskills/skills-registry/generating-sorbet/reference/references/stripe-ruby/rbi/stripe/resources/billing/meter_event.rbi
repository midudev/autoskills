# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    # Meter events represent actions that customers take in your system. You can use meter events to bill a customer based on their usage. Meter events are associated with billing meters, which define both the contents of the event's payload and how to aggregate those events.
    class MeterEvent < APIResource
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # The name of the meter event. Corresponds with the `event_name` field on a meter.
      sig { returns(String) }
      def event_name; end
      # A unique identifier for the event.
      sig { returns(String) }
      def identifier; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The payload of the event. This contains the fields corresponding to a meter's `customer_mapping.event_payload_key` (default is `stripe_customer_id`) and `value_settings.event_payload_key` (default is `value`). Read more about the [payload](https://docs.stripe.com/billing/subscriptions/usage-based/meters/configure#meter-configuration-attributes).
      sig { returns(T::Hash[String, String]) }
      def payload; end
      # The timestamp passed in when creating the event. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def timestamp; end
      # Creates a billing meter event.
      sig {
        params(params: T.any(::Stripe::Billing::MeterEventCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::MeterEvent)
       }
      def self.create(params = {}, opts = {}); end
    end
  end
end