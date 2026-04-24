# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    # A billing meter event adjustment is a resource that allows you to cancel a meter event. For example, you might create a billing meter event adjustment to cancel a meter event that was created in error or attached to the wrong customer.
    class MeterEventAdjustment < APIResource
      class Cancel < ::Stripe::StripeObject
        # Unique identifier for the event.
        sig { returns(T.nilable(String)) }
        def identifier; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Specifies which event to cancel.
      sig { returns(T.nilable(Cancel)) }
      def cancel; end
      # The name of the meter event. Corresponds with the `event_name` field on a meter.
      sig { returns(String) }
      def event_name; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The meter event adjustment's status.
      sig { returns(String) }
      def status; end
      # Specifies whether to cancel a single event or a range of events for a time period. Time period cancellation is not supported yet.
      sig { returns(String) }
      def type; end
      # Creates a billing meter event adjustment.
      sig {
        params(params: T.any(::Stripe::Billing::MeterEventAdjustmentCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::MeterEventAdjustment)
       }
      def self.create(params = {}, opts = {}); end
    end
  end
end