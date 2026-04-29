# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      # Fix me empty_doc_string.
      class MeterEvent < APIResource
        # The creation time of this meter event.
        sig { returns(String) }
        def created; end
        # The name of the meter event. Corresponds with the `event_name` field on a meter.
        sig { returns(String) }
        def event_name; end
        # A unique identifier for the event. If not provided, one will be generated. We recommend using a globally unique identifier for this. We’ll enforce uniqueness within a rolling 24 hour period.
        sig { returns(String) }
        def identifier; end
        # String representing the object's type. Objects of the same type share the same value of the object field.
        sig { returns(String) }
        def object; end
        # The payload of the event. This must contain the fields corresponding to a meter’s
        # `customer_mapping.event_payload_key` (default is `stripe_customer_id`) and
        # `value_settings.event_payload_key` (default is `value`). Read more about
        # the [payload](https://docs.stripe.com/billing/subscriptions/usage-based/recording-usage#payload-key-overrides)..
        sig { returns(T::Hash[String, String]) }
        def payload; end
        # The time of the event. Must be within the past 35 calendar days or up to
        # 5 minutes in the future. Defaults to current timestamp if not specified.
        sig { returns(String) }
        def timestamp; end
        # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        sig { returns(T::Boolean) }
        def livemode; end
      end
    end
  end
end