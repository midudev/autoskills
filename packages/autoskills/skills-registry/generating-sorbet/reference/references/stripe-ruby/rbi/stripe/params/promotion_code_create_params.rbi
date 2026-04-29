# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PromotionCodeCreateParams < ::Stripe::RequestParams
    class Promotion < ::Stripe::RequestParams
      # If promotion `type` is `coupon`, the coupon for this promotion code.
      sig { returns(T.nilable(String)) }
      def coupon; end
      sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
      def coupon=(_coupon); end
      # Specifies the type of promotion.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig { params(coupon: T.nilable(String), type: String).void }
      def initialize(coupon: nil, type: nil); end
    end
    class Restrictions < ::Stripe::RequestParams
      class CurrencyOptions < ::Stripe::RequestParams
        # Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
        sig { returns(T.nilable(Integer)) }
        def minimum_amount; end
        sig { params(_minimum_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def minimum_amount=(_minimum_amount); end
        sig { params(minimum_amount: T.nilable(Integer)).void }
        def initialize(minimum_amount: nil); end
      end
      # Promotion codes defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
      sig {
        returns(T.nilable(T::Hash[String, PromotionCodeCreateParams::Restrictions::CurrencyOptions]))
       }
      def currency_options; end
      sig {
        params(_currency_options: T.nilable(T::Hash[String, PromotionCodeCreateParams::Restrictions::CurrencyOptions])).returns(T.nilable(T::Hash[String, PromotionCodeCreateParams::Restrictions::CurrencyOptions]))
       }
      def currency_options=(_currency_options); end
      # A Boolean indicating if the Promotion Code should only be redeemed for Customers without any successful payments or invoices
      sig { returns(T.nilable(T::Boolean)) }
      def first_time_transaction; end
      sig { params(_first_time_transaction: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def first_time_transaction=(_first_time_transaction); end
      # Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
      sig { returns(T.nilable(Integer)) }
      def minimum_amount; end
      sig { params(_minimum_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def minimum_amount=(_minimum_amount); end
      # Three-letter [ISO code](https://stripe.com/docs/currencies) for minimum_amount
      sig { returns(T.nilable(String)) }
      def minimum_amount_currency; end
      sig { params(_minimum_amount_currency: T.nilable(String)).returns(T.nilable(String)) }
      def minimum_amount_currency=(_minimum_amount_currency); end
      sig {
        params(currency_options: T.nilable(T::Hash[String, PromotionCodeCreateParams::Restrictions::CurrencyOptions]), first_time_transaction: T.nilable(T::Boolean), minimum_amount: T.nilable(Integer), minimum_amount_currency: T.nilable(String)).void
       }
      def initialize(
        currency_options: nil,
        first_time_transaction: nil,
        minimum_amount: nil,
        minimum_amount_currency: nil
      ); end
    end
    # Whether the promotion code is currently active.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # The customer-facing code. Regardless of case, this code must be unique across all active promotion codes for a specific customer. Valid characters are lower case letters (a-z), upper case letters (A-Z), and digits (0-9).
    #
    # If left blank, we will generate one automatically.
    sig { returns(T.nilable(String)) }
    def code; end
    sig { params(_code: T.nilable(String)).returns(T.nilable(String)) }
    def code=(_code); end
    # The customer who can use this promotion code. If not set, all customers can use the promotion code.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # The account representing the customer who can use this promotion code. If not set, all customers can use the promotion code.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
    def customer_account=(_customer_account); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # The timestamp at which this promotion code will expire. If the coupon has specified a `redeems_by`, then this value cannot be after the coupon's `redeems_by`.
    sig { returns(T.nilable(Integer)) }
    def expires_at; end
    sig { params(_expires_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def expires_at=(_expires_at); end
    # A positive integer specifying the number of times the promotion code can be redeemed. If the coupon has specified a `max_redemptions`, then this value cannot be greater than the coupon's `max_redemptions`.
    sig { returns(T.nilable(Integer)) }
    def max_redemptions; end
    sig { params(_max_redemptions: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def max_redemptions=(_max_redemptions); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    # The promotion referenced by this promotion code.
    sig { returns(PromotionCodeCreateParams::Promotion) }
    def promotion; end
    sig {
      params(_promotion: PromotionCodeCreateParams::Promotion).returns(PromotionCodeCreateParams::Promotion)
     }
    def promotion=(_promotion); end
    # Settings that restrict the redemption of the promotion code.
    sig { returns(T.nilable(PromotionCodeCreateParams::Restrictions)) }
    def restrictions; end
    sig {
      params(_restrictions: T.nilable(PromotionCodeCreateParams::Restrictions)).returns(T.nilable(PromotionCodeCreateParams::Restrictions))
     }
    def restrictions=(_restrictions); end
    sig {
      params(active: T.nilable(T::Boolean), code: T.nilable(String), customer: T.nilable(String), customer_account: T.nilable(String), expand: T.nilable(T::Array[String]), expires_at: T.nilable(Integer), max_redemptions: T.nilable(Integer), metadata: T.nilable(T::Hash[String, String]), promotion: PromotionCodeCreateParams::Promotion, restrictions: T.nilable(PromotionCodeCreateParams::Restrictions)).void
     }
    def initialize(
      active: nil,
      code: nil,
      customer: nil,
      customer_account: nil,
      expand: nil,
      expires_at: nil,
      max_redemptions: nil,
      metadata: nil,
      promotion: nil,
      restrictions: nil
    ); end
  end
end