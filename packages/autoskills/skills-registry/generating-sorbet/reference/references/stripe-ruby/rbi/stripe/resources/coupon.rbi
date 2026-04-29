# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A coupon contains information about a percent-off or amount-off discount you
  # might want to apply to a customer. Coupons may be applied to [subscriptions](https://api.stripe.com#subscriptions), [invoices](https://api.stripe.com#invoices),
  # [checkout sessions](https://docs.stripe.com/api/checkout/sessions), [quotes](https://api.stripe.com#quotes), and more. Coupons do not work with conventional one-off [charges](https://api.stripe.com#create_charge) or [payment intents](https://docs.stripe.com/api/payment_intents).
  class Coupon < APIResource
    class AppliesTo < ::Stripe::StripeObject
      # A list of product IDs this coupon applies to
      sig { returns(T::Array[String]) }
      def products; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CurrencyOptions < ::Stripe::StripeObject
      # Amount (in the `currency` specified) that will be taken off the subtotal of any invoices for this customer.
      sig { returns(Integer) }
      def amount_off; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Amount (in the `currency` specified) that will be taken off the subtotal of any invoices for this customer.
    sig { returns(T.nilable(Integer)) }
    def amount_off; end
    # Attribute for field applies_to
    sig { returns(T.nilable(AppliesTo)) }
    def applies_to; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # If `amount_off` has been set, the three-letter [ISO code for the currency](https://stripe.com/docs/currencies) of the amount to take off.
    sig { returns(T.nilable(String)) }
    def currency; end
    # Coupons defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(T::Hash[String, CurrencyOptions])) }
    def currency_options; end
    # One of `forever`, `once`, or `repeating`. Describes how long a customer who applies this coupon will get the discount.
    sig { returns(String) }
    def duration; end
    # If `duration` is `repeating`, the number of months the coupon applies. Null if coupon `duration` is `forever` or `once`.
    sig { returns(T.nilable(Integer)) }
    def duration_in_months; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Maximum number of times this coupon can be redeemed, in total, across all customers, before it is no longer valid.
    sig { returns(T.nilable(Integer)) }
    def max_redemptions; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # Name of the coupon displayed to customers on for instance invoices or receipts.
    sig { returns(T.nilable(String)) }
    def name; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Percent that will be taken off the subtotal of any invoices for this customer for the duration of the coupon. For example, a coupon with percent_off of 50 will make a $ (or local equivalent)100 invoice $ (or local equivalent)50 instead.
    sig { returns(T.nilable(Float)) }
    def percent_off; end
    # Date after which the coupon can no longer be redeemed.
    sig { returns(T.nilable(Integer)) }
    def redeem_by; end
    # Number of times this coupon has been applied to a customer.
    sig { returns(Integer) }
    def times_redeemed; end
    # Taking account of the above properties, whether this coupon can still be applied to a customer.
    sig { returns(T::Boolean) }
    def valid; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # You can create coupons easily via the [coupon management](https://dashboard.stripe.com/coupons) page of the Stripe dashboard. Coupon creation is also accessible via the API if you need to create coupons on the fly.
    #
    # A coupon has either a percent_off or an amount_off and currency. If you set an amount_off, that amount will be subtracted from any invoice's subtotal. For example, an invoice with a subtotal of 100 will have a final total of 0 if a coupon with an amount_off of 200 is applied to it and an invoice with a subtotal of 300 will have a final total of 100 if a coupon with an amount_off of 200 is applied to it.
    sig {
      params(params: T.any(::Stripe::CouponCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Coupon)
     }
    def self.create(params = {}, opts = {}); end

    # You can delete coupons via the [coupon management](https://dashboard.stripe.com/coupons) page of the Stripe dashboard. However, deleting a coupon does not affect any customers who have already applied the coupon; it means that new customers can't redeem the coupon. You can also delete coupons via the API.
    sig {
      params(coupon: String, params: T.any(::Stripe::CouponDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Coupon)
     }
    def self.delete(coupon, params = {}, opts = {}); end

    # You can delete coupons via the [coupon management](https://dashboard.stripe.com/coupons) page of the Stripe dashboard. However, deleting a coupon does not affect any customers who have already applied the coupon; it means that new customers can't redeem the coupon. You can also delete coupons via the API.
    sig {
      params(params: T.any(::Stripe::CouponDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Coupon)
     }
    def delete(params = {}, opts = {}); end

    # Returns a list of your coupons.
    sig {
      params(params: T.any(::Stripe::CouponListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the metadata of a coupon. Other coupon details (currency, duration, amount_off) are, by design, not editable.
    sig {
      params(coupon: String, params: T.any(::Stripe::CouponUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Coupon)
     }
    def self.update(coupon, params = {}, opts = {}); end
  end
end