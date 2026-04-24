# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceLineItemUpdateParams < ::Stripe::RequestParams
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
      class ProductData < ::Stripe::RequestParams
        # The product's description, meant to be displayable to the customer. Use this field to optionally store a long form explanation of the product being sold for your own rendering purposes.
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # A list of up to 8 URLs of images for this product, meant to be displayable to the customer.
        sig { returns(T.nilable(T::Array[String])) }
        def images; end
        sig { params(_images: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def images=(_images); end
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
          params(description: T.nilable(String), images: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), name: String, tax_code: T.nilable(String), unit_label: T.nilable(String)).void
         }
        def initialize(
          description: nil,
          images: nil,
          metadata: nil,
          name: nil,
          tax_code: nil,
          unit_label: nil
        ); end
      end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      sig { params(_currency: String).returns(String) }
      def currency=(_currency); end
      # The ID of the [Product](https://docs.stripe.com/api/products) that this [Price](https://docs.stripe.com/api/prices) will belong to. One of `product` or `product_data` is required.
      sig { returns(T.nilable(String)) }
      def product; end
      sig { params(_product: T.nilable(String)).returns(T.nilable(String)) }
      def product=(_product); end
      # Data used to generate a new [Product](https://docs.stripe.com/api/products) object inline. One of `product` or `product_data` is required.
      sig { returns(T.nilable(InvoiceLineItemUpdateParams::PriceData::ProductData)) }
      def product_data; end
      sig {
        params(_product_data: T.nilable(InvoiceLineItemUpdateParams::PriceData::ProductData)).returns(T.nilable(InvoiceLineItemUpdateParams::PriceData::ProductData))
       }
      def product_data=(_product_data); end
      # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
      sig { returns(T.nilable(String)) }
      def tax_behavior; end
      sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def tax_behavior=(_tax_behavior); end
      # A non-negative integer in cents (or local equivalent) representing how much to charge. One of `unit_amount` or `unit_amount_decimal` is required.
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
        params(currency: String, product: T.nilable(String), product_data: T.nilable(InvoiceLineItemUpdateParams::PriceData::ProductData), tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
       }
      def initialize(
        currency: nil,
        product: nil,
        product_data: nil,
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
    class TaxAmount < ::Stripe::RequestParams
      class TaxRateData < ::Stripe::RequestParams
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
        def country=(_country); end
        # An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.
        sig { returns(T.nilable(String)) }
        def description; end
        sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
        def description=(_description); end
        # The display name of the tax rate, which will be shown to users.
        sig { returns(String) }
        def display_name; end
        sig { params(_display_name: String).returns(String) }
        def display_name=(_display_name); end
        # This specifies if the tax rate is inclusive or exclusive.
        sig { returns(T::Boolean) }
        def inclusive; end
        sig { params(_inclusive: T::Boolean).returns(T::Boolean) }
        def inclusive=(_inclusive); end
        # The jurisdiction for the tax rate. You can use this label field for tax reporting purposes. It also appears on your customer’s invoice.
        sig { returns(T.nilable(String)) }
        def jurisdiction; end
        sig { params(_jurisdiction: T.nilable(String)).returns(T.nilable(String)) }
        def jurisdiction=(_jurisdiction); end
        # The level of the jurisdiction that imposes this tax rate.
        sig { returns(T.nilable(String)) }
        def jurisdiction_level; end
        sig { params(_jurisdiction_level: T.nilable(String)).returns(T.nilable(String)) }
        def jurisdiction_level=(_jurisdiction_level); end
        # The statutory tax rate percent. This field accepts decimal values between 0 and 100 inclusive with at most 4 decimal places. To accommodate fixed-amount taxes, set the percentage to zero. Stripe will not display zero percentages on the invoice unless the `amount` of the tax is also zero.
        sig { returns(Float) }
        def percentage; end
        sig { params(_percentage: Float).returns(Float) }
        def percentage=(_percentage); end
        # [ISO 3166-2 subdivision code](https://en.wikipedia.org/wiki/ISO_3166-2:US), without country prefix. For example, "NY" for New York, United States.
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        # The high-level tax type, such as `vat` or `sales_tax`.
        sig { returns(T.nilable(String)) }
        def tax_type; end
        sig { params(_tax_type: T.nilable(String)).returns(T.nilable(String)) }
        def tax_type=(_tax_type); end
        sig {
          params(country: T.nilable(String), description: T.nilable(String), display_name: String, inclusive: T::Boolean, jurisdiction: T.nilable(String), jurisdiction_level: T.nilable(String), percentage: Float, state: T.nilable(String), tax_type: T.nilable(String)).void
         }
        def initialize(
          country: nil,
          description: nil,
          display_name: nil,
          inclusive: nil,
          jurisdiction: nil,
          jurisdiction_level: nil,
          percentage: nil,
          state: nil,
          tax_type: nil
        ); end
      end
      # The amount, in cents (or local equivalent), of the tax.
      sig { returns(Integer) }
      def amount; end
      sig { params(_amount: Integer).returns(Integer) }
      def amount=(_amount); end
      # Data to find or create a TaxRate object.
      #
      # Stripe automatically creates or reuses a TaxRate object for each tax amount. If the `tax_rate_data` exactly matches a previous value, Stripe will reuse the TaxRate object. TaxRate objects created automatically by Stripe are immediately archived, do not appear in the line item’s `tax_rates`, and cannot be directly added to invoices, payments, or line items.
      sig { returns(InvoiceLineItemUpdateParams::TaxAmount::TaxRateData) }
      def tax_rate_data; end
      sig {
        params(_tax_rate_data: InvoiceLineItemUpdateParams::TaxAmount::TaxRateData).returns(InvoiceLineItemUpdateParams::TaxAmount::TaxRateData)
       }
      def tax_rate_data=(_tax_rate_data); end
      # The reasoning behind this tax, for example, if the product is tax exempt.
      sig { returns(T.nilable(String)) }
      def taxability_reason; end
      sig { params(_taxability_reason: T.nilable(String)).returns(T.nilable(String)) }
      def taxability_reason=(_taxability_reason); end
      # The amount on which tax is calculated, in cents (or local equivalent).
      sig { returns(Integer) }
      def taxable_amount; end
      sig { params(_taxable_amount: Integer).returns(Integer) }
      def taxable_amount=(_taxable_amount); end
      sig {
        params(amount: Integer, tax_rate_data: InvoiceLineItemUpdateParams::TaxAmount::TaxRateData, taxability_reason: T.nilable(String), taxable_amount: Integer).void
       }
      def initialize(
        amount: nil,
        tax_rate_data: nil,
        taxability_reason: nil,
        taxable_amount: nil
      ); end
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
    # Controls whether discounts apply to this line item. Defaults to false for prorations or negative line items, and true for all other line items. Cannot be set to true for prorations.
    sig { returns(T.nilable(T::Boolean)) }
    def discountable; end
    sig { params(_discountable: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def discountable=(_discountable); end
    # The coupons, promotion codes & existing discounts which apply to the line item. Item discounts are applied before invoice discounts. Pass an empty string to remove previously-defined discounts.
    sig { returns(T.nilable(T.any(String, T::Array[InvoiceLineItemUpdateParams::Discount]))) }
    def discounts; end
    sig {
      params(_discounts: T.nilable(T.any(String, T::Array[InvoiceLineItemUpdateParams::Discount]))).returns(T.nilable(T.any(String, T::Array[InvoiceLineItemUpdateParams::Discount])))
     }
    def discounts=(_discounts); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`. For [type=subscription](https://docs.stripe.com/api/invoices/line_item#invoice_line_item_object-type) line items, the incoming metadata specified on the request is directly used to set this value, in contrast to [type=invoiceitem](api/invoices/line_item#invoice_line_item_object-type) line items, where any existing metadata on the invoice line is merged with the incoming data.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # The period associated with this invoice item. When set to different values, the period will be rendered on the invoice. If you have [Stripe Revenue Recognition](https://docs.stripe.com/revenue-recognition) enabled, the period will be used to recognize and defer revenue. See the [Revenue Recognition documentation](https://docs.stripe.com/revenue-recognition/methodology/subscriptions-and-invoicing) for details.
    sig { returns(T.nilable(InvoiceLineItemUpdateParams::Period)) }
    def period; end
    sig {
      params(_period: T.nilable(InvoiceLineItemUpdateParams::Period)).returns(T.nilable(InvoiceLineItemUpdateParams::Period))
     }
    def period=(_period); end
    # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline.
    sig { returns(T.nilable(InvoiceLineItemUpdateParams::PriceData)) }
    def price_data; end
    sig {
      params(_price_data: T.nilable(InvoiceLineItemUpdateParams::PriceData)).returns(T.nilable(InvoiceLineItemUpdateParams::PriceData))
     }
    def price_data=(_price_data); end
    # The pricing information for the invoice item.
    sig { returns(T.nilable(InvoiceLineItemUpdateParams::Pricing)) }
    def pricing; end
    sig {
      params(_pricing: T.nilable(InvoiceLineItemUpdateParams::Pricing)).returns(T.nilable(InvoiceLineItemUpdateParams::Pricing))
     }
    def pricing=(_pricing); end
    # Non-negative integer. The quantity of units for the line item.
    sig { returns(T.nilable(Integer)) }
    def quantity; end
    sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def quantity=(_quantity); end
    # A list of up to 10 tax amounts for this line item. This can be useful if you calculate taxes on your own or use a third-party to calculate them. You cannot set tax amounts if any line item has [tax_rates](https://docs.stripe.com/api/invoices/line_item#invoice_line_item_object-tax_rates) or if the invoice has [default_tax_rates](https://docs.stripe.com/api/invoices/object#invoice_object-default_tax_rates) or uses [automatic tax](https://docs.stripe.com/tax/invoicing). Pass an empty string to remove previously defined tax amounts.
    sig { returns(T.nilable(T.any(String, T::Array[InvoiceLineItemUpdateParams::TaxAmount]))) }
    def tax_amounts; end
    sig {
      params(_tax_amounts: T.nilable(T.any(String, T::Array[InvoiceLineItemUpdateParams::TaxAmount]))).returns(T.nilable(T.any(String, T::Array[InvoiceLineItemUpdateParams::TaxAmount])))
     }
    def tax_amounts=(_tax_amounts); end
    # The tax rates which apply to the line item. When set, the `default_tax_rates` on the invoice do not apply to this line item. Pass an empty string to remove previously-defined tax rates.
    sig { returns(T.nilable(T.any(String, T::Array[String]))) }
    def tax_rates; end
    sig {
      params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
     }
    def tax_rates=(_tax_rates); end
    sig {
      params(amount: T.nilable(Integer), description: T.nilable(String), discountable: T.nilable(T::Boolean), discounts: T.nilable(T.any(String, T::Array[InvoiceLineItemUpdateParams::Discount])), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), period: T.nilable(InvoiceLineItemUpdateParams::Period), price_data: T.nilable(InvoiceLineItemUpdateParams::PriceData), pricing: T.nilable(InvoiceLineItemUpdateParams::Pricing), quantity: T.nilable(Integer), tax_amounts: T.nilable(T.any(String, T::Array[InvoiceLineItemUpdateParams::TaxAmount])), tax_rates: T.nilable(T.any(String, T::Array[String]))).void
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
      tax_amounts: nil,
      tax_rates: nil
    ); end
  end
end