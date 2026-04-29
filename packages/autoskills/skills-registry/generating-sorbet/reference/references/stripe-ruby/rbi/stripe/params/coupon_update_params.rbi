# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CouponUpdateParams < ::Stripe::RequestParams
    class CurrencyOptions < ::Stripe::RequestParams
      # A positive integer representing the amount to subtract from an invoice total.
      sig { returns(Integer) }
      def amount_off; end
      sig { params(_amount_off: Integer).returns(Integer) }
      def amount_off=(_amount_off); end
      sig { params(amount_off: Integer).void }
      def initialize(amount_off: nil); end
    end
    # Coupons defined in each available currency option (only supported if the coupon is amount-based). Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(T::Hash[String, CouponUpdateParams::CurrencyOptions])) }
    def currency_options; end
    sig {
      params(_currency_options: T.nilable(T::Hash[String, CouponUpdateParams::CurrencyOptions])).returns(T.nilable(T::Hash[String, CouponUpdateParams::CurrencyOptions]))
     }
    def currency_options=(_currency_options); end
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
    # Name of the coupon displayed to customers on, for instance invoices, or receipts. By default the `id` is shown if `name` is not set.
    sig { returns(T.nilable(String)) }
    def name; end
    sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
    def name=(_name); end
    sig {
      params(currency_options: T.nilable(T::Hash[String, CouponUpdateParams::CurrencyOptions]), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), name: T.nilable(String)).void
     }
    def initialize(currency_options: nil, expand: nil, metadata: nil, name: nil); end
  end
end