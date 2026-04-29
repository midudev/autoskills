# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ProductCreateParams < ::Stripe::RequestParams
    class DefaultPriceData < ::Stripe::RequestParams
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
        sig {
          returns(T.nilable(ProductCreateParams::DefaultPriceData::CurrencyOptions::CustomUnitAmount))
         }
        def custom_unit_amount; end
        sig {
          params(_custom_unit_amount: T.nilable(ProductCreateParams::DefaultPriceData::CurrencyOptions::CustomUnitAmount)).returns(T.nilable(ProductCreateParams::DefaultPriceData::CurrencyOptions::CustomUnitAmount))
         }
        def custom_unit_amount=(_custom_unit_amount); end
        # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        # Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
        sig {
          returns(T.nilable(T::Array[ProductCreateParams::DefaultPriceData::CurrencyOptions::Tier]))
         }
        def tiers; end
        sig {
          params(_tiers: T.nilable(T::Array[ProductCreateParams::DefaultPriceData::CurrencyOptions::Tier])).returns(T.nilable(T::Array[ProductCreateParams::DefaultPriceData::CurrencyOptions::Tier]))
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
          params(custom_unit_amount: T.nilable(ProductCreateParams::DefaultPriceData::CurrencyOptions::CustomUnitAmount), tax_behavior: T.nilable(String), tiers: T.nilable(T::Array[ProductCreateParams::DefaultPriceData::CurrencyOptions::Tier]), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
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
        sig { params(interval: String, interval_count: T.nilable(Integer)).void }
        def initialize(interval: nil, interval_count: nil); end
      end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      sig { params(_currency: String).returns(String) }
      def currency=(_currency); end
      # Prices defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
      sig {
        returns(T.nilable(T::Hash[String, ProductCreateParams::DefaultPriceData::CurrencyOptions]))
       }
      def currency_options; end
      sig {
        params(_currency_options: T.nilable(T::Hash[String, ProductCreateParams::DefaultPriceData::CurrencyOptions])).returns(T.nilable(T::Hash[String, ProductCreateParams::DefaultPriceData::CurrencyOptions]))
       }
      def currency_options=(_currency_options); end
      # When set, provides configuration for the amount to be adjusted by the customer during Checkout Sessions and Payment Links.
      sig { returns(T.nilable(ProductCreateParams::DefaultPriceData::CustomUnitAmount)) }
      def custom_unit_amount; end
      sig {
        params(_custom_unit_amount: T.nilable(ProductCreateParams::DefaultPriceData::CustomUnitAmount)).returns(T.nilable(ProductCreateParams::DefaultPriceData::CustomUnitAmount))
       }
      def custom_unit_amount=(_custom_unit_amount); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The recurring components of a price such as `interval` and `interval_count`.
      sig { returns(T.nilable(ProductCreateParams::DefaultPriceData::Recurring)) }
      def recurring; end
      sig {
        params(_recurring: T.nilable(ProductCreateParams::DefaultPriceData::Recurring)).returns(T.nilable(ProductCreateParams::DefaultPriceData::Recurring))
       }
      def recurring=(_recurring); end
      # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
      sig { returns(T.nilable(String)) }
      def tax_behavior; end
      sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def tax_behavior=(_tax_behavior); end
      # A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge. One of `unit_amount`, `unit_amount_decimal`, or `custom_unit_amount` is required.
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
        params(currency: String, currency_options: T.nilable(T::Hash[String, ProductCreateParams::DefaultPriceData::CurrencyOptions]), custom_unit_amount: T.nilable(ProductCreateParams::DefaultPriceData::CustomUnitAmount), metadata: T.nilable(T::Hash[String, String]), recurring: T.nilable(ProductCreateParams::DefaultPriceData::Recurring), tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
       }
      def initialize(
        currency: nil,
        currency_options: nil,
        custom_unit_amount: nil,
        metadata: nil,
        recurring: nil,
        tax_behavior: nil,
        unit_amount: nil,
        unit_amount_decimal: nil
      ); end
    end
    class MarketingFeature < ::Stripe::RequestParams
      # The marketing feature name. Up to 80 characters long.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      sig { params(name: String).void }
      def initialize(name: nil); end
    end
    class PackageDimensions < ::Stripe::RequestParams
      # Height, in inches. Maximum precision is 2 decimal places.
      sig { returns(Float) }
      def height; end
      sig { params(_height: Float).returns(Float) }
      def height=(_height); end
      # Length, in inches. Maximum precision is 2 decimal places.
      sig { returns(Float) }
      def length; end
      sig { params(_length: Float).returns(Float) }
      def length=(_length); end
      # Weight, in ounces. Maximum precision is 2 decimal places.
      sig { returns(Float) }
      def weight; end
      sig { params(_weight: Float).returns(Float) }
      def weight=(_weight); end
      # Width, in inches. Maximum precision is 2 decimal places.
      sig { returns(Float) }
      def width; end
      sig { params(_width: Float).returns(Float) }
      def width=(_width); end
      sig { params(height: Float, length: Float, weight: Float, width: Float).void }
      def initialize(height: nil, length: nil, weight: nil, width: nil); end
    end
    # Whether the product is currently available for purchase. Defaults to `true`.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object. This Price will be set as the default price for this product.
    sig { returns(T.nilable(ProductCreateParams::DefaultPriceData)) }
    def default_price_data; end
    sig {
      params(_default_price_data: T.nilable(ProductCreateParams::DefaultPriceData)).returns(T.nilable(ProductCreateParams::DefaultPriceData))
     }
    def default_price_data=(_default_price_data); end
    # The product's description, meant to be displayable to the customer. Use this field to optionally store a long form explanation of the product being sold for your own rendering purposes.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # An identifier will be randomly generated by Stripe. You can optionally override this ID, but the ID must be unique across all products in your Stripe account.
    sig { returns(T.nilable(String)) }
    def id; end
    sig { params(_id: T.nilable(String)).returns(T.nilable(String)) }
    def id=(_id); end
    # A list of up to 8 URLs of images for this product, meant to be displayable to the customer.
    sig { returns(T.nilable(T::Array[String])) }
    def images; end
    sig { params(_images: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def images=(_images); end
    # A list of up to 15 marketing features for this product. These are displayed in [pricing tables](https://docs.stripe.com/payments/checkout/pricing-table).
    sig { returns(T.nilable(T::Array[ProductCreateParams::MarketingFeature])) }
    def marketing_features; end
    sig {
      params(_marketing_features: T.nilable(T::Array[ProductCreateParams::MarketingFeature])).returns(T.nilable(T::Array[ProductCreateParams::MarketingFeature]))
     }
    def marketing_features=(_marketing_features); end
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
    # The dimensions of this product for shipping purposes.
    sig { returns(T.nilable(ProductCreateParams::PackageDimensions)) }
    def package_dimensions; end
    sig {
      params(_package_dimensions: T.nilable(ProductCreateParams::PackageDimensions)).returns(T.nilable(ProductCreateParams::PackageDimensions))
     }
    def package_dimensions=(_package_dimensions); end
    # Whether this product is shipped (i.e., physical goods).
    sig { returns(T.nilable(T::Boolean)) }
    def shippable; end
    sig { params(_shippable: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def shippable=(_shippable); end
    # An arbitrary string to be displayed on your customer's credit card or bank statement. While most banks display this information consistently, some may display it incorrectly or not at all.
    #
    # This may be up to 22 characters. The statement description may not include `<`, `>`, `\`, `"`, `'` characters, and will appear on your customer's statement in capital letters. Non-ASCII characters are automatically stripped.
    #  It must contain at least one letter. Only used for subscription payments.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor=(_statement_descriptor); end
    # A [tax code](https://docs.stripe.com/tax/tax-categories) ID.
    sig { returns(T.nilable(String)) }
    def tax_code; end
    sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
    def tax_code=(_tax_code); end
    # The type of the product. Defaults to `service` if not explicitly specified, enabling use of this product with Subscriptions and Plans. Set this parameter to `good` to use this product with Orders and SKUs. On API versions before `2018-02-05`, this field defaults to `good` for compatibility reasons.
    sig { returns(T.nilable(String)) }
    def type; end
    sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
    def type=(_type); end
    # A label that represents units of this product. When set, this will be included in customers' receipts, invoices, Checkout, and the customer portal.
    sig { returns(T.nilable(String)) }
    def unit_label; end
    sig { params(_unit_label: T.nilable(String)).returns(T.nilable(String)) }
    def unit_label=(_unit_label); end
    # A URL of a publicly-accessible webpage for this product.
    sig { returns(T.nilable(String)) }
    def url; end
    sig { params(_url: T.nilable(String)).returns(T.nilable(String)) }
    def url=(_url); end
    sig {
      params(active: T.nilable(T::Boolean), default_price_data: T.nilable(ProductCreateParams::DefaultPriceData), description: T.nilable(String), expand: T.nilable(T::Array[String]), id: T.nilable(String), images: T.nilable(T::Array[String]), marketing_features: T.nilable(T::Array[ProductCreateParams::MarketingFeature]), metadata: T.nilable(T::Hash[String, String]), name: String, package_dimensions: T.nilable(ProductCreateParams::PackageDimensions), shippable: T.nilable(T::Boolean), statement_descriptor: T.nilable(String), tax_code: T.nilable(String), type: T.nilable(String), unit_label: T.nilable(String), url: T.nilable(String)).void
     }
    def initialize(
      active: nil,
      default_price_data: nil,
      description: nil,
      expand: nil,
      id: nil,
      images: nil,
      marketing_features: nil,
      metadata: nil,
      name: nil,
      package_dimensions: nil,
      shippable: nil,
      statement_descriptor: nil,
      tax_code: nil,
      type: nil,
      unit_label: nil,
      url: nil
    ); end
  end
end