# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      class MeterEventCreateParams < ::Stripe::RequestParams
        # The name of the meter event. Corresponds with the `event_name` field on a meter.
        sig { returns(String) }
        def event_name; end
        sig { params(_event_name: String).returns(String) }
        def event_name=(_event_name); end
        # A unique identifier for the event. If not provided, one will be generated.
        # We recommend using a globally unique identifier for this. We’ll enforce
        # uniqueness within a rolling 24 hour period.
        sig { returns(T.nilable(String)) }
        def identifier; end
        sig { params(_identifier: T.nilable(String)).returns(T.nilable(String)) }
        def identifier=(_identifier); end
        # The payload of the event. This must contain the fields corresponding to a meter’s
        # `customer_mapping.event_payload_key` (default is `stripe_customer_id`) and
        # `value_settings.event_payload_key` (default is `value`). Read more about
        # the
        # [payload](https://docs.stripe.com/billing/subscriptions/usage-based/recording-usage#payload-key-overrides).
        sig { returns(T::Hash[String, String]) }
        def payload; end
        sig { params(_payload: T::Hash[String, String]).returns(T::Hash[String, String]) }
        def payload=(_payload); end
        # The time of the event. Must be within the past 35 calendar days or up to
        # 5 minutes in the future. Defaults to current timestamp if not specified.
        sig { returns(T.nilable(String)) }
        def timestamp; end
        sig { params(_timestamp: T.nilable(String)).returns(T.nilable(String)) }
        def timestamp=(_timestamp); end
        sig {
          params(event_name: String, identifier: T.nilable(String), payload: T::Hash[String, String], timestamp: T.nilable(String)).void
         }
        def initialize(event_name: nil, identifier: nil, payload: nil, timestamp: nil); end
      end
    end
  end
end