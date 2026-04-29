# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      class MeterEventAdjustmentCreateParams < ::Stripe::RequestParams
        class Cancel < ::Stripe::RequestParams
          # Unique identifier for the event. You can only cancel events within 24 hours of Stripe receiving them.
          sig { returns(String) }
          def identifier; end
          sig { params(_identifier: String).returns(String) }
          def identifier=(_identifier); end
          sig { params(identifier: String).void }
          def initialize(identifier: nil); end
        end
        # Specifies which event to cancel.
        sig { returns(V2::Billing::MeterEventAdjustmentCreateParams::Cancel) }
        def cancel; end
        sig {
          params(_cancel: V2::Billing::MeterEventAdjustmentCreateParams::Cancel).returns(V2::Billing::MeterEventAdjustmentCreateParams::Cancel)
         }
        def cancel=(_cancel); end
        # The name of the meter event. Corresponds with the `event_name` field on a meter.
        sig { returns(String) }
        def event_name; end
        sig { params(_event_name: String).returns(String) }
        def event_name=(_event_name); end
        # Specifies whether to cancel a single event or a range of events for a time period. Time period cancellation is not supported yet.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(cancel: V2::Billing::MeterEventAdjustmentCreateParams::Cancel, event_name: String, type: String).void
         }
        def initialize(cancel: nil, event_name: nil, type: nil); end
      end
    end
  end
end