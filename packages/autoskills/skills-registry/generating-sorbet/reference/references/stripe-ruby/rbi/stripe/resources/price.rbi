# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Prices define the unit cost, currency, and (optional) billing cycle for both recurring and one-time purchases of products.
  # [Products](https://api.stripe.com#products) help you track inventory or provisioning, and prices help you track payment terms. Different physical goods or levels of service should be represented by products, and pricing options should be represented by prices. This approach lets you change prices without having to change your provisioning scheme.
  #
  # For example, you might have a single "gold" product that has prices for $10/month, $100/year, and €9 once.
  #
  # Related guides: [Set up a subscription](https://docs.stripe.com/billing/subscriptions/set-up-subscription), [create an invoice](https://docs.stripe.com/billing/invoices/create), and more about [products and prices](https://docs.stripe.com/products-prices/overview).
  class Price < APIResource
    class CurrencyOptions < ::Stripe::StripeObject
      class CustomUnitAmount < ::Stripe::StripeObject
        # The maximum unit amount the customer can specify for this item.
        sig { returns(T.nilable(Integer)) }
        def maximum; end
        # The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount.
        sig { returns(T.nilable(Integer)) }
        def minimum; end
        # The starting unit amount which can be updated by the customer.
        sig { returns(T.nilable(Integer)) }
        def preset; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
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
      # When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
      sig { returns(T.nilable(CustomUnitAmount)) }
      def custom_unit_amount; end
      # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
      sig { returns(T.nilable(String)) }
      def tax_behavior; end
      # Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
      sig { returns(T.nilable(T::Array[Tier])) }
      def tiers; end
      # The unit amount in cents (or local equivalent) to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.
      sig { returns(T.nilable(Integer)) }
      def unit_amount; end
      # The unit amount in cents (or local equivalent) to be charged, represented as a decimal string with at most 12 decimal places. Only set if `billing_scheme=per_unit`.
      sig { returns(T.nilable(String)) }
      def unit_amount_decimal; end
      def self.inner_class_types
        @inner_class_types = {custom_unit_amount: CustomUnitAmount, tiers: Tier}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CustomUnitAmount < ::Stripe::StripeObject
      # The maximum unit amount the customer can specify for this item.
      sig { returns(T.nilable(Integer)) }
      def maximum; end
      # The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount.
      sig { returns(T.nilable(Integer)) }
      def minimum; end
      # The starting unit amount which can be updated by the customer.
      sig { returns(T.nilable(Integer)) }
      def preset; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Recurring < ::Stripe::StripeObject
      # The frequency at which a subscription is billed. One of `day`, `week`, `month` or `year`.
      sig { returns(String) }
      def interval; end
      # The number of intervals (specified in the `interval` attribute) between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months.
      sig { returns(Integer) }
      def interval_count; end
      # The meter tracking the usage of a metered price
      sig { returns(T.nilable(String)) }
      def meter; end
      # Default number of trial days when subscribing a customer to this price using [`trial_from_plan=true`](https://docs.stripe.com/api#create_subscription-trial_from_plan).
      sig { returns(T.nilable(Integer)) }
      def trial_period_days; end
      # Configures how the quantity per period should be determined. Can be either `metered` or `licensed`. `licensed` automatically bills the `quantity` set when adding it to a subscription. `metered` aggregates the total usage based on usage records. Defaults to `licensed`.
      sig { returns(String) }
      def usage_type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
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
    class TransformQuantity < ::Stripe::StripeObject
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
    # Whether the price can be used for new purchases.
    sig { returns(T::Boolean) }
    def active; end
    # Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in `quantity` (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    sig { returns(String) }
    def billing_scheme; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # Prices defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(T::Hash[String, CurrencyOptions])) }
    def currency_options; end
    # When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
    sig { returns(T.nilable(CustomUnitAmount)) }
    def custom_unit_amount; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # A lookup key used to retrieve prices dynamically from a static string. This may be up to 200 characters.
    sig { returns(T.nilable(String)) }
    def lookup_key; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # A brief description of the price, hidden from customers.
    sig { returns(T.nilable(String)) }
    def nickname; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The ID of the product this price is associated with.
    sig { returns(T.any(String, ::Stripe::Product)) }
    def product; end
    # The recurring components of a price such as `interval` and `usage_type`.
    sig { returns(T.nilable(Recurring)) }
    def recurring; end
    # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
    sig { returns(T.nilable(String)) }
    def tax_behavior; end
    # Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
    sig { returns(T.nilable(T::Array[Tier])) }
    def tiers; end
    # Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price. In `graduated` tiering, pricing can change as the quantity grows.
    sig { returns(T.nilable(String)) }
    def tiers_mode; end
    # Apply a transformation to the reported usage or set quantity before computing the amount billed. Cannot be combined with `tiers`.
    sig { returns(T.nilable(TransformQuantity)) }
    def transform_quantity; end
    # One of `one_time` or `recurring` depending on whether the price is for a one-time purchase or a recurring (subscription) purchase.
    sig { returns(String) }
    def type; end
    # The unit amount in cents (or local equivalent) to be charged, represented as a whole integer if possible. Only set if `billing_scheme=per_unit`.
    sig { returns(T.nilable(Integer)) }
    def unit_amount; end
    # The unit amount in cents (or local equivalent) to be charged, represented as a decimal string with at most 12 decimal places. Only set if `billing_scheme=per_unit`.
    sig { returns(T.nilable(String)) }
    def unit_amount_decimal; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # Creates a new [Price for an existing <a href="https://docs.stripe.com/api/products">Product](https://docs.stripe.com/api/prices). The Price can be recurring or one-time.
    sig {
      params(params: T.any(::Stripe::PriceCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Price)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of your active prices, excluding [inline prices](https://docs.stripe.com/docs/products-prices/pricing-models#inline-pricing). For the list of inactive prices, set active to false.
    sig {
      params(params: T.any(::Stripe::PriceListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::PriceSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search(params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::PriceSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped, blk: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search_auto_paging_each(params = {}, opts = {}, &blk); end

    # Updates the specified price by setting the values of the parameters passed. Any parameters not provided are left unchanged.
    sig {
      params(price: String, params: T.any(::Stripe::PriceUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Price)
     }
    def self.update(price, params = {}, opts = {}); end
  end
end