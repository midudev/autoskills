# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module BillingPortal
    class ConfigurationUpdateParams < ::Stripe::RequestParams
      class BusinessProfile < ::Stripe::RequestParams
        # The messaging shown to customers in the portal.
        sig { returns(T.nilable(String)) }
        def headline; end
        sig { params(_headline: T.nilable(String)).returns(T.nilable(String)) }
        def headline=(_headline); end
        # A link to the business’s publicly available privacy policy.
        sig { returns(T.nilable(String)) }
        def privacy_policy_url; end
        sig { params(_privacy_policy_url: T.nilable(String)).returns(T.nilable(String)) }
        def privacy_policy_url=(_privacy_policy_url); end
        # A link to the business’s publicly available terms of service.
        sig { returns(T.nilable(String)) }
        def terms_of_service_url; end
        sig { params(_terms_of_service_url: T.nilable(String)).returns(T.nilable(String)) }
        def terms_of_service_url=(_terms_of_service_url); end
        sig {
          params(headline: T.nilable(String), privacy_policy_url: T.nilable(String), terms_of_service_url: T.nilable(String)).void
         }
        def initialize(headline: nil, privacy_policy_url: nil, terms_of_service_url: nil); end
      end
      class Features < ::Stripe::RequestParams
        class CustomerUpdate < ::Stripe::RequestParams
          # The types of customer updates that are supported. When empty, customers are not updateable.
          sig { returns(T.nilable(T.any(String, T::Array[String]))) }
          def allowed_updates; end
          sig {
            params(_allowed_updates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
           }
          def allowed_updates=(_allowed_updates); end
          # Whether the feature is enabled.
          sig { returns(T.nilable(T::Boolean)) }
          def enabled; end
          sig { params(_enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def enabled=(_enabled); end
          sig {
            params(allowed_updates: T.nilable(T.any(String, T::Array[String])), enabled: T.nilable(T::Boolean)).void
           }
          def initialize(allowed_updates: nil, enabled: nil); end
        end
        class InvoiceHistory < ::Stripe::RequestParams
          # Whether the feature is enabled.
          sig { returns(T::Boolean) }
          def enabled; end
          sig { params(_enabled: T::Boolean).returns(T::Boolean) }
          def enabled=(_enabled); end
          sig { params(enabled: T::Boolean).void }
          def initialize(enabled: nil); end
        end
        class PaymentMethodUpdate < ::Stripe::RequestParams
          # Whether the feature is enabled.
          sig { returns(T::Boolean) }
          def enabled; end
          sig { params(_enabled: T::Boolean).returns(T::Boolean) }
          def enabled=(_enabled); end
          # The [Payment Method Configuration](/api/payment_method_configurations) to use for this portal session. When specified, customers will be able to update their payment method to one of the options specified by the payment method configuration. If not set or set to an empty string, the default payment method configuration is used.
          sig { returns(T.nilable(String)) }
          def payment_method_configuration; end
          sig {
            params(_payment_method_configuration: T.nilable(String)).returns(T.nilable(String))
           }
          def payment_method_configuration=(_payment_method_configuration); end
          sig { params(enabled: T::Boolean, payment_method_configuration: T.nilable(String)).void }
          def initialize(enabled: nil, payment_method_configuration: nil); end
        end
        class SubscriptionCancel < ::Stripe::RequestParams
          class CancellationReason < ::Stripe::RequestParams
            # Whether the feature is enabled.
            sig { returns(T::Boolean) }
            def enabled; end
            sig { params(_enabled: T::Boolean).returns(T::Boolean) }
            def enabled=(_enabled); end
            # Which cancellation reasons will be given as options to the customer.
            sig { returns(T.nilable(T.any(String, T::Array[String]))) }
            def options; end
            sig {
              params(_options: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
             }
            def options=(_options); end
            sig {
              params(enabled: T::Boolean, options: T.nilable(T.any(String, T::Array[String]))).void
             }
            def initialize(enabled: nil, options: nil); end
          end
          # Whether the cancellation reasons will be collected in the portal and which options are exposed to the customer
          sig {
            returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionCancel::CancellationReason))
           }
          def cancellation_reason; end
          sig {
            params(_cancellation_reason: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionCancel::CancellationReason)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionCancel::CancellationReason))
           }
          def cancellation_reason=(_cancellation_reason); end
          # Whether the feature is enabled.
          sig { returns(T.nilable(T::Boolean)) }
          def enabled; end
          sig { params(_enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def enabled=(_enabled); end
          # Whether to cancel subscriptions immediately or at the end of the billing period.
          sig { returns(T.nilable(String)) }
          def mode; end
          sig { params(_mode: T.nilable(String)).returns(T.nilable(String)) }
          def mode=(_mode); end
          # Whether to create prorations when canceling subscriptions. Possible values are `none` and `create_prorations`, which is only compatible with `mode=immediately`. Passing `always_invoice` will result in an error. No prorations are generated when canceling a subscription at the end of its natural billing period.
          sig { returns(T.nilable(String)) }
          def proration_behavior; end
          sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
          def proration_behavior=(_proration_behavior); end
          sig {
            params(cancellation_reason: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionCancel::CancellationReason), enabled: T.nilable(T::Boolean), mode: T.nilable(String), proration_behavior: T.nilable(String)).void
           }
          def initialize(
            cancellation_reason: nil,
            enabled: nil,
            mode: nil,
            proration_behavior: nil
          ); end
        end
        class SubscriptionUpdate < ::Stripe::RequestParams
          class Product < ::Stripe::RequestParams
            class AdjustableQuantity < ::Stripe::RequestParams
              # Set to true if the quantity can be adjusted to any non-negative integer.
              sig { returns(T::Boolean) }
              def enabled; end
              sig { params(_enabled: T::Boolean).returns(T::Boolean) }
              def enabled=(_enabled); end
              # The maximum quantity that can be set for the product.
              sig { returns(T.nilable(Integer)) }
              def maximum; end
              sig { params(_maximum: T.nilable(Integer)).returns(T.nilable(Integer)) }
              def maximum=(_maximum); end
              # The minimum quantity that can be set for the product.
              sig { returns(T.nilable(Integer)) }
              def minimum; end
              sig { params(_minimum: T.nilable(Integer)).returns(T.nilable(Integer)) }
              def minimum=(_minimum); end
              sig {
                params(enabled: T::Boolean, maximum: T.nilable(Integer), minimum: T.nilable(Integer)).void
               }
              def initialize(enabled: nil, maximum: nil, minimum: nil); end
            end
            # Control whether the quantity of the product can be adjusted.
            sig {
              returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::Product::AdjustableQuantity))
             }
            def adjustable_quantity; end
            sig {
              params(_adjustable_quantity: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::Product::AdjustableQuantity)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::Product::AdjustableQuantity))
             }
            def adjustable_quantity=(_adjustable_quantity); end
            # The list of price IDs for the product that a subscription can be updated to.
            sig { returns(T::Array[String]) }
            def prices; end
            sig { params(_prices: T::Array[String]).returns(T::Array[String]) }
            def prices=(_prices); end
            # The product id.
            sig { returns(String) }
            def product; end
            sig { params(_product: String).returns(String) }
            def product=(_product); end
            sig {
              params(adjustable_quantity: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::Product::AdjustableQuantity), prices: T::Array[String], product: String).void
             }
            def initialize(adjustable_quantity: nil, prices: nil, product: nil); end
          end
          class ScheduleAtPeriodEnd < ::Stripe::RequestParams
            class Condition < ::Stripe::RequestParams
              # The type of condition.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig { params(type: String).void }
              def initialize(type: nil); end
            end
            # List of conditions. When any condition is true, the update will be scheduled at the end of the current period.
            sig {
              returns(T.nilable(T.any(String, T::Array[BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::ScheduleAtPeriodEnd::Condition])))
             }
            def conditions; end
            sig {
              params(_conditions: T.nilable(T.any(String, T::Array[BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::ScheduleAtPeriodEnd::Condition]))).returns(T.nilable(T.any(String, T::Array[BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::ScheduleAtPeriodEnd::Condition])))
             }
            def conditions=(_conditions); end
            sig {
              params(conditions: T.nilable(T.any(String, T::Array[BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::ScheduleAtPeriodEnd::Condition]))).void
             }
            def initialize(conditions: nil); end
          end
          # Determines the value to use for the billing cycle anchor on subscription updates. Valid values are `now` or `unchanged`, and the default value is `unchanged`. Setting the value to `now` resets the subscription's billing cycle anchor to the current time (in UTC). For more information, see the billing cycle [documentation](https://docs.stripe.com/billing/subscriptions/billing-cycle).
          sig { returns(T.nilable(String)) }
          def billing_cycle_anchor; end
          sig { params(_billing_cycle_anchor: T.nilable(String)).returns(T.nilable(String)) }
          def billing_cycle_anchor=(_billing_cycle_anchor); end
          # The types of subscription updates that are supported. When empty, subscriptions are not updateable.
          sig { returns(T.nilable(T.any(String, T::Array[String]))) }
          def default_allowed_updates; end
          sig {
            params(_default_allowed_updates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
           }
          def default_allowed_updates=(_default_allowed_updates); end
          # Whether the feature is enabled.
          sig { returns(T.nilable(T::Boolean)) }
          def enabled; end
          sig { params(_enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
          def enabled=(_enabled); end
          # The list of up to 10 products that support subscription updates.
          sig {
            returns(T.nilable(T.any(String, T::Array[BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::Product])))
           }
          def products; end
          sig {
            params(_products: T.nilable(T.any(String, T::Array[BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::Product]))).returns(T.nilable(T.any(String, T::Array[BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::Product])))
           }
          def products=(_products); end
          # Determines how to handle prorations resulting from subscription updates. Valid values are `none`, `create_prorations`, and `always_invoice`.
          sig { returns(T.nilable(String)) }
          def proration_behavior; end
          sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
          def proration_behavior=(_proration_behavior); end
          # Setting to control when an update should be scheduled at the end of the period instead of applying immediately.
          sig {
            returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::ScheduleAtPeriodEnd))
           }
          def schedule_at_period_end; end
          sig {
            params(_schedule_at_period_end: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::ScheduleAtPeriodEnd)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::ScheduleAtPeriodEnd))
           }
          def schedule_at_period_end=(_schedule_at_period_end); end
          # The behavior when updating a subscription that is trialing.
          sig { returns(T.nilable(String)) }
          def trial_update_behavior; end
          sig { params(_trial_update_behavior: T.nilable(String)).returns(T.nilable(String)) }
          def trial_update_behavior=(_trial_update_behavior); end
          sig {
            params(billing_cycle_anchor: T.nilable(String), default_allowed_updates: T.nilable(T.any(String, T::Array[String])), enabled: T.nilable(T::Boolean), products: T.nilable(T.any(String, T::Array[BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::Product])), proration_behavior: T.nilable(String), schedule_at_period_end: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate::ScheduleAtPeriodEnd), trial_update_behavior: T.nilable(String)).void
           }
          def initialize(
            billing_cycle_anchor: nil,
            default_allowed_updates: nil,
            enabled: nil,
            products: nil,
            proration_behavior: nil,
            schedule_at_period_end: nil,
            trial_update_behavior: nil
          ); end
        end
        # Information about updating the customer details in the portal.
        sig {
          returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::CustomerUpdate))
         }
        def customer_update; end
        sig {
          params(_customer_update: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::CustomerUpdate)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::CustomerUpdate))
         }
        def customer_update=(_customer_update); end
        # Information about showing the billing history in the portal.
        sig {
          returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::InvoiceHistory))
         }
        def invoice_history; end
        sig {
          params(_invoice_history: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::InvoiceHistory)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::InvoiceHistory))
         }
        def invoice_history=(_invoice_history); end
        # Information about updating payment methods in the portal.
        sig {
          returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::PaymentMethodUpdate))
         }
        def payment_method_update; end
        sig {
          params(_payment_method_update: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::PaymentMethodUpdate)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::PaymentMethodUpdate))
         }
        def payment_method_update=(_payment_method_update); end
        # Information about canceling subscriptions in the portal.
        sig {
          returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionCancel))
         }
        def subscription_cancel; end
        sig {
          params(_subscription_cancel: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionCancel)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionCancel))
         }
        def subscription_cancel=(_subscription_cancel); end
        # Information about updating subscriptions in the portal.
        sig {
          returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate))
         }
        def subscription_update; end
        sig {
          params(_subscription_update: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate))
         }
        def subscription_update=(_subscription_update); end
        sig {
          params(customer_update: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::CustomerUpdate), invoice_history: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::InvoiceHistory), payment_method_update: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::PaymentMethodUpdate), subscription_cancel: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionCancel), subscription_update: T.nilable(BillingPortal::ConfigurationUpdateParams::Features::SubscriptionUpdate)).void
         }
        def initialize(
          customer_update: nil,
          invoice_history: nil,
          payment_method_update: nil,
          subscription_cancel: nil,
          subscription_update: nil
        ); end
      end
      class LoginPage < ::Stripe::RequestParams
        # Set to `true` to generate a shareable URL [`login_page.url`](https://docs.stripe.com/api/customer_portal/configuration#portal_configuration_object-login_page-url) that will take your customers to a hosted login page for the customer portal.
        #
        # Set to `false` to deactivate the `login_page.url`.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        sig { params(enabled: T::Boolean).void }
        def initialize(enabled: nil); end
      end
      # Whether the configuration is active and can be used to create portal sessions.
      sig { returns(T.nilable(T::Boolean)) }
      def active; end
      sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def active=(_active); end
      # The business information shown to customers in the portal.
      sig { returns(T.nilable(BillingPortal::ConfigurationUpdateParams::BusinessProfile)) }
      def business_profile; end
      sig {
        params(_business_profile: T.nilable(BillingPortal::ConfigurationUpdateParams::BusinessProfile)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::BusinessProfile))
       }
      def business_profile=(_business_profile); end
      # The default URL to redirect customers to when they click on the portal's link to return to your website. This can be [overriden](https://docs.stripe.com/api/customer_portal/sessions/create#create_portal_session-return_url) when creating the session.
      sig { returns(T.nilable(String)) }
      def default_return_url; end
      sig { params(_default_return_url: T.nilable(String)).returns(T.nilable(String)) }
      def default_return_url=(_default_return_url); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Information about the features available in the portal.
      sig { returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features)) }
      def features; end
      sig {
        params(_features: T.nilable(BillingPortal::ConfigurationUpdateParams::Features)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::Features))
       }
      def features=(_features); end
      # The hosted login page for this configuration. Learn more about the portal login page in our [integration docs](https://stripe.com/docs/billing/subscriptions/integrating-customer-portal#share).
      sig { returns(T.nilable(BillingPortal::ConfigurationUpdateParams::LoginPage)) }
      def login_page; end
      sig {
        params(_login_page: T.nilable(BillingPortal::ConfigurationUpdateParams::LoginPage)).returns(T.nilable(BillingPortal::ConfigurationUpdateParams::LoginPage))
       }
      def login_page=(_login_page); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
       }
      def metadata=(_metadata); end
      # The name of the configuration.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      sig {
        params(active: T.nilable(T::Boolean), business_profile: T.nilable(BillingPortal::ConfigurationUpdateParams::BusinessProfile), default_return_url: T.nilable(String), expand: T.nilable(T::Array[String]), features: T.nilable(BillingPortal::ConfigurationUpdateParams::Features), login_page: T.nilable(BillingPortal::ConfigurationUpdateParams::LoginPage), metadata: T.nilable(T.any(String, T::Hash[String, String])), name: T.nilable(String)).void
       }
      def initialize(
        active: nil,
        business_profile: nil,
        default_return_url: nil,
        expand: nil,
        features: nil,
        login_page: nil,
        metadata: nil,
        name: nil
      ); end
    end
  end
end