# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A Promotion Code represents a customer-redeemable code for an underlying promotion.
  # You can create multiple codes for a single promotion.
  #
  # If you enable promotion codes in your [customer portal configuration](https://docs.stripe.com/customer-management/configure-portal), then customers can redeem a code themselves when updating a subscription in the portal.
  # Customers can also view the currently active promotion codes and coupons on each of their subscriptions in the portal.
  class PromotionCode < APIResource
    class Promotion < ::Stripe::StripeObject
      # If promotion `type` is `coupon`, the coupon for this promotion.
      sig { returns(T.nilable(T.any(String, ::Stripe::Coupon))) }
      def coupon; end
      # The type of promotion.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Restrictions < ::Stripe::StripeObject
      class CurrencyOptions < ::Stripe::StripeObject
        # Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
        sig { returns(Integer) }
        def minimum_amount; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Promotion code restrictions defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(T.nilable(T::Hash[String, CurrencyOptions])) }
      def currency_options; end
      # A Boolean indicating if the Promotion Code should only be redeemed for Customers without any successful payments or invoices
      sig { returns(T::Boolean) }
      def first_time_transaction; end
      # Minimum amount required to redeem this Promotion Code into a Coupon (e.g., a purchase must be $100 or more to work).
      sig { returns(T.nilable(Integer)) }
      def minimum_amount; end
      # Three-letter [ISO code](https://stripe.com/docs/currencies) for minimum_amount
      sig { returns(T.nilable(String)) }
      def minimum_amount_currency; end
      def self.inner_class_types
        @inner_class_types = {currency_options: CurrencyOptions}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Whether the promotion code is currently active. A promotion code is only active if the coupon is also valid.
    sig { returns(T::Boolean) }
    def active; end
    # The customer-facing code. Regardless of case, this code must be unique across all active promotion codes for each customer. Valid characters are lower case letters (a-z), upper case letters (A-Z), and digits (0-9).
    sig { returns(String) }
    def code; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # The customer who can use this promotion code.
    sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
    def customer; end
    # The account representing the customer who can use this promotion code.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # Date at which the promotion code can no longer be redeemed.
    sig { returns(T.nilable(Integer)) }
    def expires_at; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Maximum number of times this promotion code can be redeemed.
    sig { returns(T.nilable(Integer)) }
    def max_redemptions; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Attribute for field promotion
    sig { returns(Promotion) }
    def promotion; end
    # Attribute for field restrictions
    sig { returns(Restrictions) }
    def restrictions; end
    # Number of times this promotion code has been used.
    sig { returns(Integer) }
    def times_redeemed; end
    # A promotion code points to an underlying promotion. You can optionally restrict the code to a specific customer, redemption limit, and expiration date.
    sig {
      params(params: T.any(::Stripe::PromotionCodeCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PromotionCode)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of your promotion codes.
    sig {
      params(params: T.any(::Stripe::PromotionCodeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the specified promotion code by setting the values of the parameters passed. Most fields are, by design, not editable.
    sig {
      params(promotion_code: String, params: T.any(::Stripe::PromotionCodeUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PromotionCode)
     }
    def self.update(promotion_code, params = {}, opts = {}); end
  end
end