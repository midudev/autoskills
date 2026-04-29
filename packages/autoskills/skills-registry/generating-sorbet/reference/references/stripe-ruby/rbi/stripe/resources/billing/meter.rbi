# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    # Meters specify how to aggregate meter events over a billing period. Meter events represent the actions that customers take in your system. Meters attach to prices and form the basis of the bill.
    #
    # Related guide: [Usage based billing](https://docs.stripe.com/billing/subscriptions/usage-based)
    class Meter < APIResource
      class CustomerMapping < ::Stripe::StripeObject
        # The key in the meter event payload to use for mapping the event to a customer.
        sig { returns(String) }
        def event_payload_key; end
        # The method for mapping a meter event to a customer.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class DefaultAggregation < ::Stripe::StripeObject
        # Specifies how events are aggregated.
        sig { returns(String) }
        def formula; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StatusTransitions < ::Stripe::StripeObject
        # The time the meter was deactivated, if any. Measured in seconds since Unix epoch.
        sig { returns(T.nilable(Integer)) }
        def deactivated_at; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ValueSettings < ::Stripe::StripeObject
        # The key in the meter event payload to use as the value for this meter.
        sig { returns(String) }
        def event_payload_key; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Attribute for field customer_mapping
      sig { returns(CustomerMapping) }
      def customer_mapping; end
      # Attribute for field default_aggregation
      sig { returns(DefaultAggregation) }
      def default_aggregation; end
      # The meter's name.
      sig { returns(String) }
      def display_name; end
      # The name of the meter event to record usage for. Corresponds with the `event_name` field on meter events.
      sig { returns(String) }
      def event_name; end
      # The time window which meter events have been pre-aggregated for, if any.
      sig { returns(T.nilable(String)) }
      def event_time_window; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The meter's status.
      sig { returns(String) }
      def status; end
      # Attribute for field status_transitions
      sig { returns(StatusTransitions) }
      def status_transitions; end
      # Time at which the object was last updated. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def updated; end
      # Attribute for field value_settings
      sig { returns(ValueSettings) }
      def value_settings; end
      # Creates a billing meter.
      sig {
        params(params: T.any(::Stripe::Billing::MeterCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Meter)
       }
      def self.create(params = {}, opts = {}); end

      # When a meter is deactivated, no more meter events will be accepted for this meter. You can't attach a deactivated meter to a price.
      sig {
        params(params: T.any(::Stripe::Billing::MeterDeactivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Meter)
       }
      def deactivate(params = {}, opts = {}); end

      # When a meter is deactivated, no more meter events will be accepted for this meter. You can't attach a deactivated meter to a price.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::MeterDeactivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Meter)
       }
      def self.deactivate(id, params = {}, opts = {}); end

      # Retrieve a list of billing meters.
      sig {
        params(params: T.any(::Stripe::Billing::MeterListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # When a meter is reactivated, events for this meter can be accepted and you can attach the meter to a price.
      sig {
        params(params: T.any(::Stripe::Billing::MeterReactivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Meter)
       }
      def reactivate(params = {}, opts = {}); end

      # When a meter is reactivated, events for this meter can be accepted and you can attach the meter to a price.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::MeterReactivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Meter)
       }
      def self.reactivate(id, params = {}, opts = {}); end

      # Updates a billing meter.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::MeterUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Meter)
       }
      def self.update(id, params = {}, opts = {}); end
    end
  end
end