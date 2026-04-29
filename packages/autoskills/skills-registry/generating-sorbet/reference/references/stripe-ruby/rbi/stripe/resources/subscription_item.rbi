# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Subscription items allow you to create customer subscriptions with more than
  # one plan, making it easy to represent complex billing relationships.
  class SubscriptionItem < APIResource
    class BillingThresholds < ::Stripe::StripeObject
      # Usage threshold that triggers the subscription to create an invoice
      sig { returns(T.nilable(Integer)) }
      def usage_gte; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Define thresholds at which an invoice will be sent, and the related subscription advanced to a new billing period
    sig { returns(T.nilable(BillingThresholds)) }
    def billing_thresholds; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # The end time of this subscription item's current billing period.
    sig { returns(Integer) }
    def current_period_end; end
    # The start time of this subscription item's current billing period.
    sig { returns(Integer) }
    def current_period_start; end
    # The discounts applied to the subscription item. Subscription item discounts are applied before subscription discounts. Use `expand[]=discounts` to expand each discount.
    sig { returns(T::Array[T.any(String, ::Stripe::Discount)]) }
    def discounts; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # You can now model subscriptions more flexibly using the [Prices API](https://api.stripe.com#prices). It replaces the Plans API and is backwards compatible to simplify your migration.
    #
    # Plans define the base price, currency, and billing cycle for recurring purchases of products.
    # [Products](https://api.stripe.com#products) help you track inventory or provisioning, and plans help you track pricing. Different physical goods or levels of service should be represented by products, and pricing options should be represented by plans. This approach lets you change prices without having to change your provisioning scheme.
    #
    # For example, you might have a single "gold" product that has plans for $10/month, $100/year, €9/month, and €90/year.
    #
    # Related guides: [Set up a subscription](https://docs.stripe.com/billing/subscriptions/set-up-subscription) and more about [products and prices](https://docs.stripe.com/products-prices/overview).
    sig { returns(::Stripe::Plan) }
    def plan; end
    # Prices define the unit cost, currency, and (optional) billing cycle for both recurring and one-time purchases of products.
    # [Products](https://api.stripe.com#products) help you track inventory or provisioning, and prices help you track payment terms. Different physical goods or levels of service should be represented by products, and pricing options should be represented by prices. This approach lets you change prices without having to change your provisioning scheme.
    #
    # For example, you might have a single "gold" product that has prices for $10/month, $100/year, and €9 once.
    #
    # Related guides: [Set up a subscription](https://docs.stripe.com/billing/subscriptions/set-up-subscription), [create an invoice](https://docs.stripe.com/billing/invoices/create), and more about [products and prices](https://docs.stripe.com/products-prices/overview).
    sig { returns(::Stripe::Price) }
    def price; end
    # The [quantity](https://docs.stripe.com/subscriptions/quantities) of the plan to which the customer should be subscribed.
    sig { returns(T.nilable(Integer)) }
    def quantity; end
    # The `subscription` this `subscription_item` belongs to.
    sig { returns(String) }
    def subscription; end
    # The tax rates which apply to this `subscription_item`. When set, the `default_tax_rates` on the subscription do not apply to this `subscription_item`.
    sig { returns(T.nilable(T::Array[::Stripe::TaxRate])) }
    def tax_rates; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # Adds a new item to an existing subscription. No existing items will be changed or replaced.
    sig {
      params(params: T.any(::Stripe::SubscriptionItemCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionItem)
     }
    def self.create(params = {}, opts = {}); end

    # Deletes an item from the subscription. Removing a subscription item from a subscription will not cancel the subscription.
    sig {
      params(item: String, params: T.any(::Stripe::SubscriptionItemDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionItem)
     }
    def self.delete(item, params = {}, opts = {}); end

    # Deletes an item from the subscription. Removing a subscription item from a subscription will not cancel the subscription.
    sig {
      params(params: T.any(::Stripe::SubscriptionItemDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionItem)
     }
    def delete(params = {}, opts = {}); end

    # Returns a list of your subscription items for a given subscription.
    sig {
      params(params: T.any(::Stripe::SubscriptionItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the plan or quantity of an item on a current subscription.
    sig {
      params(item: String, params: T.any(::Stripe::SubscriptionItemUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionItem)
     }
    def self.update(item, params = {}, opts = {}); end
  end
end