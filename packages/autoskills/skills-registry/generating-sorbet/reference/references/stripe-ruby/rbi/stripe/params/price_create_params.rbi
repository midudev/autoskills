# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PriceCreateParams < ::Stripe::RequestParams
    class CurrencyOptions < ::Stripe::RequestParams
      class CustomUnitAmount < ::Stripe::RequestParams
        # Pass in `true` to enable `custom_unit_amount`, otherwise omit `custom_unit_amount`.
        sig { returns(T::Boolean) }
        def enabled; end
        sig { params(_enabled: T::Boolean).returns(T::Boolean) }
        def enabled=(_enabled); end
        # The maximum unit amount the customer can specify for this item.
        sig { returns(T.nilable(Integer)) }
        def maximum; end
        sig { params(_maximum: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def maximum=(_maximum); end
        # The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount.
        sig { returns(T.nilable(Integer)) }
        def minimum; end
        sig { params(_minimum: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def minimum=(_minimum); end
        # The starting unit amount which can be updated by the customer.
        sig { returns(T.nilable(Integer)) }
        def preset; end
        sig { params(_preset: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def preset=(_preset); end
        sig {
          params(enabled: T::Boolean, maximum: T.nilable(Integer), minimum: T.nilable(Integer), preset: T.nilable(Integer)).void
         }
        def initialize(enabled: nil, maximum: nil, minimum: nil, preset: nil); end
      end
      class Tier < ::Stripe::RequestParams
        # The flat billing amount for an entire tier, regardless of the number of units in the tier.
        sig { returns(T.nilable(Integer)) }
        def flat_amount; end
        sig { params(_flat_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def flat_amount=(_flat_amount); end
        # Same as `flat_amount`, but accepts a decimal value representing an integer in the minor units of the currency. Only one of `flat_amount` and `flat_amount_decimal` can be set.
        sig { returns(T.nilable(String)) }
        def flat_amount_decimal; end
        sig { params(_flat_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
        def flat_amount_decimal=(_flat_amount_decimal); end
        # The per unit billing amount for each individual unit for which this tier applies.
        sig { returns(T.nilable(Integer)) }
        def unit_amount; end
        sig { params(_unit_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def unit_amount=(_unit_amount); end
        # Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
        sig { returns(T.nilable(String)) }
        def unit_amount_decimal; end
        sig { params(_unit_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
        def unit_amount_decimal=(_unit_amount_decimal); end
        # Specifies the upper bound of this tier. The lower bound of a tier is the upper bound of the previous tier adding one. Use `inf` to define a fallback tier.
        sig { returns(T.any(String, Integer)) }
        def up_to; end
        sig { params(_up_to: T.any(String, Integer)).returns(T.any(String, Integer)) }
        def up_to=(_up_to); end
        sig {
          params(flat_amount: T.nilable(Integer), flat_amount_decimal: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String), up_to: T.any(String, Integer)).void
         }
        def initialize(
          flat_amount: nil,
          flat_amount_decimal: nil,
          unit_amount: nil,
          unit_amount_decimal: nil,
          up_to: nil
        ); end
      end
      # When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
      sig { returns(T.nilable(PriceCreateParams::CurrencyOptions::CustomUnitAmount)) }
      def custom_unit_amount; end
      sig {
        params(_custom_unit_amount: T.nilable(PriceCreateParams::CurrencyOptions::CustomUnitAmount)).returns(T.nilable(PriceCreateParams::CurrencyOptions::CustomUnitAmount))
       }
      def custom_unit_amount=(_custom_unit_amount); end
      # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
      sig { returns(T.nilable(String)) }
      def tax_behavior; end
      sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def tax_behavior=(_tax_behavior); end
      # Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
      sig { returns(T.nilable(T::Array[PriceCreateParams::CurrencyOptions::Tier])) }
      def tiers; end
      sig {
        params(_tiers: T.nilable(T::Array[PriceCreateParams::CurrencyOptions::Tier])).returns(T.nilable(T::Array[PriceCreateParams::CurrencyOptions::Tier]))
       }
      def tiers=(_tiers); end
      # A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge.
      sig { returns(T.nilable(Integer)) }
      def unit_amount; end
      sig { params(_unit_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def unit_amount=(_unit_amount); end
      # Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
      sig { returns(T.nilable(String)) }
      def unit_amount_decimal; end
      sig { params(_unit_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
      def unit_amount_decimal=(_unit_amount_decimal); end
      sig {
        params(custom_unit_amount: T.nilable(PriceCreateParams::CurrencyOptions::CustomUnitAmount), tax_behavior: T.nilable(String), tiers: T.nilable(T::Array[PriceCreateParams::CurrencyOptions::Tier]), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
       }
      def initialize(
        custom_unit_amount: nil,
        tax_behavior: nil,
        tiers: nil,
        unit_amount: nil,
        unit_amount_decimal: nil
      ); end
    end
    class CustomUnitAmount < ::Stripe::RequestParams
      # Pass in `true` to enable `custom_unit_amount`, otherwise omit `custom_unit_amount`.
      sig { returns(T::Boolean) }
      def enabled; end
      sig { params(_enabled: T::Boolean).returns(T::Boolean) }
      def enabled=(_enabled); end
      # The maximum unit amount the customer can specify for this item.
      sig { returns(T.nilable(Integer)) }
      def maximum; end
      sig { params(_maximum: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def maximum=(_maximum); end
      # The minimum unit amount the customer can specify for this item. Must be at least the minimum charge amount.
      sig { returns(T.nilable(Integer)) }
      def minimum; end
      sig { params(_minimum: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def minimum=(_minimum); end
      # The starting unit amount which can be updated by the customer.
      sig { returns(T.nilable(Integer)) }
      def preset; end
      sig { params(_preset: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def preset=(_preset); end
      sig {
        params(enabled: T::Boolean, maximum: T.nilable(Integer), minimum: T.nilable(Integer), preset: T.nilable(Integer)).void
       }
      def initialize(enabled: nil, maximum: nil, minimum: nil, preset: nil); end
    end
    class ProductData < ::Stripe::RequestParams
      # Whether the product is currently available for purchase. Defaults to `true`.
      sig { returns(T.nilable(T::Boolean)) }
      def active; end
      sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def active=(_active); end
      # The identifier for the product. Must be unique. If not provided, an identifier will be randomly generated.
      sig { returns(T.nilable(String)) }
      def id; end
      sig { params(_id: T.nilable(String)).returns(T.nilable(String)) }
      def id=(_id); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The product's name, meant to be displayable to the customer.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # An arbitrary string to be displayed on your customer's credit card or bank statement. While most banks display this information consistently, some may display it incorrectly or not at all.
      #
      # This may be up to 22 characters. The statement description may not include `<`, `>`, `\`, `"`, `'` characters, and will appear on your customer's statement in capital letters. Non-ASCII characters are automatically stripped.
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
      def statement_descriptor=(_statement_descriptor); end
      # A [tax code](https://docs.stripe.com/tax/tax-categories) ID.
      sig { returns(T.nilable(String)) }
      def tax_code; end
      sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
      def tax_code=(_tax_code); end
      # A label that represents units of this product. When set, this will be included in customers' receipts, invoices, Checkout, and the customer portal.
      sig { returns(T.nilable(String)) }
      def unit_label; end
      sig { params(_unit_label: T.nilable(String)).returns(T.nilable(String)) }
      def unit_label=(_unit_label); end
      sig {
        params(active: T.nilable(T::Boolean), id: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), name: String, statement_descriptor: T.nilable(String), tax_code: T.nilable(String), unit_label: T.nilable(String)).void
       }
      def initialize(
        active: nil,
        id: nil,
        metadata: nil,
        name: nil,
        statement_descriptor: nil,
        tax_code: nil,
        unit_label: nil
      ); end
    end
    class Recurring < ::Stripe::RequestParams
      # Specifies billing frequency. Either `day`, `week`, `month` or `year`.
      sig { returns(String) }
      def interval; end
      sig { params(_interval: String).returns(String) }
      def interval=(_interval); end
      # The number of intervals between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months. Maximum of three years interval allowed (3 years, 36 months, or 156 weeks).
      sig { returns(T.nilable(Integer)) }
      def interval_count; end
      sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def interval_count=(_interval_count); end
      # The meter tracking the usage of a metered price
      sig { returns(T.nilable(String)) }
      def meter; end
      sig { params(_meter: T.nilable(String)).returns(T.nilable(String)) }
      def meter=(_meter); end
      # Default number of trial days when subscribing a customer to this price using [`trial_from_plan=true`](https://docs.stripe.com/api#create_subscription-trial_from_plan).
      sig { returns(T.nilable(Integer)) }
      def trial_period_days; end
      sig { params(_trial_period_days: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def trial_period_days=(_trial_period_days); end
      # Configures how the quantity per period should be determined. Can be either `metered` or `licensed`. `licensed` automatically bills the `quantity` set when adding it to a subscription. `metered` aggregates the total usage based on usage records. Defaults to `licensed`.
      sig { returns(T.nilable(String)) }
      def usage_type; end
      sig { params(_usage_type: T.nilable(String)).returns(T.nilable(String)) }
      def usage_type=(_usage_type); end
      sig {
        params(interval: String, interval_count: T.nilable(Integer), meter: T.nilable(String), trial_period_days: T.nilable(Integer), usage_type: T.nilable(String)).void
       }
      def initialize(
        interval: nil,
        interval_count: nil,
        meter: nil,
        trial_period_days: nil,
        usage_type: nil
      ); end
    end
    class Tier < ::Stripe::RequestParams
      # The flat billing amount for an entire tier, regardless of the number of units in the tier.
      sig { returns(T.nilable(Integer)) }
      def flat_amount; end
      sig { params(_flat_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def flat_amount=(_flat_amount); end
      # Same as `flat_amount`, but accepts a decimal value representing an integer in the minor units of the currency. Only one of `flat_amount` and `flat_amount_decimal` can be set.
      sig { returns(T.nilable(String)) }
      def flat_amount_decimal; end
      sig { params(_flat_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
      def flat_amount_decimal=(_flat_amount_decimal); end
      # The per unit billing amount for each individual unit for which this tier applies.
      sig { returns(T.nilable(Integer)) }
      def unit_amount; end
      sig { params(_unit_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def unit_amount=(_unit_amount); end
      # Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
      sig { returns(T.nilable(String)) }
      def unit_amount_decimal; end
      sig { params(_unit_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
      def unit_amount_decimal=(_unit_amount_decimal); end
      # Specifies the upper bound of this tier. The lower bound of a tier is the upper bound of the previous tier adding one. Use `inf` to define a fallback tier.
      sig { returns(T.any(String, Integer)) }
      def up_to; end
      sig { params(_up_to: T.any(String, Integer)).returns(T.any(String, Integer)) }
      def up_to=(_up_to); end
      sig {
        params(flat_amount: T.nilable(Integer), flat_amount_decimal: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String), up_to: T.any(String, Integer)).void
       }
      def initialize(
        flat_amount: nil,
        flat_amount_decimal: nil,
        unit_amount: nil,
        unit_amount_decimal: nil,
        up_to: nil
      ); end
    end
    class TransformQuantity < ::Stripe::RequestParams
      # Divide usage by this number.
      sig { returns(Integer) }
      def divide_by; end
      sig { params(_divide_by: Integer).returns(Integer) }
      def divide_by=(_divide_by); end
      # After division, either round the result `up` or `down`.
      sig { returns(String) }
      def round; end
      sig { params(_round: String).returns(String) }
      def round=(_round); end
      sig { params(divide_by: Integer, round: String).void }
      def initialize(divide_by: nil, round: nil); end
    end
    # Whether the price can be used for new purchases. Defaults to `true`.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # Describes how to compute the price per period. Either `per_unit` or `tiered`. `per_unit` indicates that the fixed amount (specified in `unit_amount` or `unit_amount_decimal`) will be charged per unit in `quantity` (for prices with `usage_type=licensed`), or per unit of total usage (for prices with `usage_type=metered`). `tiered` indicates that the unit pricing will be computed using a tiering strategy as defined using the `tiers` and `tiers_mode` attributes.
    sig { returns(T.nilable(String)) }
    def billing_scheme; end
    sig { params(_billing_scheme: T.nilable(String)).returns(T.nilable(String)) }
    def billing_scheme=(_billing_scheme); end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    sig { params(_currency: String).returns(String) }
    def currency=(_currency); end
    # Prices defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(T::Hash[String, PriceCreateParams::CurrencyOptions])) }
    def currency_options; end
    sig {
      params(_currency_options: T.nilable(T::Hash[String, PriceCreateParams::CurrencyOptions])).returns(T.nilable(T::Hash[String, PriceCreateParams::CurrencyOptions]))
     }
    def currency_options=(_currency_options); end
    # When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
    sig { returns(T.nilable(PriceCreateParams::CustomUnitAmount)) }
    def custom_unit_amount; end
    sig {
      params(_custom_unit_amount: T.nilable(PriceCreateParams::CustomUnitAmount)).returns(T.nilable(PriceCreateParams::CustomUnitAmount))
     }
    def custom_unit_amount=(_custom_unit_amount); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # A lookup key used to retrieve prices dynamically from a static string. This may be up to 200 characters.
    sig { returns(T.nilable(String)) }
    def lookup_key; end
    sig { params(_lookup_key: T.nilable(String)).returns(T.nilable(String)) }
    def lookup_key=(_lookup_key); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    # A brief description of the price, hidden from customers.
    sig { returns(T.nilable(String)) }
    def nickname; end
    sig { params(_nickname: T.nilable(String)).returns(T.nilable(String)) }
    def nickname=(_nickname); end
    # The ID of the [Product](https://docs.stripe.com/api/products) that this [Price](https://docs.stripe.com/api/prices) will belong to.
    sig { returns(T.nilable(String)) }
    def product; end
    sig { params(_product: T.nilable(String)).returns(T.nilable(String)) }
    def product=(_product); end
    # These fields can be used to create a new product that this price will belong to.
    sig { returns(T.nilable(PriceCreateParams::ProductData)) }
    def product_data; end
    sig {
      params(_product_data: T.nilable(PriceCreateParams::ProductData)).returns(T.nilable(PriceCreateParams::ProductData))
     }
    def product_data=(_product_data); end
    # The recurring components of a price such as `interval` and `usage_type`.
    sig { returns(T.nilable(PriceCreateParams::Recurring)) }
    def recurring; end
    sig {
      params(_recurring: T.nilable(PriceCreateParams::Recurring)).returns(T.nilable(PriceCreateParams::Recurring))
     }
    def recurring=(_recurring); end
    # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
    sig { returns(T.nilable(String)) }
    def tax_behavior; end
    sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def tax_behavior=(_tax_behavior); end
    # Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
    sig { returns(T.nilable(T::Array[PriceCreateParams::Tier])) }
    def tiers; end
    sig {
      params(_tiers: T.nilable(T::Array[PriceCreateParams::Tier])).returns(T.nilable(T::Array[PriceCreateParams::Tier]))
     }
    def tiers=(_tiers); end
    # Defines if the tiering price should be `graduated` or `volume` based. In `volume`-based tiering, the maximum quantity within a period determines the per unit price, in `graduated` tiering pricing can successively change as the quantity grows.
    sig { returns(T.nilable(String)) }
    def tiers_mode; end
    sig { params(_tiers_mode: T.nilable(String)).returns(T.nilable(String)) }
    def tiers_mode=(_tiers_mode); end
    # If set to true, will atomically remove the lookup key from the existing price, and assign it to this price.
    sig { returns(T.nilable(T::Boolean)) }
    def transfer_lookup_key; end
    sig { params(_transfer_lookup_key: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def transfer_lookup_key=(_transfer_lookup_key); end
    # Apply a transformation to the reported usage or set quantity before computing the billed price. Cannot be combined with `tiers`.
    sig { returns(T.nilable(PriceCreateParams::TransformQuantity)) }
    def transform_quantity; end
    sig {
      params(_transform_quantity: T.nilable(PriceCreateParams::TransformQuantity)).returns(T.nilable(PriceCreateParams::TransformQuantity))
     }
    def transform_quantity=(_transform_quantity); end
    # A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge. One of `unit_amount`, `unit_amount_decimal`, or `custom_unit_amount` is required, unless `billing_scheme=tiered`.
    sig { returns(T.nilable(Integer)) }
    def unit_amount; end
    sig { params(_unit_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def unit_amount=(_unit_amount); end
    # Same as `unit_amount`, but accepts a decimal value in cents (or local equivalent) with at most 12 decimal places. Only one of `unit_amount` and `unit_amount_decimal` can be set.
    sig { returns(T.nilable(String)) }
    def unit_amount_decimal; end
    sig { params(_unit_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
    def unit_amount_decimal=(_unit_amount_decimal); end
    sig {
      params(active: T.nilable(T::Boolean), billing_scheme: T.nilable(String), currency: String, currency_options: T.nilable(T::Hash[String, PriceCreateParams::CurrencyOptions]), custom_unit_amount: T.nilable(PriceCreateParams::CustomUnitAmount), expand: T.nilable(T::Array[String]), lookup_key: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), nickname: T.nilable(String), product: T.nilable(String), product_data: T.nilable(PriceCreateParams::ProductData), recurring: T.nilable(PriceCreateParams::Recurring), tax_behavior: T.nilable(String), tiers: T.nilable(T::Array[PriceCreateParams::Tier]), tiers_mode: T.nilable(String), transfer_lookup_key: T.nilable(T::Boolean), transform_quantity: T.nilable(PriceCreateParams::TransformQuantity), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
     }
    def initialize(
      active: nil,
      billing_scheme: nil,
      currency: nil,
      currency_options: nil,
      custom_unit_amount: nil,
      expand: nil,
      lookup_key: nil,
      metadata: nil,
      nickname: nil,
      product: nil,
      product_data: nil,
      recurring: nil,
      tax_behavior: nil,
      tiers: nil,
      tiers_mode: nil,
      transfer_lookup_key: nil,
      transform_quantity: nil,
      unit_amount: nil,
      unit_amount_decimal: nil
    ); end
  end
end