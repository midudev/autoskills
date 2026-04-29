# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PriceUpdateParams < ::Stripe::RequestParams
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
      sig { returns(T.nilable(PriceUpdateParams::CurrencyOptions::CustomUnitAmount)) }
      def custom_unit_amount; end
      sig {
        params(_custom_unit_amount: T.nilable(PriceUpdateParams::CurrencyOptions::CustomUnitAmount)).returns(T.nilable(PriceUpdateParams::CurrencyOptions::CustomUnitAmount))
       }
      def custom_unit_amount=(_custom_unit_amount); end
      # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
      sig { returns(T.nilable(String)) }
      def tax_behavior; end
      sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
      def tax_behavior=(_tax_behavior); end
      # Each element represents a pricing tier. This parameter requires `billing_scheme` to be set to `tiered`. See also the documentation for `billing_scheme`.
      sig { returns(T.nilable(T::Array[PriceUpdateParams::CurrencyOptions::Tier])) }
      def tiers; end
      sig {
        params(_tiers: T.nilable(T::Array[PriceUpdateParams::CurrencyOptions::Tier])).returns(T.nilable(T::Array[PriceUpdateParams::CurrencyOptions::Tier]))
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
        params(custom_unit_amount: T.nilable(PriceUpdateParams::CurrencyOptions::CustomUnitAmount), tax_behavior: T.nilable(String), tiers: T.nilable(T::Array[PriceUpdateParams::CurrencyOptions::Tier]), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
       }
      def initialize(
        custom_unit_amount: nil,
        tax_behavior: nil,
        tiers: nil,
        unit_amount: nil,
        unit_amount_decimal: nil
      ); end
    end
    # Whether the price can be used for new purchases. Defaults to `true`.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # Prices defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(T.any(String, T::Hash[String, PriceUpdateParams::CurrencyOptions]))) }
    def currency_options; end
    sig {
      params(_currency_options: T.nilable(T.any(String, T::Hash[String, PriceUpdateParams::CurrencyOptions]))).returns(T.nilable(T.any(String, T::Hash[String, PriceUpdateParams::CurrencyOptions])))
     }
    def currency_options=(_currency_options); end
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
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # A brief description of the price, hidden from customers.
    sig { returns(T.nilable(String)) }
    def nickname; end
    sig { params(_nickname: T.nilable(String)).returns(T.nilable(String)) }
    def nickname=(_nickname); end
    # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
    sig { returns(T.nilable(String)) }
    def tax_behavior; end
    sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def tax_behavior=(_tax_behavior); end
    # If set to true, will atomically remove the lookup key from the existing price, and assign it to this price.
    sig { returns(T.nilable(T::Boolean)) }
    def transfer_lookup_key; end
    sig { params(_transfer_lookup_key: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def transfer_lookup_key=(_transfer_lookup_key); end
    sig {
      params(active: T.nilable(T::Boolean), currency_options: T.nilable(T.any(String, T::Hash[String, PriceUpdateParams::CurrencyOptions])), expand: T.nilable(T::Array[String]), lookup_key: T.nilable(String), metadata: T.nilable(T.any(String, T::Hash[String, String])), nickname: T.nilable(String), tax_behavior: T.nilable(String), transfer_lookup_key: T.nilable(T::Boolean)).void
     }
    def initialize(
      active: nil,
      currency_options: nil,
      expand: nil,
      lookup_key: nil,
      metadata: nil,
      nickname: nil,
      tax_behavior: nil,
      transfer_lookup_key: nil
    ); end
  end
end