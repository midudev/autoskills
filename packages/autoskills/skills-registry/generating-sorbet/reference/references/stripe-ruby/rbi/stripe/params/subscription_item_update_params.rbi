# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionItemUpdateParams < ::Stripe::RequestParams
    class BillingThresholds < ::Stripe::RequestParams
      # Number of units that meets the billing threshold to advance the subscription to a new billing period (e.g., it takes 10 $5 units to meet a $50 [monetary threshold](https://docs.stripe.com/api/subscriptions/update#update_subscription-billing_thresholds-amount_gte))
      sig { returns(Integer) }
      def usage_gte; end
      sig { params(_usage_gte: Integer).returns(Integer) }
      def usage_gte=(_usage_gte); end
      sig { params(usage_gte: Integer).void }
      def initialize(usage_gte: nil); end
    end
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
    class PriceData < ::Stripe::RequestParams
      class Recurring < ::Stripe::RequestParams
        # Specifies billing frequency. Either `day`, `week`, `month` or `year`.
        sig { returns(String) }
        def interval; end
        sig { params(_interval: String).returns(String) }
        def interval=(_interval); end
        # The number of intervals between subscription billings. For example, `interval=month` and `interval_count=3` bills every 3 months. Maximum of three years interval allowed (3 years, 36 months, or 156 weeks).
        sig { returns(T.nilable(Integer)) }
        def interval_count; end
        sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def interval_count=(_interval_count); end
        sig { params(interval: String, interval_count: T.nilable(Integer)).void }
        def initialize(interval: nil, interval_count: nil); end
      end
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
      # The recurring components of a price such as `interval` and `interval_count`.
      sig { returns(SubscriptionItemUpdateParams::PriceData::Recurring) }
      def recurring; end
      sig {
        params(_recurring: SubscriptionItemUpdateParams::PriceData::Recurring).returns(SubscriptionItemUpdateParams::PriceData::Recurring)
       }
      def recurring=(_recurring); end
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
        params(currency: String, product: String, recurring: SubscriptionItemUpdateParams::PriceData::Recurring, tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
       }
      def initialize(
        currency: nil,
        product: nil,
        recurring: nil,
        tax_behavior: nil,
        unit_amount: nil,
        unit_amount_decimal: nil
      ); end
    end
    # Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. Pass an empty string to remove previously-defined thresholds.
    sig { returns(T.nilable(T.any(String, SubscriptionItemUpdateParams::BillingThresholds))) }
    def billing_thresholds; end
    sig {
      params(_billing_thresholds: T.nilable(T.any(String, SubscriptionItemUpdateParams::BillingThresholds))).returns(T.nilable(T.any(String, SubscriptionItemUpdateParams::BillingThresholds)))
     }
    def billing_thresholds=(_billing_thresholds); end
    # The coupons to redeem into discounts for the subscription item.
    sig { returns(T.nilable(T.any(String, T::Array[SubscriptionItemUpdateParams::Discount]))) }
    def discounts; end
    sig {
      params(_discounts: T.nilable(T.any(String, T::Array[SubscriptionItemUpdateParams::Discount]))).returns(T.nilable(T.any(String, T::Array[SubscriptionItemUpdateParams::Discount])))
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
    # Indicates if a customer is on or off-session while an invoice payment is attempted. Defaults to `false` (on-session).
    sig { returns(T.nilable(T::Boolean)) }
    def off_session; end
    sig { params(_off_session: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def off_session=(_off_session); end
    # Use `allow_incomplete` to transition the subscription to `status=past_due` if a payment is required but cannot be paid. This allows you to manage scenarios where additional user actions are needed to pay a subscription's invoice. For example, SCA regulation may require 3DS authentication to complete payment. See the [SCA Migration Guide](https://docs.stripe.com/billing/migration/strong-customer-authentication) for Billing to learn more. This is the default behavior.
    #
    # Use `default_incomplete` to transition the subscription to `status=past_due` when payment is required and await explicit confirmation of the invoice's payment intent. This allows simpler management of scenarios where additional user actions are needed to pay a subscription’s invoice. Such as failed payments, [SCA regulation](https://docs.stripe.com/billing/migration/strong-customer-authentication), or collecting a mandate for a bank debit payment method.
    #
    # Use `pending_if_incomplete` to update the subscription using [pending updates](https://docs.stripe.com/billing/subscriptions/pending-updates). When you use `pending_if_incomplete` you can only pass the parameters [supported by pending updates](https://docs.stripe.com/billing/pending-updates-reference#supported-attributes).
    #
    # Use `error_if_incomplete` if you want Stripe to return an HTTP 402 status code if a subscription's invoice cannot be paid. For example, if a payment method requires 3DS authentication due to SCA regulation and further user action is needed, this parameter does not update the subscription and returns an error instead. This was the default behavior for API versions prior to 2019-03-14. See the [changelog](https://docs.stripe.com/changelog/2019-03-14) to learn more.
    sig { returns(T.nilable(String)) }
    def payment_behavior; end
    sig { params(_payment_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def payment_behavior=(_payment_behavior); end
    # The identifier of the new plan for this subscription item.
    sig { returns(T.nilable(String)) }
    def plan; end
    sig { params(_plan: T.nilable(String)).returns(T.nilable(String)) }
    def plan=(_plan); end
    # The ID of the price object. One of `price` or `price_data` is required. When changing a subscription item's price, `quantity` is set to 1 unless a `quantity` parameter is provided.
    sig { returns(T.nilable(String)) }
    def price; end
    sig { params(_price: T.nilable(String)).returns(T.nilable(String)) }
    def price=(_price); end
    # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline. One of `price` or `price_data` is required.
    sig { returns(T.nilable(SubscriptionItemUpdateParams::PriceData)) }
    def price_data; end
    sig {
      params(_price_data: T.nilable(SubscriptionItemUpdateParams::PriceData)).returns(T.nilable(SubscriptionItemUpdateParams::PriceData))
     }
    def price_data=(_price_data); end
    # Determines how to handle [prorations](https://docs.stripe.com/billing/subscriptions/prorations) when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item's `quantity` changes. The default value is `create_prorations`.
    sig { returns(T.nilable(String)) }
    def proration_behavior; end
    sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def proration_behavior=(_proration_behavior); end
    # If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the [upcoming invoice](https://api.stripe.com#retrieve_customer_invoice) endpoint.
    sig { returns(T.nilable(Integer)) }
    def proration_date; end
    sig { params(_proration_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def proration_date=(_proration_date); end
    # The quantity you'd like to apply to the subscription item you're creating.
    sig { returns(T.nilable(Integer)) }
    def quantity; end
    sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def quantity=(_quantity); end
    # A list of [Tax Rate](https://docs.stripe.com/api/tax_rates) ids. These Tax Rates will override the [`default_tax_rates`](https://docs.stripe.com/api/subscriptions/create#create_subscription-default_tax_rates) on the Subscription. When updating, pass an empty string to remove previously-defined tax rates.
    sig { returns(T.nilable(T.any(String, T::Array[String]))) }
    def tax_rates; end
    sig {
      params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
     }
    def tax_rates=(_tax_rates); end
    sig {
      params(billing_thresholds: T.nilable(T.any(String, SubscriptionItemUpdateParams::BillingThresholds)), discounts: T.nilable(T.any(String, T::Array[SubscriptionItemUpdateParams::Discount])), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), off_session: T.nilable(T::Boolean), payment_behavior: T.nilable(String), plan: T.nilable(String), price: T.nilable(String), price_data: T.nilable(SubscriptionItemUpdateParams::PriceData), proration_behavior: T.nilable(String), proration_date: T.nilable(Integer), quantity: T.nilable(Integer), tax_rates: T.nilable(T.any(String, T::Array[String]))).void
     }
    def initialize(
      billing_thresholds: nil,
      discounts: nil,
      expand: nil,
      metadata: nil,
      off_session: nil,
      payment_behavior: nil,
      plan: nil,
      price: nil,
      price_data: nil,
      proration_behavior: nil,
      proration_date: nil,
      quantity: nil,
      tax_rates: nil
    ); end
  end
end