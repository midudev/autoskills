# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceItemUpdateParams < ::Stripe::RequestParams
    class Discount < ::Stripe::RequestParams
      # ID of the coupon to create a new discount for.
      sig { returns(T.nilable(String)) }
      def coupon; end
      sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
      def coupon=(_coupon); end
      # ID of an existing discount on the object (or one of its ancestors) to reuse.
      sig { returns(T.nilable(String)) }
      def discount; end
      sig { params(_discount: T.nilable(String)).returns(T.nilable(String)) }
      def discount=(_discount); end
      # ID of the promotion code to create a new discount for.
      sig { returns(T.nilable(String)) }
      def promotion_code; end
      sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
      def promotion_code=(_promotion_code); end
      sig {
        params(coupon: T.nilable(String), discount: T.nilable(String), promotion_code: T.nilable(String)).void
       }
      def initialize(coupon: nil, discount: nil, promotion_code: nil); end
    end
    class Period < ::Stripe::RequestParams
      # The end of the period, which must be greater than or equal to the start. This value is inclusive.
      sig { returns(Integer) }
      def end; end
      sig { params(_end: Integer).returns(Integer) }
      def end=(_end); end
      # The start of the period. This value is inclusive.
      sig { returns(Integer) }
      def start; end
      sig { params(_start: Integer).returns(Integer) }
      def start=(_start); end
      sig { params(end_: Integer, start: Integer).void }
      def initialize(end_: nil, start: nil); end
    end
    class PriceData < ::Stripe::RequestParams
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      sig { params(_currency: String).returns(String) }
      def currency=(_currency); end
      # The ID of the [Product](https://docs.stripe.com/api/products) that this [Price](https://docs.stripe.com/api/prices) will belong to.
      sig { returns(String) }
      def product; end
      sig { params(_product: String).returns(String) }
      def product=(_product); end
      # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
      sig { returns(T.nilable(String)) }
      def tax_behavior; end
      sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def tax_behavior=(_tax_behavior); end
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
        params(currency: String, product: String, tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
       }
      def initialize(
        currency: nil,
        product: nil,
        tax_behavior: nil,
        unit_amount: nil,
        unit_amount_decimal: nil
      ); end
    end
    class Pricing < ::Stripe::RequestParams
      # The ID of the price object.
      sig { returns(T.nilable(String)) }
      def price; end
      sig { params(_price: T.nilable(String)).returns(T.nilable(String)) }
      def price=(_price); end
      sig { params(price: T.nilable(String)).void }
      def initialize(price: nil); end
    end
    # The integer amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice. If you want to apply a credit to the customer's account, pass a negative amount.
    sig { returns(T.nilable(Integer)) }
    def amount; end
    sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount=(_amount); end
    # An arbitrary string which you can attach to the invoice item. The description is displayed in the invoice for easy tracking.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # Controls whether discounts apply to this invoice item. Defaults to false for prorations or negative invoice items, and true for all other invoice items. Cannot be set to true for prorations.
    sig { returns(T.nilable(T::Boolean)) }
    def discountable; end
    sig { params(_discountable: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def discountable=(_discountable); end
    # The coupons, promotion codes & existing discounts which apply to the invoice item or invoice line item. Item discounts are applied before invoice discounts. Pass an empty string to remove previously-defined discounts.
    sig { returns(T.nilable(T.any(String, T::Array[InvoiceItemUpdateParams::Discount]))) }
    def discounts; end
    sig {
      params(_discounts: T.nilable(T.any(String, T::Array[InvoiceItemUpdateParams::Discount]))).returns(T.nilable(T.any(String, T::Array[InvoiceItemUpdateParams::Discount])))
     }
    def discounts=(_discounts); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # The period associated with this invoice item. When set to different values, the period will be rendered on the invoice. If you have [Stripe Revenue Recognition](https://docs.stripe.com/revenue-recognition) enabled, the period will be used to recognize and defer revenue. See the [Revenue Recognition documentation](https://docs.stripe.com/revenue-recognition/methodology/subscriptions-and-invoicing) for details.
    sig { returns(T.nilable(InvoiceItemUpdateParams::Period)) }
    def period; end
    sig {
      params(_period: T.nilable(InvoiceItemUpdateParams::Period)).returns(T.nilable(InvoiceItemUpdateParams::Period))
     }
    def period=(_period); end
    # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline.
    sig { returns(T.nilable(InvoiceItemUpdateParams::PriceData)) }
    def price_data; end
    sig {
      params(_price_data: T.nilable(InvoiceItemUpdateParams::PriceData)).returns(T.nilable(InvoiceItemUpdateParams::PriceData))
     }
    def price_data=(_price_data); end
    # The pricing information for the invoice item.
    sig { returns(T.nilable(InvoiceItemUpdateParams::Pricing)) }
    def pricing; end
    sig {
      params(_pricing: T.nilable(InvoiceItemUpdateParams::Pricing)).returns(T.nilable(InvoiceItemUpdateParams::Pricing))
     }
    def pricing=(_pricing); end
    # Non-negative integer. The quantity of units for the invoice item.
    sig { returns(T.nilable(Integer)) }
    def quantity; end
    sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def quantity=(_quantity); end
    # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
    sig { returns(T.nilable(String)) }
    def tax_behavior; end
    sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def tax_behavior=(_tax_behavior); end
    # A [tax code](https://docs.stripe.com/tax/tax-categories) ID.
    sig { returns(T.nilable(String)) }
    def tax_code; end
    sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
    def tax_code=(_tax_code); end
    # The tax rates which apply to the invoice item. When set, the `default_tax_rates` on the invoice do not apply to this invoice item. Pass an empty string to remove previously-defined tax rates.
    sig { returns(T.nilable(T.any(String, T::Array[String]))) }
    def tax_rates; end
    sig {
      params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
     }
    def tax_rates=(_tax_rates); end
    # The decimal unit amount in cents (or local equivalent) of the charge to be applied to the upcoming invoice. This `unit_amount_decimal` will be multiplied by the quantity to get the full amount. Passing in a negative `unit_amount_decimal` will reduce the `amount_due` on the invoice. Accepts at most 12 decimal places.
    sig { returns(T.nilable(String)) }
    def unit_amount_decimal; end
    sig { params(_unit_amount_decimal: T.nilable(String)).returns(T.nilable(String)) }
    def unit_amount_decimal=(_unit_amount_decimal); end
    sig {
      params(amount: T.nilable(Integer), description: T.nilable(String), discountable: T.nilable(T::Boolean), discounts: T.nilable(T.any(String, T::Array[InvoiceItemUpdateParams::Discount])), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), period: T.nilable(InvoiceItemUpdateParams::Period), price_data: T.nilable(InvoiceItemUpdateParams::PriceData), pricing: T.nilable(InvoiceItemUpdateParams::Pricing), quantity: T.nilable(Integer), tax_behavior: T.nilable(String), tax_code: T.nilable(String), tax_rates: T.nilable(T.any(String, T::Array[String])), unit_amount_decimal: T.nilable(String)).void
     }
    def initialize(
      amount: nil,
      description: nil,
      discountable: nil,
      discounts: nil,
      expand: nil,
      metadata: nil,
      period: nil,
      price_data: nil,
      pricing: nil,
      quantity: nil,
      tax_behavior: nil,
      tax_code: nil,
      tax_rates: nil,
      unit_amount_decimal: nil
    ); end
  end
end