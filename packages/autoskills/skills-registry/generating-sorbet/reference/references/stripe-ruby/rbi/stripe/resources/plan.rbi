# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # You can now model subscriptions more flexibly using the [Prices API](https://api.stripe.com#prices). It replaces the Plans API and is backwards compatible to simplify your migration.
  #
  # Plans define the base price, currency, and billing cycle for recurring purchases of products.
  # [Products](https://api.stripe.com#products) help you track inventory or provisioning, and plans help you track pricing. Different physical goods or levels of service should be represented by products, and pricing options should be represented by plans. This approach lets you change prices without having to change your provisioning scheme.
  #
  # For example, you might have a single "gold" product that has plans for $10/month, $100/year, €9/month, and €90/year.
  #
  # Related guides: [Set up a subscription](https://docs.stripe.com/billing/subscriptions/set-up-subscription) and more about [products and prices](https://docs.stripe.com/products-prices/overview).
  class Plan < APIResource
    class Tier < ::Stripe::StripeObject
      # Price for the entire tier.
      sig { returns(T.nilable(Integer)) }
      def flat_amount; end
      # Same as `flat_amount`, but contains a decimal value with at most 12 decimal places.
      sig { returns(T.nilable(String)) }
      def flat_amount_decimal; end
      # Per unit price for units relevant to the tier.
      sig { returns(T.nilable(Integer)) }
      def unit_amount; end
      # Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
      sig { returns(T.nilable(String)) }
      def unit_amount_decimal; end
      # Up to and including to this quantity will be contained in the tier.
      sig { returns(T.nilable(Integer)) }
      def up_to; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TransformUsage < ::Stripe::StripeObject
      # Divide usage by this number.
      sig { returns(Integer) }
      def divide_by; end
      # After division, either round the result `up` or `down`.
      sig { returns(String) }
      def round; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Whether the plan can be used for new purchases.
    sig { returns(T::Boolean) }
    def active; end
    # The unit amount in cents (or local equivalent) to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.
    sig { returns(T.nilable(Integer)) }
    def amount; end
    # The unit amount in cents (or local equivalent) to be charged, represented as a decimal string with at most 12 decimal places. Only set if `billing_scheme=per_unit`.
    sig { returns(T.nilable(String)) }
    def amount_decimal; end
    # Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `amount`) will be charged per unit in `quantity` (for plans with `usage_type=licensed`), or per unit of total usage (for plans with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    sig { returns(String) }
    def billing_scheme; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.
    sig { returns(String) }
    def interval; end
    # The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
    sig { returns(Integer) }
    def interval_count; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # The meter tracking the usage of a metered price
    sig { returns(T.nilable(String)) }
    def meter; end
    # A brief description of the plan, hidden from customers.
    sig { returns(T.nilable(String)) }
    def nickname; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The product whose pricing this plan determines.
    sig { returns(T.nilable(T.any(String, ::Stripe::Product))) }
    def product; end
    # Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
    sig { returns(T.nilable(T::Array[Tier])) }
    def tiers; end
    # Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price. In `graduated` tiering, pricing can change as the quantity grows.
    sig { returns(T.nilable(String)) }
    def tiers_mode; end
    # Apply a transformation to the reported usage or set quantity before computing the amount billed. Cannot be combined with `tiers`.
    sig { returns(T.nilable(TransformUsage)) }
    def transform_usage; end
    # Default number of trial days when subscribing a customer to this plan using [`trial_from_plan=true`](https://docs.stripe.com/api#create_subscription-trial_from_plan).
    sig { returns(T.nilable(Integer)) }
    def trial_period_days; end
    # Configures how the quantity per period should be determined. Can be either `metered` or `licensed`. `licensed` automatically bills the `quantity` set when adding it to a subscription. `metered` aggregates the total usage based on usage records. Defaults to `licensed`.
    sig { returns(String) }
    def usage_type; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # You can now model subscriptions more flexibly using the [Prices API](https://docs.stripe.com/api#prices). It replaces the Plans API and is backwards compatible to simplify your migration.
    sig {
      params(params: T.any(::Stripe::PlanCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Plan)
     }
    def self.create(params = {}, opts = {}); end

    # Deleting plans means new subscribers can't be added. Existing subscribers aren't affected.
    sig {
      params(plan: String, params: T.any(::Stripe::PlanDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Plan)
     }
    def self.delete(plan, params = {}, opts = {}); end

    # Deleting plans means new subscribers can't be added. Existing subscribers aren't affected.
    sig {
      params(params: T.any(::Stripe::PlanDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Plan)
     }
    def delete(params = {}, opts = {}); end

    # Returns a list of your plans.
    sig {
      params(params: T.any(::Stripe::PlanListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the specified plan by setting the values of the parameters passed. Any parameters not provided are left unchanged. By design, you cannot change a plan's ID, amount, currency, or billing cycle.
    sig {
      params(plan: String, params: T.any(::Stripe::PlanUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Plan)
     }
    def self.update(plan, params = {}, opts = {}); end
  end
end