# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    # A billing alert is a resource that notifies you when a certain usage threshold on a meter is crossed. For example, you might create a billing alert to notify you when a certain user made 100 API requests.
    class Alert < APIResource
      class UsageThreshold < ::Stripe::StripeObject
        class Filter < ::Stripe::StripeObject
          # Limit the scope of the alert to this customer ID
          sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
          def customer; end
          # Attribute for field type
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The filters allow limiting the scope of this usage alert. You can only specify up to one filter at this time.
        sig { returns(T.nilable(T::Array[Filter])) }
        def filters; end
        # The value at which this alert will trigger.
        sig { returns(Integer) }
        def gte; end
        # The [Billing Meter](/api/billing/meter) ID whose usage is monitored.
        sig { returns(T.any(String, ::Stripe::Billing::Meter)) }
        def meter; end
        # Defines how the alert will behave.
        sig { returns(String) }
        def recurrence; end
        def self.inner_class_types
          @inner_class_types = {filters: Filter}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Defines the type of the alert.
      sig { returns(String) }
      def alert_type; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Status of the alert. This can be active, inactive or archived.
      sig { returns(T.nilable(String)) }
      def status; end
      # Title of the alert.
      sig { returns(String) }
      def title; end
      # Encapsulates configuration of the alert to monitor usage on a specific [Billing Meter](https://docs.stripe.com/api/billing/meter).
      sig { returns(T.nilable(UsageThreshold)) }
      def usage_threshold; end
      # Reactivates this alert, allowing it to trigger again.
      sig {
        params(params: T.any(::Stripe::Billing::AlertActivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def activate(params = {}, opts = {}); end

      # Reactivates this alert, allowing it to trigger again.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::AlertActivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def self.activate(id, params = {}, opts = {}); end

      # Archives this alert, removing it from the list view and APIs. This is non-reversible.
      sig {
        params(params: T.any(::Stripe::Billing::AlertArchiveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def archive(params = {}, opts = {}); end

      # Archives this alert, removing it from the list view and APIs. This is non-reversible.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::AlertArchiveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def self.archive(id, params = {}, opts = {}); end

      # Creates a billing alert
      sig {
        params(params: T.any(::Stripe::Billing::AlertCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def self.create(params = {}, opts = {}); end

      # Deactivates this alert, preventing it from triggering.
      sig {
        params(params: T.any(::Stripe::Billing::AlertDeactivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def deactivate(params = {}, opts = {}); end

      # Deactivates this alert, preventing it from triggering.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::AlertDeactivateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::Alert)
       }
      def self.deactivate(id, params = {}, opts = {}); end

      # Lists billing active and inactive alerts
      sig {
        params(params: T.any(::Stripe::Billing::AlertListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end