# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Billing
      class MeterEventAdjustment < APIResource
        class Cancel < ::Stripe::StripeObject
          # Unique identifier for the event. You can only cancel events within 24 hours of Stripe receiving them.
          sig { returns(String) }
          def identifier; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Specifies which event to cancel.
        sig { returns(Cancel) }
        def cancel; end
        # The time the adjustment was created.
        sig { returns(String) }
        def created; end
        # The name of the meter event. Corresponds with the `event_name` field on a meter.
        sig { returns(String) }
        def event_name; end
        # The unique id of this meter event adjustment.
        sig { returns(String) }
        def id; end
        # String representing the object's type. Objects of the same type share the same value of the object field.
        sig { returns(String) }
        def object; end
        # Open Enum. The meter event adjustment’s status.
        sig { returns(String) }
        def status; end
        # Open Enum. Specifies whether to cancel a single event or a range of events for a time period. Time period cancellation is not supported yet.
        sig { returns(String) }
        def type; end
        # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
        sig { returns(T::Boolean) }
        def livemode; end
      end
    end
  end
end