# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module BillingPortal
    # The Billing customer portal is a Stripe-hosted UI for subscription and
    # billing management.
    #
    # A portal configuration describes the functionality and features that you
    # want to provide to your customers through the portal.
    #
    # A portal session describes the instantiation of the customer portal for
    # a particular customer. By visiting the session's URL, the customer
    # can manage their subscriptions and billing details. For security reasons,
    # sessions are short-lived and will expire if the customer does not visit the URL.
    # Create sessions on-demand when customers intend to manage their subscriptions
    # and billing details.
    #
    # Related guide: [Customer management](https://docs.stripe.com/customer-management)
    class Session < APIResource
      class Flow < ::Stripe::StripeObject
        class AfterCompletion < ::Stripe::StripeObject
          class HostedConfirmation < ::Stripe::StripeObject
            # A custom message to display to the customer after the flow is completed.
            sig { returns(T.nilable(String)) }
            def custom_message; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Redirect < ::Stripe::StripeObject
            # The URL the customer will be redirected to after the flow is completed.
            sig { returns(String) }
            def return_url; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Configuration when `after_completion.type=hosted_confirmation`.
          sig { returns(T.nilable(HostedConfirmation)) }
          def hosted_confirmation; end
          # Configuration when `after_completion.type=redirect`.
          sig { returns(T.nilable(Redirect)) }
          def redirect; end
          # The specified type of behavior after the flow is completed.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {hosted_confirmation: HostedConfirmation, redirect: Redirect}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SubscriptionCancel < ::Stripe::StripeObject
          class Retention < ::Stripe::StripeObject
            class CouponOffer < ::Stripe::StripeObject
              # The ID of the coupon to be offered.
              sig { returns(String) }
              def coupon; end
              def self.inner_class_types
                @inner_class_types = {}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Configuration when `retention.type=coupon_offer`.
            sig { returns(T.nilable(CouponOffer)) }
            def coupon_offer; end
            # Type of retention strategy that will be used.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {coupon_offer: CouponOffer}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Specify a retention strategy to be used in the cancellation flow.
          sig { returns(T.nilable(Retention)) }
          def retention; end
          # The ID of the subscription to be canceled.
          sig { returns(String) }
          def subscription; end
          def self.inner_class_types
            @inner_class_types = {retention: Retention}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SubscriptionUpdate < ::Stripe::StripeObject
          # The ID of the subscription to be updated.
          sig { returns(String) }
          def subscription; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SubscriptionUpdateConfirm < ::Stripe::StripeObject
          class Discount < ::Stripe::StripeObject
            # The ID of the coupon to apply to this subscription update.
            sig { returns(T.nilable(String)) }
            def coupon; end
            # The ID of a promotion code to apply to this subscription update.
            sig { returns(T.nilable(String)) }
            def promotion_code; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Item < ::Stripe::StripeObject
            # The ID of the [subscription item](https://docs.stripe.com/api/subscriptions/object#subscription_object-items-data-id) to be updated.
            sig { returns(T.nilable(String)) }
            def id; end
            # The price the customer should subscribe to through this flow. The price must also be included in the configuration's [`features.subscription_update.products`](https://docs.stripe.com/api/customer_portal/configuration#portal_configuration_object-features-subscription_update-products).
            sig { returns(T.nilable(String)) }
            def price; end
            # [Quantity](https://docs.stripe.com/subscriptions/quantities) for this item that the customer should subscribe to through this flow.
            sig { returns(T.nilable(Integer)) }
            def quantity; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The coupon or promotion code to apply to this subscription update.
          sig { returns(T.nilable(T::Array[Discount])) }
          def discounts; end
          # The [subscription item](https://docs.stripe.com/api/subscription_items) to be updated through this flow. Currently, only up to one may be specified and subscriptions with multiple items are not updatable.
          sig { returns(T::Array[Item]) }
          def items; end
          # The ID of the subscription to be updated.
          sig { returns(String) }
          def subscription; end
          def self.inner_class_types
            @inner_class_types = {discounts: Discount, items: Item}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field after_completion
        sig { returns(AfterCompletion) }
        def after_completion; end
        # Configuration when `flow.type=subscription_cancel`.
        sig { returns(T.nilable(SubscriptionCancel)) }
        def subscription_cancel; end
        # Configuration when `flow.type=subscription_update`.
        sig { returns(T.nilable(SubscriptionUpdate)) }
        def subscription_update; end
        # Configuration when `flow.type=subscription_update_confirm`.
        sig { returns(T.nilable(SubscriptionUpdateConfirm)) }
        def subscription_update_confirm; end
        # Type of flow that the customer will go through.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {
            after_completion: AfterCompletion,
            subscription_cancel: SubscriptionCancel,
            subscription_update: SubscriptionUpdate,
            subscription_update_confirm: SubscriptionUpdateConfirm,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The configuration used by this session, describing the features available.
      sig { returns(T.any(String, ::Stripe::BillingPortal::Configuration)) }
      def configuration; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # The ID of the customer for this session.
      sig { returns(String) }
      def customer; end
      # The ID of the account for this session.
      sig { returns(T.nilable(String)) }
      def customer_account; end
      # Information about a specific flow for the customer to go through. See the [docs](https://docs.stripe.com/customer-management/portal-deep-links) to learn more about using customer portal deep links and flows.
      sig { returns(T.nilable(Flow)) }
      def flow; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The IETF language tag of the locale Customer Portal is displayed in. If blank or auto, the customer’s `preferred_locales` or browser’s locale is used.
      sig { returns(T.nilable(String)) }
      def locale; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The account for which the session was created on behalf of. When specified, only subscriptions and invoices with this `on_behalf_of` account appear in the portal. For more information, see the [docs](https://docs.stripe.com/connect/separate-charges-and-transfers#settlement-merchant). Use the [Accounts API](https://docs.stripe.com/api/accounts/object#account_object-settings-branding) to modify the `on_behalf_of` account's branding settings, which the portal displays.
      sig { returns(T.nilable(String)) }
      def on_behalf_of; end
      # The URL to redirect customers to when they click on the portal's link to return to your website.
      sig { returns(T.nilable(String)) }
      def return_url; end
      # The short-lived URL of the session that gives customers access to the customer portal.
      sig { returns(String) }
      def url; end
      # Creates a session of the customer portal.
      sig {
        params(params: T.any(::Stripe::BillingPortal::SessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::BillingPortal::Session)
       }
      def self.create(params = {}, opts = {}); end
    end
  end
end