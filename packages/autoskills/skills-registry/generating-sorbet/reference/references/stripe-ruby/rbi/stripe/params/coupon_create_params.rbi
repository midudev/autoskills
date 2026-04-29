# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CouponCreateParams < ::Stripe::RequestParams
    class AppliesTo < ::Stripe::RequestParams
      # An array of Product IDs that this Coupon will apply to.
      sig { returns(T.nilable(T::Array[String])) }
      def products; end
      sig { params(_products: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def products=(_products); end
      sig { params(products: T.nilable(T::Array[String])).void }
      def initialize(products: nil); end
    end
    class CurrencyOptions < ::Stripe::RequestParams
      # A positive integer representing the amount to subtract from an invoice total.
      sig { returns(Integer) }
      def amount_off; end
      sig { params(_amount_off: Integer).returns(Integer) }
      def amount_off=(_amount_off); end
      sig { params(amount_off: Integer).void }
      def initialize(amount_off: nil); end
    end
    # A positive integer representing the amount to subtract from an invoice total (required if `percent_off` is not passed).
    sig { returns(T.nilable(Integer)) }
    def amount_off; end
    sig { params(_amount_off: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount_off=(_amount_off); end
    # A hash containing directions for what this Coupon will apply discounts to.
    sig { returns(T.nilable(CouponCreateParams::AppliesTo)) }
    def applies_to; end
    sig {
      params(_applies_to: T.nilable(CouponCreateParams::AppliesTo)).returns(T.nilable(CouponCreateParams::AppliesTo))
     }
    def applies_to=(_applies_to); end
    # Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) of the `amount_off` parameter (required if `amount_off` is passed).
    sig { returns(T.nilable(String)) }
    def currency; end
    sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
    def currency=(_currency); end
    # Coupons defined in each available currency option (only supported if `amount_off` is passed). Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(T::Hash[String, CouponCreateParams::CurrencyOptions])) }
    def currency_options; end
    sig {
      params(_currency_options: T.nilable(T::Hash[String, CouponCreateParams::CurrencyOptions])).returns(T.nilable(T::Hash[String, CouponCreateParams::CurrencyOptions]))
     }
    def currency_options=(_currency_options); end
    # Specifies how long the discount will be in effect if used on a subscription. Defaults to `once`.
    sig { returns(T.nilable(String)) }
    def duration; end
    sig { params(_duration: T.nilable(String)).returns(T.nilable(String)) }
    def duration=(_duration); end
    # Required only if `duration` is `repeating`, in which case it must be a positive integer that specifies the number of months the discount will be in effect.
    sig { returns(T.nilable(Integer)) }
    def duration_in_months; end
    sig { params(_duration_in_months: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def duration_in_months=(_duration_in_months); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Unique string of your choice that will be used to identify this coupon when applying it to a customer. If you don't want to specify a particular code, you can leave the ID blank and we'll generate a random code for you.
    sig { returns(T.nilable(String)) }
    def id; end
    sig { params(_id: T.nilable(String)).returns(T.nilable(String)) }
    def id=(_id); end
    # A positive integer specifying the number of times the coupon can be redeemed before it's no longer valid. For example, you might have a 50% off coupon that the first 20 readers of your blog can use.
    sig { returns(T.nilable(Integer)) }
    def max_redemptions; end
    sig { params(_max_redemptions: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def max_redemptions=(_max_redemptions); end
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
    # A positive float larger than 0, and smaller or equal to 100, that represents the discount the coupon will apply (required if `amount_off` is not passed).
    sig { returns(T.nilable(Float)) }
    def percent_off; end
    sig { params(_percent_off: T.nilable(Float)).returns(T.nilable(Float)) }
    def percent_off=(_percent_off); end
    # Unix timestamp specifying the last time at which the coupon can be redeemed. After the redeem_by date, the coupon can no longer be applied to new customers.
    sig { returns(T.nilable(Integer)) }
    def redeem_by; end
    sig { params(_redeem_by: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def redeem_by=(_redeem_by); end
    sig {
      params(amount_off: T.nilable(Integer), applies_to: T.nilable(CouponCreateParams::AppliesTo), currency: T.nilable(String), currency_options: T.nilable(T::Hash[String, CouponCreateParams::CurrencyOptions]), duration: T.nilable(String), duration_in_months: T.nilable(Integer), expand: T.nilable(T::Array[String]), id: T.nilable(String), max_redemptions: T.nilable(Integer), metadata: T.nilable(T.any(String, T::Hash[String, String])), name: T.nilable(String), percent_off: T.nilable(Float), redeem_by: T.nilable(Integer)).void
     }
    def initialize(
      amount_off: nil,
      applies_to: nil,
      currency: nil,
      currency_options: nil,
      duration: nil,
      duration_in_months: nil,
      expand: nil,
      id: nil,
      max_redemptions: nil,
      metadata: nil,
      name: nil,
      percent_off: nil,
      redeem_by: nil
    ); end
  end
end