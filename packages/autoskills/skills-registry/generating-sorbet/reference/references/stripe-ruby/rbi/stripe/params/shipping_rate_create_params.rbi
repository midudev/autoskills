# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ShippingRateCreateParams < ::Stripe::RequestParams
    class DeliveryEstimate < ::Stripe::RequestParams
      class Maximum < ::Stripe::RequestParams
        # A unit of time.
        sig { returns(String) }
        def unit; end
        sig { params(_unit: String).returns(String) }
        def unit=(_unit); end
        # Must be greater than 0.
        sig { returns(Integer) }
        def value; end
        sig { params(_value: Integer).returns(Integer) }
        def value=(_value); end
        sig { params(unit: String, value: Integer).void }
        def initialize(unit: nil, value: nil); end
      end
      class Minimum < ::Stripe::RequestParams
        # A unit of time.
        sig { returns(String) }
        def unit; end
        sig { params(_unit: String).returns(String) }
        def unit=(_unit); end
        # Must be greater than 0.
        sig { returns(Integer) }
        def value; end
        sig { params(_value: Integer).returns(Integer) }
        def value=(_value); end
        sig { params(unit: String, value: Integer).void }
        def initialize(unit: nil, value: nil); end
      end
      # The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite.
      sig { returns(T.nilable(ShippingRateCreateParams::DeliveryEstimate::Maximum)) }
      def maximum; end
      sig {
        params(_maximum: T.nilable(ShippingRateCreateParams::DeliveryEstimate::Maximum)).returns(T.nilable(ShippingRateCreateParams::DeliveryEstimate::Maximum))
       }
      def maximum=(_maximum); end
      # The lower bound of the estimated range. If empty, represents no lower bound.
      sig { returns(T.nilable(ShippingRateCreateParams::DeliveryEstimate::Minimum)) }
      def minimum; end
      sig {
        params(_minimum: T.nilable(ShippingRateCreateParams::DeliveryEstimate::Minimum)).returns(T.nilable(ShippingRateCreateParams::DeliveryEstimate::Minimum))
       }
      def minimum=(_minimum); end
      sig {
        params(maximum: T.nilable(ShippingRateCreateParams::DeliveryEstimate::Maximum), minimum: T.nilable(ShippingRateCreateParams::DeliveryEstimate::Minimum)).void
       }
      def initialize(maximum: nil, minimum: nil); end
    end
    class FixedAmount < ::Stripe::RequestParams
      class CurrencyOptions < ::Stripe::RequestParams
        # A non-negative integer in cents representing how much to charge.
        sig { returns(Integer) }
        def amount; end
        sig { params(_amount: Integer).returns(Integer) }
        def amount=(_amount); end
        # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        sig { params(amount: Integer, tax_behavior: T.nilable(String)).void }
        def initialize(amount: nil, tax_behavior: nil); end
      end
      # A non-negative integer in cents representing how much to charge.
      sig { returns(Integer) }
      def amount; end
      sig { params(_amount: Integer).returns(Integer) }
      def amount=(_amount); end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      sig { params(_currency: String).returns(String) }
      def currency=(_currency); end
      # Shipping rates defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
      sig {
        returns(T.nilable(T::Hash[String, ShippingRateCreateParams::FixedAmount::CurrencyOptions]))
       }
      def currency_options; end
      sig {
        params(_currency_options: T.nilable(T::Hash[String, ShippingRateCreateParams::FixedAmount::CurrencyOptions])).returns(T.nilable(T::Hash[String, ShippingRateCreateParams::FixedAmount::CurrencyOptions]))
       }
      def currency_options=(_currency_options); end
      sig {
        params(amount: Integer, currency: String, currency_options: T.nilable(T::Hash[String, ShippingRateCreateParams::FixedAmount::CurrencyOptions])).void
       }
      def initialize(amount: nil, currency: nil, currency_options: nil); end
    end
    # The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
    sig { returns(T.nilable(ShippingRateCreateParams::DeliveryEstimate)) }
    def delivery_estimate; end
    sig {
      params(_delivery_estimate: T.nilable(ShippingRateCreateParams::DeliveryEstimate)).returns(T.nilable(ShippingRateCreateParams::DeliveryEstimate))
     }
    def delivery_estimate=(_delivery_estimate); end
    # The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
    sig { returns(String) }
    def display_name; end
    sig { params(_display_name: String).returns(String) }
    def display_name=(_display_name); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`.
    sig { returns(T.nilable(ShippingRateCreateParams::FixedAmount)) }
    def fixed_amount; end
    sig {
      params(_fixed_amount: T.nilable(ShippingRateCreateParams::FixedAmount)).returns(T.nilable(ShippingRateCreateParams::FixedAmount))
     }
    def fixed_amount=(_fixed_amount); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
    sig { returns(T.nilable(String)) }
    def tax_behavior; end
    sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def tax_behavior=(_tax_behavior); end
    # A [tax code](https://docs.stripe.com/tax/tax-categories) ID. The Shipping tax code is `txcd_92010001`.
    sig { returns(T.nilable(String)) }
    def tax_code; end
    sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
    def tax_code=(_tax_code); end
    # The type of calculation to use on the shipping rate.
    sig { returns(T.nilable(String)) }
    def type; end
    sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
    def type=(_type); end
    sig {
      params(delivery_estimate: T.nilable(ShippingRateCreateParams::DeliveryEstimate), display_name: String, expand: T.nilable(T::Array[String]), fixed_amount: T.nilable(ShippingRateCreateParams::FixedAmount), metadata: T.nilable(T::Hash[String, String]), tax_behavior: T.nilable(String), tax_code: T.nilable(String), type: T.nilable(String)).void
     }
    def initialize(
      delivery_estimate: nil,
      display_name: nil,
      expand: nil,
      fixed_amount: nil,
      metadata: nil,
      tax_behavior: nil,
      tax_code: nil,
      type: nil
    ); end
  end
end