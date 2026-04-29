# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ShippingRateUpdateParams < ::Stripe::RequestParams
    class FixedAmount < ::Stripe::RequestParams
      class CurrencyOptions < ::Stripe::RequestParams
        # A non-negative integer in cents representing how much to charge.
        sig { returns(T.nilable(Integer)) }
        def amount; end
        sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def amount=(_amount); end
        # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        sig { params(amount: T.nilable(Integer), tax_behavior: T.nilable(String)).void }
        def initialize(amount: nil, tax_behavior: nil); end
      end
      # Shipping rates defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
      sig {
        returns(T.nilable(T::Hash[String, ShippingRateUpdateParams::FixedAmount::CurrencyOptions]))
       }
      def currency_options; end
      sig {
        params(_currency_options: T.nilable(T::Hash[String, ShippingRateUpdateParams::FixedAmount::CurrencyOptions])).returns(T.nilable(T::Hash[String, ShippingRateUpdateParams::FixedAmount::CurrencyOptions]))
       }
      def currency_options=(_currency_options); end
      sig {
        params(currency_options: T.nilable(T::Hash[String, ShippingRateUpdateParams::FixedAmount::CurrencyOptions])).void
       }
      def initialize(currency_options: nil); end
    end
    # Whether the shipping rate can be used for new purchases. Defaults to `true`.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`.
    sig { returns(T.nilable(ShippingRateUpdateParams::FixedAmount)) }
    def fixed_amount; end
    sig {
      params(_fixed_amount: T.nilable(ShippingRateUpdateParams::FixedAmount)).returns(T.nilable(ShippingRateUpdateParams::FixedAmount))
     }
    def fixed_amount=(_fixed_amount); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
    sig { returns(T.nilable(String)) }
    def tax_behavior; end
    sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def tax_behavior=(_tax_behavior); end
    sig {
      params(active: T.nilable(T::Boolean), expand: T.nilable(T::Array[String]), fixed_amount: T.nilable(ShippingRateUpdateParams::FixedAmount), metadata: T.nilable(T.any(String, T::Hash[String, String])), tax_behavior: T.nilable(String)).void
     }
    def initialize(
      active: nil,
      expand: nil,
      fixed_amount: nil,
      metadata: nil,
      tax_behavior: nil
    ); end
  end
end