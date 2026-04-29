# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module BillingPortal
    # A portal configuration describes the functionality and behavior you embed in a portal session. Related guide: [Configure the customer portal](https://docs.stripe.com/customer-management/configure-portal).
    class Configuration < APIResource
      class BusinessProfile < ::Stripe::StripeObject
        # The messaging shown to customers in the portal.
        sig { returns(T.nilable(String)) }
        def headline; end
        # A link to the business’s publicly available privacy policy.
        sig { returns(T.nilable(String)) }
        def privacy_policy_url; end
        # A link to the business’s publicly available terms of service.
        sig { returns(T.nilable(String)) }
        def terms_of_service_url; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Features < ::Stripe::StripeObject
        class CustomerUpdate < ::Stripe::StripeObject
          # The types of customer updates that are supported. When empty, customers are not updateable.
          sig { returns(T::Array[String]) }
          def allowed_updates; end
          # Whether the feature is enabled.
          sig { returns(T::Boolean) }
          def enabled; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class InvoiceHistory < ::Stripe::StripeObject
          # Whether the feature is enabled.
          sig { returns(T::Boolean) }
          def enabled; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class PaymentMethodUpdate < ::Stripe::StripeObject
          # Whether the feature is enabled.
          sig { returns(T::Boolean) }
          def enabled; end
          # The [Payment Method Configuration](/api/payment_method_configurations) to use for this portal session. When specified, customers will be able to update their payment method to one of the options specified by the payment method configuration. If not set, the default payment method configuration is used.
          sig { returns(T.nilable(String)) }
          def payment_method_configuration; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SubscriptionCancel < ::Stripe::StripeObject
          class CancellationReason < ::Stripe::StripeObject
            # Whether the feature is enabled.
            sig { returns(T::Boolean) }
            def enabled; end
            # Which cancellation reasons will be given as options to the customer.
            sig { returns(T::Array[String]) }
            def options; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field cancellation_reason
          sig { returns(CancellationReason) }
          def cancellation_reason; end
          # Whether the feature is enabled.
          sig { returns(T::Boolean) }
          def enabled; end
          # Whether to cancel subscriptions immediately or at the end of the billing period.
          sig { returns(String) }
          def mode; end
          # Whether to create prorations when canceling subscriptions. Possible values are `none` and `create_prorations`.
          sig { returns(String) }
          def proration_behavior; end
          def self.inner_class_types
            @inner_class_types = {cancellation_reason: CancellationReason}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SubscriptionUpdate < ::Stripe::StripeObject
          class Product < ::Stripe::StripeObject
            class AdjustableQuantity < ::Stripe::StripeObject
              # If true, the quantity can be adjusted to any non-negative integer.
              sig { returns(T::Boolean) }
              def enabled; end
              # The maximum quantity that can be set for the product.
              sig { returns(T.nilable(Integer)) }
              def maximum; end
              # The minimum quantity that can be set for the product.
              sig { returns(Integer) }
              def minimum; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Attribute for field adjustable_quantity
            sig { returns(AdjustableQuantity) }
            def adjustable_quantity; end
            # The list of price IDs which, when subscribed to, a subscription can be updated.
            sig { returns(T::Array[String]) }
            def prices; end
            # The product ID.
            sig { returns(String) }
            def product; end
            def self.inner_class_types
              @inner_class_types = {adjustable_quantity: AdjustableQuantity}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class ScheduleAtPeriodEnd < ::Stripe::StripeObject
            class Condition < ::Stripe::StripeObject
              # The type of condition.
              sig { returns(String) }
              def type; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # List of conditions. When any condition is true, an update will be scheduled at the end of the current period.
            sig { returns(T::Array[Condition]) }
            def conditions; end
            def self.inner_class_types
              @inner_class_types = {conditions: Condition}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Determines the value to use for the billing cycle anchor on subscription updates. Valid values are `now` or `unchanged`, and the default value is `unchanged`. Setting the value to `now` resets the subscription's billing cycle anchor to the current time (in UTC). For more information, see the billing cycle [documentation](https://docs.stripe.com/billing/subscriptions/billing-cycle).
          sig { returns(T.nilable(String)) }
          def billing_cycle_anchor; end
          # The types of subscription updates that are supported for items listed in the `products` attribute. When empty, subscriptions are not updateable.
          sig { returns(T::Array[String]) }
          def default_allowed_updates; end
          # Whether the feature is enabled.
          sig { returns(T::Boolean) }
          def enabled; end
          # The list of up to 10 products that support subscription updates.
          sig { returns(T.nilable(T::Array[Product])) }
          def products; end
          # Determines how to handle prorations resulting from subscription updates. Valid values are `none`, `create_prorations`, and `always_invoice`. Defaults to a value of `none` if you don't set it during creation.
          sig { returns(String) }
          def proration_behavior; end
          # Attribute for field schedule_at_period_end
          sig { returns(ScheduleAtPeriodEnd) }
          def schedule_at_period_end; end
          # Determines how handle updates to trialing subscriptions. Valid values are `end_trial` and `continue_trial`. Defaults to a value of `end_trial` if you don't set it during creation.
          sig { returns(String) }
          def trial_update_behavior; end
          def self.inner_class_types
            @inner_class_types = {products: Product, schedule_at_period_end: ScheduleAtPeriodEnd}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field customer_update
        sig { returns(CustomerUpdate) }
        def customer_update; end
        # Attribute for field invoice_history
        sig { returns(InvoiceHistory) }
        def invoice_history; end
        # Attribute for field payment_method_update
        sig { returns(PaymentMethodUpdate) }
        def payment_method_update; end
        # Attribute for field subscription_cancel
        sig { returns(SubscriptionCancel) }
        def subscription_cancel; end
        # Attribute for field subscription_update
        sig { returns(SubscriptionUpdate) }
        def subscription_update; end
        def self.inner_class_types
          @inner_class_types = {
            customer_update: CustomerUpdate,
            invoice_history: InvoiceHistory,
            payment_method_update: PaymentMethodUpdate,
            subscription_cancel: SubscriptionCancel,
            subscription_update: SubscriptionUpdate,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class LoginPage < ::Stripe::StripeObject
        # If `true`, a shareable `url` will be generated that will take your customers to a hosted login page for the customer portal.
        #
        # If `false`, the previously generated `url`, if any, will be deactivated.
        sig { returns(T::Boolean) }
        def enabled; end
        # A shareable URL to the hosted portal login page. Your customers will be able to log in with their [email](https://docs.stripe.com/api/customers/object#customer_object-email) and receive a link to their customer portal.
        sig { returns(T.nilable(String)) }
        def url; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Whether the configuration is active and can be used to create portal sessions.
      sig { returns(T::Boolean) }
      def active; end
      # ID of the Connect Application that created the configuration.
      sig { returns(T.nilable(T.any(String, ::Stripe::Application))) }
      def application; end
      # Attribute for field business_profile
      sig { returns(BusinessProfile) }
      def business_profile; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # The default URL to redirect customers to when they click on the portal's link to return to your website. This can be [overriden](https://docs.stripe.com/api/customer_portal/sessions/create#create_portal_session-return_url) when creating the session.
      sig { returns(T.nilable(String)) }
      def default_return_url; end
      # Attribute for field features
      sig { returns(Features) }
      def features; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Whether the configuration is the default. If `true`, this configuration can be managed in the Dashboard and portal sessions will use this configuration unless it is overriden when creating the session.
      sig { returns(T::Boolean) }
      def is_default; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Attribute for field login_page
      sig { returns(LoginPage) }
      def login_page; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      # The name of the configuration.
      sig { returns(T.nilable(String)) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Time at which the object was last updated. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def updated; end
      # Creates a configuration that describes the functionality and behavior of a PortalSession
      sig {
        params(params: T.any(::Stripe::BillingPortal::ConfigurationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::BillingPortal::Configuration)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of configurations that describe the functionality of the customer portal.
      sig {
        params(params: T.any(::Stripe::BillingPortal::ConfigurationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates a configuration that describes the functionality of the customer portal.
      sig {
        params(configuration: String, params: T.any(::Stripe::BillingPortal::ConfigurationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::BillingPortal::Configuration)
       }
      def self.update(configuration, params = {}, opts = {}); end
    end
  end
end