# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionUpdateParams < ::Stripe::RequestParams
    class AddInvoiceItem < ::Stripe::RequestParams
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
        class End < ::Stripe::RequestParams
          # A precise Unix timestamp for the end of the invoice item period. Must be greater than or equal to `period.start`.
          sig { returns(T.nilable(Integer)) }
          def timestamp; end
          sig { params(_timestamp: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def timestamp=(_timestamp); end
          # Select how to calculate the end of the invoice item period.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(timestamp: T.nilable(Integer), type: String).void }
          def initialize(timestamp: nil, type: nil); end
        end
        class Start < ::Stripe::RequestParams
          # A precise Unix timestamp for the start of the invoice item period. Must be less than or equal to `period.end`.
          sig { returns(T.nilable(Integer)) }
          def timestamp; end
          sig { params(_timestamp: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def timestamp=(_timestamp); end
          # Select how to calculate the start of the invoice item period.
          sig { returns(String) }
          def type; end
          sig { params(_type: String).returns(String) }
          def type=(_type); end
          sig { params(timestamp: T.nilable(Integer), type: String).void }
          def initialize(timestamp: nil, type: nil); end
        end
        # End of the invoice item period.
        sig { returns(SubscriptionUpdateParams::AddInvoiceItem::Period::End) }
        def end; end
        sig {
          params(_end: SubscriptionUpdateParams::AddInvoiceItem::Period::End).returns(SubscriptionUpdateParams::AddInvoiceItem::Period::End)
         }
        def end=(_end); end
        # Start of the invoice item period.
        sig { returns(SubscriptionUpdateParams::AddInvoiceItem::Period::Start) }
        def start; end
        sig {
          params(_start: SubscriptionUpdateParams::AddInvoiceItem::Period::Start).returns(SubscriptionUpdateParams::AddInvoiceItem::Period::Start)
         }
        def start=(_start); end
        sig {
          params(end_: SubscriptionUpdateParams::AddInvoiceItem::Period::End, start: SubscriptionUpdateParams::AddInvoiceItem::Period::Start).void
         }
        def initialize(end_: nil, start: nil); end
      end
      class PriceData < ::Stripe::RequestParams
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
        # Only required if a [default tax behavior](https://docs.stripe.com/tax/products-prices-tax-categories-tax-behavior#setting-a-default-tax-behavior-(recommended)) was not provided in the Stripe Tax settings. Specifies whether the price is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`. Once specified as either `inclusive` or `exclusive`, it cannot be changed.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        # A positive integer in cents (or local equivalent) (or 0 for a free price) representing how much to charge or a negative integer representing the amount to credit to the customer.
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
          params(currency: String, product: String, tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
         }
        def initialize(
          currency: nil,
          product: nil,
          tax_behavior: nil,
          unit_amount: nil,
          unit_amount_decimal: nil
        ); end
      end
      # The coupons to redeem into discounts for the item.
      sig { returns(T.nilable(T::Array[SubscriptionUpdateParams::AddInvoiceItem::Discount])) }
      def discounts; end
      sig {
        params(_discounts: T.nilable(T::Array[SubscriptionUpdateParams::AddInvoiceItem::Discount])).returns(T.nilable(T::Array[SubscriptionUpdateParams::AddInvoiceItem::Discount]))
       }
      def discounts=(_discounts); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The period associated with this invoice item. If not set, `period.start.type` defaults to `max_item_period_start` and `period.end.type` defaults to `min_item_period_end`.
      sig { returns(T.nilable(SubscriptionUpdateParams::AddInvoiceItem::Period)) }
      def period; end
      sig {
        params(_period: T.nilable(SubscriptionUpdateParams::AddInvoiceItem::Period)).returns(T.nilable(SubscriptionUpdateParams::AddInvoiceItem::Period))
       }
      def period=(_period); end
      # The ID of the price object. One of `price` or `price_data` is required.
      sig { returns(T.nilable(String)) }
      def price; end
      sig { params(_price: T.nilable(String)).returns(T.nilable(String)) }
      def price=(_price); end
      # Data used to generate a new [Price](https://docs.stripe.com/api/prices) object inline. One of `price` or `price_data` is required.
      sig { returns(T.nilable(SubscriptionUpdateParams::AddInvoiceItem::PriceData)) }
      def price_data; end
      sig {
        params(_price_data: T.nilable(SubscriptionUpdateParams::AddInvoiceItem::PriceData)).returns(T.nilable(SubscriptionUpdateParams::AddInvoiceItem::PriceData))
       }
      def price_data=(_price_data); end
      # Quantity for this item. Defaults to 1.
      sig { returns(T.nilable(Integer)) }
      def quantity; end
      sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def quantity=(_quantity); end
      # The tax rates which apply to the item. When set, the `default_tax_rates` do not apply to this item.
      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def tax_rates; end
      sig {
        params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
       }
      def tax_rates=(_tax_rates); end
      sig {
        params(discounts: T.nilable(T::Array[SubscriptionUpdateParams::AddInvoiceItem::Discount]), metadata: T.nilable(T::Hash[String, String]), period: T.nilable(SubscriptionUpdateParams::AddInvoiceItem::Period), price: T.nilable(String), price_data: T.nilable(SubscriptionUpdateParams::AddInvoiceItem::PriceData), quantity: T.nilable(Integer), tax_rates: T.nilable(T.any(String, T::Array[String]))).void
       }
      def initialize(
        discounts: nil,
        metadata: nil,
        period: nil,
        price: nil,
        price_data: nil,
        quantity: nil,
        tax_rates: nil
      ); end
    end
    class AutomaticTax < ::Stripe::RequestParams
      class Liability < ::Stripe::RequestParams
        # The connected account being referenced when `type` is `account`.
        sig { returns(T.nilable(String)) }
        def account; end
        sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
        def account=(_account); end
        # Type of the account referenced in the request.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig { params(account: T.nilable(String), type: String).void }
        def initialize(account: nil, type: nil); end
      end
      # Enabled automatic tax calculation which will automatically compute tax rates on all invoices generated by the subscription.
      sig { returns(T::Boolean) }
      def enabled; end
      sig { params(_enabled: T::Boolean).returns(T::Boolean) }
      def enabled=(_enabled); end
      # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
      sig { returns(T.nilable(SubscriptionUpdateParams::AutomaticTax::Liability)) }
      def liability; end
      sig {
        params(_liability: T.nilable(SubscriptionUpdateParams::AutomaticTax::Liability)).returns(T.nilable(SubscriptionUpdateParams::AutomaticTax::Liability))
       }
      def liability=(_liability); end
      sig {
        params(enabled: T::Boolean, liability: T.nilable(SubscriptionUpdateParams::AutomaticTax::Liability)).void
       }
      def initialize(enabled: nil, liability: nil); end
    end
    class BillingThresholds < ::Stripe::RequestParams
      # Monetary threshold that triggers the subscription to advance to a new billing period
      sig { returns(T.nilable(Integer)) }
      def amount_gte; end
      sig { params(_amount_gte: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount_gte=(_amount_gte); end
      # Indicates if the `billing_cycle_anchor` should be reset when a threshold is reached. If true, `billing_cycle_anchor` will be updated to the date/time the threshold was last reached; otherwise, the value will remain unchanged.
      sig { returns(T.nilable(T::Boolean)) }
      def reset_billing_cycle_anchor; end
      sig {
        params(_reset_billing_cycle_anchor: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
       }
      def reset_billing_cycle_anchor=(_reset_billing_cycle_anchor); end
      sig {
        params(amount_gte: T.nilable(Integer), reset_billing_cycle_anchor: T.nilable(T::Boolean)).void
       }
      def initialize(amount_gte: nil, reset_billing_cycle_anchor: nil); end
    end
    class CancellationDetails < ::Stripe::RequestParams
      # Additional comments about why the user canceled the subscription, if the subscription was canceled explicitly by the user.
      sig { returns(T.nilable(String)) }
      def comment; end
      sig { params(_comment: T.nilable(String)).returns(T.nilable(String)) }
      def comment=(_comment); end
      # The customer submitted reason for why they canceled, if the subscription was canceled explicitly by the user.
      sig { returns(T.nilable(T.any(String, String))) }
      def feedback; end
      sig {
        params(_feedback: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
       }
      def feedback=(_feedback); end
      sig { params(comment: T.nilable(String), feedback: T.nilable(T.any(String, String))).void }
      def initialize(comment: nil, feedback: nil); end
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
    class InvoiceSettings < ::Stripe::RequestParams
      class Issuer < ::Stripe::RequestParams
        # The connected account being referenced when `type` is `account`.
        sig { returns(T.nilable(String)) }
        def account; end
        sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
        def account=(_account); end
        # Type of the account referenced in the request.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig { params(account: T.nilable(String), type: String).void }
        def initialize(account: nil, type: nil); end
      end
      # The account tax IDs associated with the subscription. Will be set on invoices generated by the subscription.
      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def account_tax_ids; end
      sig {
        params(_account_tax_ids: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
       }
      def account_tax_ids=(_account_tax_ids); end
      # The connected account that issues the invoice. The invoice is presented with the branding and support information of the specified account.
      sig { returns(T.nilable(SubscriptionUpdateParams::InvoiceSettings::Issuer)) }
      def issuer; end
      sig {
        params(_issuer: T.nilable(SubscriptionUpdateParams::InvoiceSettings::Issuer)).returns(T.nilable(SubscriptionUpdateParams::InvoiceSettings::Issuer))
       }
      def issuer=(_issuer); end
      sig {
        params(account_tax_ids: T.nilable(T.any(String, T::Array[String])), issuer: T.nilable(SubscriptionUpdateParams::InvoiceSettings::Issuer)).void
       }
      def initialize(account_tax_ids: nil, issuer: nil); end
    end
    class Item < ::Stripe::RequestParams
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
        sig { returns(SubscriptionUpdateParams::Item::PriceData::Recurring) }
        def recurring; end
        sig {
          params(_recurring: SubscriptionUpdateParams::Item::PriceData::Recurring).returns(SubscriptionUpdateParams::Item::PriceData::Recurring)
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
          params(currency: String, product: String, recurring: SubscriptionUpdateParams::Item::PriceData::Recurring, tax_behavior: T.nilable(String), unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
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
      sig { returns(T.nilable(T.any(String, SubscriptionUpdateParams::Item::BillingThresholds))) }
      def billing_thresholds; end
      sig {
        params(_billing_thresholds: T.nilable(T.any(String, SubscriptionUpdateParams::Item::BillingThresholds))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::Item::BillingThresholds)))
       }
      def billing_thresholds=(_billing_thresholds); end
      # Delete all usage for a given subscription item. You must pass this when deleting a usage records subscription item. `clear_usage` has no effect if the plan has a billing meter attached.
      sig { returns(T.nilable(T::Boolean)) }
      def clear_usage; end
      sig { params(_clear_usage: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def clear_usage=(_clear_usage); end
      # A flag that, if set to `true`, will delete the specified item.
      sig { returns(T.nilable(T::Boolean)) }
      def deleted; end
      sig { params(_deleted: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def deleted=(_deleted); end
      # The coupons to redeem into discounts for the subscription item.
      sig { returns(T.nilable(T.any(String, T::Array[SubscriptionUpdateParams::Item::Discount]))) }
      def discounts; end
      sig {
        params(_discounts: T.nilable(T.any(String, T::Array[SubscriptionUpdateParams::Item::Discount]))).returns(T.nilable(T.any(String, T::Array[SubscriptionUpdateParams::Item::Discount])))
       }
      def discounts=(_discounts); end
      # Subscription item to update.
      sig { returns(T.nilable(String)) }
      def id; end
      sig { params(_id: T.nilable(String)).returns(T.nilable(String)) }
      def id=(_id); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
       }
      def metadata=(_metadata); end
      # Plan ID for this item, as a string.
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
      sig { returns(T.nilable(SubscriptionUpdateParams::Item::PriceData)) }
      def price_data; end
      sig {
        params(_price_data: T.nilable(SubscriptionUpdateParams::Item::PriceData)).returns(T.nilable(SubscriptionUpdateParams::Item::PriceData))
       }
      def price_data=(_price_data); end
      # Quantity for this item.
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
        params(billing_thresholds: T.nilable(T.any(String, SubscriptionUpdateParams::Item::BillingThresholds)), clear_usage: T.nilable(T::Boolean), deleted: T.nilable(T::Boolean), discounts: T.nilable(T.any(String, T::Array[SubscriptionUpdateParams::Item::Discount])), id: T.nilable(String), metadata: T.nilable(T.any(String, T::Hash[String, String])), plan: T.nilable(String), price: T.nilable(String), price_data: T.nilable(SubscriptionUpdateParams::Item::PriceData), quantity: T.nilable(Integer), tax_rates: T.nilable(T.any(String, T::Array[String]))).void
       }
      def initialize(
        billing_thresholds: nil,
        clear_usage: nil,
        deleted: nil,
        discounts: nil,
        id: nil,
        metadata: nil,
        plan: nil,
        price: nil,
        price_data: nil,
        quantity: nil,
        tax_rates: nil
      ); end
    end
    class PauseCollection < ::Stripe::RequestParams
      # The payment collection behavior for this subscription while paused. One of `keep_as_draft`, `mark_uncollectible`, or `void`.
      sig { returns(String) }
      def behavior; end
      sig { params(_behavior: String).returns(String) }
      def behavior=(_behavior); end
      # The time after which the subscription will resume collecting payments.
      sig { returns(T.nilable(Integer)) }
      def resumes_at; end
      sig { params(_resumes_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def resumes_at=(_resumes_at); end
      sig { params(behavior: String, resumes_at: T.nilable(Integer)).void }
      def initialize(behavior: nil, resumes_at: nil); end
    end
    class PaymentSettings < ::Stripe::RequestParams
      class PaymentMethodOptions < ::Stripe::RequestParams
        class AcssDebit < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # Transaction type of the mandate.
            sig { returns(T.nilable(String)) }
            def transaction_type; end
            sig { params(_transaction_type: T.nilable(String)).returns(T.nilable(String)) }
            def transaction_type=(_transaction_type); end
            sig { params(transaction_type: T.nilable(String)).void }
            def initialize(transaction_type: nil); end
          end
          # Additional fields for Mandate creation
          sig {
            returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::AcssDebit::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::AcssDebit::MandateOptions)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::AcssDebit::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          # Verification method for the intent
          sig { returns(T.nilable(String)) }
          def verification_method; end
          sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
          def verification_method=(_verification_method); end
          sig {
            params(mandate_options: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::AcssDebit::MandateOptions), verification_method: T.nilable(String)).void
           }
          def initialize(mandate_options: nil, verification_method: nil); end
        end
        class Bancontact < ::Stripe::RequestParams
          # Preferred language of the Bancontact authorization page that the customer is redirected to.
          sig { returns(T.nilable(String)) }
          def preferred_language; end
          sig { params(_preferred_language: T.nilable(String)).returns(T.nilable(String)) }
          def preferred_language=(_preferred_language); end
          sig { params(preferred_language: T.nilable(String)).void }
          def initialize(preferred_language: nil); end
        end
        class Card < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # Amount to be charged for future payments.
            sig { returns(T.nilable(Integer)) }
            def amount; end
            sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def amount=(_amount); end
            # One of `fixed` or `maximum`. If `fixed`, the `amount` param refers to the exact amount to be charged in future payments. If `maximum`, the amount charged can be up to the value passed for the `amount` param.
            sig { returns(T.nilable(String)) }
            def amount_type; end
            sig { params(_amount_type: T.nilable(String)).returns(T.nilable(String)) }
            def amount_type=(_amount_type); end
            # A description of the mandate or subscription that is meant to be displayed to the customer.
            sig { returns(T.nilable(String)) }
            def description; end
            sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
            def description=(_description); end
            sig {
              params(amount: T.nilable(Integer), amount_type: T.nilable(String), description: T.nilable(String)).void
             }
            def initialize(amount: nil, amount_type: nil, description: nil); end
          end
          # Configuration options for setting up an eMandate for cards issued in India.
          sig {
            returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Card::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Card::MandateOptions)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Card::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          # Selected network to process this Subscription on. Depends on the available networks of the card attached to the Subscription. Can be only set confirm-time.
          sig { returns(T.nilable(String)) }
          def network; end
          sig { params(_network: T.nilable(String)).returns(T.nilable(String)) }
          def network=(_network); end
          # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
          sig { returns(T.nilable(String)) }
          def request_three_d_secure; end
          sig { params(_request_three_d_secure: T.nilable(String)).returns(T.nilable(String)) }
          def request_three_d_secure=(_request_three_d_secure); end
          sig {
            params(mandate_options: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Card::MandateOptions), network: T.nilable(String), request_three_d_secure: T.nilable(String)).void
           }
          def initialize(mandate_options: nil, network: nil, request_three_d_secure: nil); end
        end
        class CustomerBalance < ::Stripe::RequestParams
          class BankTransfer < ::Stripe::RequestParams
            class EuBankTransfer < ::Stripe::RequestParams
              # The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
              sig { returns(String) }
              def country; end
              sig { params(_country: String).returns(String) }
              def country=(_country); end
              sig { params(country: String).void }
              def initialize(country: nil); end
            end
            # Configuration for eu_bank_transfer funding type.
            sig {
              returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer))
             }
            def eu_bank_transfer; end
            sig {
              params(_eu_bank_transfer: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer))
             }
            def eu_bank_transfer=(_eu_bank_transfer); end
            # The bank transfer type that can be used for funding. Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, `mx_bank_transfer`, or `us_bank_transfer`.
            sig { returns(T.nilable(String)) }
            def type; end
            sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
            def type=(_type); end
            sig {
              params(eu_bank_transfer: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer), type: T.nilable(String)).void
             }
            def initialize(eu_bank_transfer: nil, type: nil); end
          end
          # Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
          sig {
            returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer))
           }
          def bank_transfer; end
          sig {
            params(_bank_transfer: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer))
           }
          def bank_transfer=(_bank_transfer); end
          # The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`.
          sig { returns(T.nilable(String)) }
          def funding_type; end
          sig { params(_funding_type: T.nilable(String)).returns(T.nilable(String)) }
          def funding_type=(_funding_type); end
          sig {
            params(bank_transfer: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer), funding_type: T.nilable(String)).void
           }
          def initialize(bank_transfer: nil, funding_type: nil); end
        end
        class Konbini < ::Stripe::RequestParams; end
        class Payto < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # The maximum amount that can be collected in a single invoice. If you don't specify a maximum, then there is no limit.
            sig { returns(T.nilable(Integer)) }
            def amount; end
            sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def amount=(_amount); end
            # The purpose for which payments are made. Has a default value based on your merchant category code.
            sig { returns(T.nilable(String)) }
            def purpose; end
            sig { params(_purpose: T.nilable(String)).returns(T.nilable(String)) }
            def purpose=(_purpose); end
            sig { params(amount: T.nilable(Integer), purpose: T.nilable(String)).void }
            def initialize(amount: nil, purpose: nil); end
          end
          # Additional fields for Mandate creation.
          sig {
            returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Payto::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Payto::MandateOptions)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Payto::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          sig {
            params(mandate_options: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Payto::MandateOptions)).void
           }
          def initialize(mandate_options: nil); end
        end
        class SepaDebit < ::Stripe::RequestParams; end
        class UsBankAccount < ::Stripe::RequestParams
          class FinancialConnections < ::Stripe::RequestParams
            class Filters < ::Stripe::RequestParams
              # The account subcategories to use to filter for selectable accounts. Valid subcategories are `checking` and `savings`.
              sig { returns(T.nilable(T::Array[String])) }
              def account_subcategories; end
              sig {
                params(_account_subcategories: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
               }
              def account_subcategories=(_account_subcategories); end
              sig { params(account_subcategories: T.nilable(T::Array[String])).void }
              def initialize(account_subcategories: nil); end
            end
            # Provide filters for the linked accounts that the customer can select for the payment method.
            sig {
              returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters))
             }
            def filters; end
            sig {
              params(_filters: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters))
             }
            def filters=(_filters); end
            # The list of permissions to request. If this parameter is passed, the `payment_method` permission must be included. Valid permissions include: `balances`, `ownership`, `payment_method`, and `transactions`.
            sig { returns(T.nilable(T::Array[String])) }
            def permissions; end
            sig {
              params(_permissions: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def permissions=(_permissions); end
            # List of data features that you would like to retrieve upon account creation.
            sig { returns(T.nilable(T::Array[String])) }
            def prefetch; end
            sig {
              params(_prefetch: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def prefetch=(_prefetch); end
            sig {
              params(filters: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters), permissions: T.nilable(T::Array[String]), prefetch: T.nilable(T::Array[String])).void
             }
            def initialize(filters: nil, permissions: nil, prefetch: nil); end
          end
          # Additional fields for Financial Connections Session creation
          sig {
            returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections))
           }
          def financial_connections; end
          sig {
            params(_financial_connections: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections))
           }
          def financial_connections=(_financial_connections); end
          # Verification method for the intent
          sig { returns(T.nilable(String)) }
          def verification_method; end
          sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
          def verification_method=(_verification_method); end
          sig {
            params(financial_connections: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections), verification_method: T.nilable(String)).void
           }
          def initialize(financial_connections: nil, verification_method: nil); end
        end
        # This sub-hash contains details about the Canadian pre-authorized debit payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::AcssDebit)))
         }
        def acss_debit; end
        sig {
          params(_acss_debit: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::AcssDebit))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::AcssDebit)))
         }
        def acss_debit=(_acss_debit); end
        # This sub-hash contains details about the Bancontact payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Bancontact)))
         }
        def bancontact; end
        sig {
          params(_bancontact: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Bancontact))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Bancontact)))
         }
        def bancontact=(_bancontact); end
        # This sub-hash contains details about the Card payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Card)))
         }
        def card; end
        sig {
          params(_card: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Card))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Card)))
         }
        def card=(_card); end
        # This sub-hash contains details about the Bank transfer payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance)))
         }
        def customer_balance; end
        sig {
          params(_customer_balance: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance)))
         }
        def customer_balance=(_customer_balance); end
        # This sub-hash contains details about the Konbini payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Konbini)))
         }
        def konbini; end
        sig {
          params(_konbini: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Konbini))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Konbini)))
         }
        def konbini=(_konbini); end
        # This sub-hash contains details about the PayTo payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Payto)))
         }
        def payto; end
        sig {
          params(_payto: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Payto))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Payto)))
         }
        def payto=(_payto); end
        # This sub-hash contains details about the SEPA Direct Debit payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::SepaDebit)))
         }
        def sepa_debit; end
        sig {
          params(_sepa_debit: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::SepaDebit))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::SepaDebit)))
         }
        def sepa_debit=(_sepa_debit); end
        # This sub-hash contains details about the ACH direct debit payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount)))
         }
        def us_bank_account; end
        sig {
          params(_us_bank_account: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount)))
         }
        def us_bank_account=(_us_bank_account); end
        sig {
          params(acss_debit: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::AcssDebit)), bancontact: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Bancontact)), card: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Card)), customer_balance: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance)), konbini: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Konbini)), payto: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::Payto)), sepa_debit: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::SepaDebit)), us_bank_account: T.nilable(T.any(String, SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount))).void
         }
        def initialize(
          acss_debit: nil,
          bancontact: nil,
          card: nil,
          customer_balance: nil,
          konbini: nil,
          payto: nil,
          sepa_debit: nil,
          us_bank_account: nil
        ); end
      end
      # Payment-method-specific configuration to provide to invoices created by the subscription.
      sig { returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions)) }
      def payment_method_options; end
      sig {
        params(_payment_method_options: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions))
       }
      def payment_method_options=(_payment_method_options); end
      # The list of payment method types (e.g. card) to provide to the invoice’s PaymentIntent. If not set, Stripe attempts to automatically determine the types to use by looking at the invoice’s default payment method, the subscription’s default payment method, the customer’s default payment method, and your [invoice template settings](https://dashboard.stripe.com/settings/billing/invoice). Should not be specified with payment_method_configuration
      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def payment_method_types; end
      sig {
        params(_payment_method_types: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
       }
      def payment_method_types=(_payment_method_types); end
      # Configure whether Stripe updates `subscription.default_payment_method` when payment succeeds. Defaults to `off` if unspecified.
      sig { returns(T.nilable(String)) }
      def save_default_payment_method; end
      sig { params(_save_default_payment_method: T.nilable(String)).returns(T.nilable(String)) }
      def save_default_payment_method=(_save_default_payment_method); end
      sig {
        params(payment_method_options: T.nilable(SubscriptionUpdateParams::PaymentSettings::PaymentMethodOptions), payment_method_types: T.nilable(T.any(String, T::Array[String])), save_default_payment_method: T.nilable(String)).void
       }
      def initialize(
        payment_method_options: nil,
        payment_method_types: nil,
        save_default_payment_method: nil
      ); end
    end
    class PendingInvoiceItemInterval < ::Stripe::RequestParams
      # Specifies invoicing frequency. Either `day`, `week`, `month` or `year`.
      sig { returns(String) }
      def interval; end
      sig { params(_interval: String).returns(String) }
      def interval=(_interval); end
      # The number of intervals between invoices. For example, `interval=month` and `interval_count=3` bills every 3 months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks).
      sig { returns(T.nilable(Integer)) }
      def interval_count; end
      sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def interval_count=(_interval_count); end
      sig { params(interval: String, interval_count: T.nilable(Integer)).void }
      def initialize(interval: nil, interval_count: nil); end
    end
    class TransferData < ::Stripe::RequestParams
      # A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the destination account. By default, the entire amount is transferred to the destination.
      sig { returns(T.nilable(Float)) }
      def amount_percent; end
      sig { params(_amount_percent: T.nilable(Float)).returns(T.nilable(Float)) }
      def amount_percent=(_amount_percent); end
      # ID of an existing, connected Stripe account.
      sig { returns(String) }
      def destination; end
      sig { params(_destination: String).returns(String) }
      def destination=(_destination); end
      sig { params(amount_percent: T.nilable(Float), destination: String).void }
      def initialize(amount_percent: nil, destination: nil); end
    end
    class TrialSettings < ::Stripe::RequestParams
      class EndBehavior < ::Stripe::RequestParams
        # Indicates how the subscription should change when the trial ends if the user did not provide a payment method.
        sig { returns(String) }
        def missing_payment_method; end
        sig { params(_missing_payment_method: String).returns(String) }
        def missing_payment_method=(_missing_payment_method); end
        sig { params(missing_payment_method: String).void }
        def initialize(missing_payment_method: nil); end
      end
      # Defines how the subscription should behave when the user's free trial ends.
      sig { returns(SubscriptionUpdateParams::TrialSettings::EndBehavior) }
      def end_behavior; end
      sig {
        params(_end_behavior: SubscriptionUpdateParams::TrialSettings::EndBehavior).returns(SubscriptionUpdateParams::TrialSettings::EndBehavior)
       }
      def end_behavior=(_end_behavior); end
      sig { params(end_behavior: SubscriptionUpdateParams::TrialSettings::EndBehavior).void }
      def initialize(end_behavior: nil); end
    end
    # A list of prices and quantities that will generate invoice items appended to the next invoice for this subscription. You may pass up to 20 items.
    sig { returns(T.nilable(T::Array[SubscriptionUpdateParams::AddInvoiceItem])) }
    def add_invoice_items; end
    sig {
      params(_add_invoice_items: T.nilable(T::Array[SubscriptionUpdateParams::AddInvoiceItem])).returns(T.nilable(T::Array[SubscriptionUpdateParams::AddInvoiceItem]))
     }
    def add_invoice_items=(_add_invoice_items); end
    # A non-negative decimal between 0 and 100, with at most two decimal places. This represents the percentage of the subscription invoice total that will be transferred to the application owner's Stripe account. The request must be made by a platform account on a connected account in order to set an application fee percentage. For more information, see the application fees [documentation](https://stripe.com/docs/connect/subscriptions#collecting-fees-on-subscriptions).
    sig { returns(T.nilable(T.any(String, Float))) }
    def application_fee_percent; end
    sig {
      params(_application_fee_percent: T.nilable(T.any(String, Float))).returns(T.nilable(T.any(String, Float)))
     }
    def application_fee_percent=(_application_fee_percent); end
    # Automatic tax settings for this subscription. We recommend you only include this parameter when the existing value is being changed.
    sig { returns(T.nilable(SubscriptionUpdateParams::AutomaticTax)) }
    def automatic_tax; end
    sig {
      params(_automatic_tax: T.nilable(SubscriptionUpdateParams::AutomaticTax)).returns(T.nilable(SubscriptionUpdateParams::AutomaticTax))
     }
    def automatic_tax=(_automatic_tax); end
    # Either `now` or `unchanged`. Setting the value to `now` resets the subscription's billing cycle anchor to the current time (in UTC). For more information, see the billing cycle [documentation](https://docs.stripe.com/billing/subscriptions/billing-cycle).
    sig { returns(T.nilable(String)) }
    def billing_cycle_anchor; end
    sig { params(_billing_cycle_anchor: T.nilable(String)).returns(T.nilable(String)) }
    def billing_cycle_anchor=(_billing_cycle_anchor); end
    # Define thresholds at which an invoice will be sent, and the subscription advanced to a new billing period. When updating, pass an empty string to remove previously-defined thresholds.
    sig { returns(T.nilable(T.any(String, SubscriptionUpdateParams::BillingThresholds))) }
    def billing_thresholds; end
    sig {
      params(_billing_thresholds: T.nilable(T.any(String, SubscriptionUpdateParams::BillingThresholds))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::BillingThresholds)))
     }
    def billing_thresholds=(_billing_thresholds); end
    # A timestamp at which the subscription should cancel. If set to a date before the current period ends, this will cause a proration if prorations have been enabled using `proration_behavior`. If set during a future period, this will always cause a proration for that period.
    sig { returns(T.nilable(T.any(String, T.any(Integer, String)))) }
    def cancel_at; end
    sig {
      params(_cancel_at: T.nilable(T.any(String, T.any(Integer, String)))).returns(T.nilable(T.any(String, T.any(Integer, String))))
     }
    def cancel_at=(_cancel_at); end
    # Indicate whether this subscription should cancel at the end of the current period (`current_period_end`). Defaults to `false`.
    sig { returns(T.nilable(T::Boolean)) }
    def cancel_at_period_end; end
    sig { params(_cancel_at_period_end: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def cancel_at_period_end=(_cancel_at_period_end); end
    # Details about why this subscription was cancelled
    sig { returns(T.nilable(SubscriptionUpdateParams::CancellationDetails)) }
    def cancellation_details; end
    sig {
      params(_cancellation_details: T.nilable(SubscriptionUpdateParams::CancellationDetails)).returns(T.nilable(SubscriptionUpdateParams::CancellationDetails))
     }
    def cancellation_details=(_cancellation_details); end
    # Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this subscription at the end of the cycle using the default source attached to the customer. When sending an invoice, Stripe will email your customer an invoice with payment instructions and mark the subscription as `active`. Defaults to `charge_automatically`.
    sig { returns(T.nilable(String)) }
    def collection_method; end
    sig { params(_collection_method: T.nilable(String)).returns(T.nilable(String)) }
    def collection_method=(_collection_method); end
    # Number of days a customer has to pay invoices generated by this subscription. Valid only for subscriptions where `collection_method` is set to `send_invoice`.
    sig { returns(T.nilable(Integer)) }
    def days_until_due; end
    sig { params(_days_until_due: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def days_until_due=(_days_until_due); end
    # ID of the default payment method for the subscription. It must belong to the customer associated with the subscription. This takes precedence over `default_source`. If neither are set, invoices will use the customer's [invoice_settings.default_payment_method](https://docs.stripe.com/api/customers/object#customer_object-invoice_settings-default_payment_method) or [default_source](https://docs.stripe.com/api/customers/object#customer_object-default_source).
    sig { returns(T.nilable(String)) }
    def default_payment_method; end
    sig { params(_default_payment_method: T.nilable(String)).returns(T.nilable(String)) }
    def default_payment_method=(_default_payment_method); end
    # ID of the default payment source for the subscription. It must belong to the customer associated with the subscription and be in a chargeable state. If `default_payment_method` is also set, `default_payment_method` will take precedence. If neither are set, invoices will use the customer's [invoice_settings.default_payment_method](https://docs.stripe.com/api/customers/object#customer_object-invoice_settings-default_payment_method) or [default_source](https://docs.stripe.com/api/customers/object#customer_object-default_source).
    sig { returns(T.nilable(String)) }
    def default_source; end
    sig { params(_default_source: T.nilable(String)).returns(T.nilable(String)) }
    def default_source=(_default_source); end
    # The tax rates that will apply to any subscription item that does not have `tax_rates` set. Invoices created will have their `default_tax_rates` populated from the subscription. Pass an empty string to remove previously-defined tax rates.
    sig { returns(T.nilable(T.any(String, T::Array[String]))) }
    def default_tax_rates; end
    sig {
      params(_default_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
     }
    def default_tax_rates=(_default_tax_rates); end
    # The subscription's description, meant to be displayable to the customer. Use this field to optionally store an explanation of the subscription for rendering in Stripe surfaces and certain local payment methods UIs.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # The coupons to redeem into discounts for the subscription. If not specified or empty, inherits the discount from the subscription's customer.
    sig { returns(T.nilable(T.any(String, T::Array[SubscriptionUpdateParams::Discount]))) }
    def discounts; end
    sig {
      params(_discounts: T.nilable(T.any(String, T::Array[SubscriptionUpdateParams::Discount]))).returns(T.nilable(T.any(String, T::Array[SubscriptionUpdateParams::Discount])))
     }
    def discounts=(_discounts); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # All invoices will be billed using the specified settings.
    sig { returns(T.nilable(SubscriptionUpdateParams::InvoiceSettings)) }
    def invoice_settings; end
    sig {
      params(_invoice_settings: T.nilable(SubscriptionUpdateParams::InvoiceSettings)).returns(T.nilable(SubscriptionUpdateParams::InvoiceSettings))
     }
    def invoice_settings=(_invoice_settings); end
    # A list of up to 20 subscription items, each with an attached price.
    sig { returns(T.nilable(T::Array[SubscriptionUpdateParams::Item])) }
    def items; end
    sig {
      params(_items: T.nilable(T::Array[SubscriptionUpdateParams::Item])).returns(T.nilable(T::Array[SubscriptionUpdateParams::Item]))
     }
    def items=(_items); end
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
    # The account on behalf of which to charge, for each of the subscription's invoices.
    sig { returns(T.nilable(String)) }
    def on_behalf_of; end
    sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
    def on_behalf_of=(_on_behalf_of); end
    # If specified, payment collection for this subscription will be paused. Note that the subscription status will be unchanged and will not be updated to `paused`. Learn more about [pausing collection](https://docs.stripe.com/billing/subscriptions/pause-payment).
    sig { returns(T.nilable(T.any(String, SubscriptionUpdateParams::PauseCollection))) }
    def pause_collection; end
    sig {
      params(_pause_collection: T.nilable(T.any(String, SubscriptionUpdateParams::PauseCollection))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PauseCollection)))
     }
    def pause_collection=(_pause_collection); end
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
    # Payment settings to pass to invoices created by the subscription.
    sig { returns(T.nilable(SubscriptionUpdateParams::PaymentSettings)) }
    def payment_settings; end
    sig {
      params(_payment_settings: T.nilable(SubscriptionUpdateParams::PaymentSettings)).returns(T.nilable(SubscriptionUpdateParams::PaymentSettings))
     }
    def payment_settings=(_payment_settings); end
    # Specifies an interval for how often to bill for any pending invoice items. It is analogous to calling [Create an invoice](https://docs.stripe.com/api#create_invoice) for the given subscription at the specified interval.
    sig { returns(T.nilable(T.any(String, SubscriptionUpdateParams::PendingInvoiceItemInterval))) }
    def pending_invoice_item_interval; end
    sig {
      params(_pending_invoice_item_interval: T.nilable(T.any(String, SubscriptionUpdateParams::PendingInvoiceItemInterval))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::PendingInvoiceItemInterval)))
     }
    def pending_invoice_item_interval=(_pending_invoice_item_interval); end
    # Determines how to handle [prorations](https://docs.stripe.com/billing/subscriptions/prorations) when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item's `quantity` changes. The default value is `create_prorations`.
    sig { returns(T.nilable(String)) }
    def proration_behavior; end
    sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def proration_behavior=(_proration_behavior); end
    # If set, prorations will be calculated as though the subscription was updated at the given time. This can be used to apply exactly the same prorations that were previewed with the [create preview](https://stripe.com/docs/api/invoices/create_preview) endpoint. `proration_date` can also be used to implement custom proration logic, such as prorating by day instead of by second, by providing the time that you wish to use for proration calculations.
    sig { returns(T.nilable(Integer)) }
    def proration_date; end
    sig { params(_proration_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def proration_date=(_proration_date); end
    # If specified, the funds from the subscription's invoices will be transferred to the destination and the ID of the resulting transfers will be found on the resulting charges. This will be unset if you POST an empty value.
    sig { returns(T.nilable(T.any(String, SubscriptionUpdateParams::TransferData))) }
    def transfer_data; end
    sig {
      params(_transfer_data: T.nilable(T.any(String, SubscriptionUpdateParams::TransferData))).returns(T.nilable(T.any(String, SubscriptionUpdateParams::TransferData)))
     }
    def transfer_data=(_transfer_data); end
    # Unix timestamp representing the end of the trial period the customer will get before being charged for the first time. This will always overwrite any trials that might apply via a subscribed plan. If set, `trial_end` will override the default trial period of the plan the customer is being subscribed to. The `billing_cycle_anchor` will be updated to the `trial_end` value. The special value `now` can be provided to end the customer's trial immediately. Can be at most two years from `billing_cycle_anchor`.
    sig { returns(T.nilable(T.any(String, Integer))) }
    def trial_end; end
    sig {
      params(_trial_end: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
     }
    def trial_end=(_trial_end); end
    # Indicates if a plan's `trial_period_days` should be applied to the subscription. Setting `trial_end` per subscription is preferred, and this defaults to `false`. Setting this flag to `true` together with `trial_end` is not allowed. See [Using trial periods on subscriptions](https://docs.stripe.com/billing/subscriptions/trials) to learn more.
    sig { returns(T.nilable(T::Boolean)) }
    def trial_from_plan; end
    sig { params(_trial_from_plan: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def trial_from_plan=(_trial_from_plan); end
    # Settings related to subscription trials.
    sig { returns(T.nilable(SubscriptionUpdateParams::TrialSettings)) }
    def trial_settings; end
    sig {
      params(_trial_settings: T.nilable(SubscriptionUpdateParams::TrialSettings)).returns(T.nilable(SubscriptionUpdateParams::TrialSettings))
     }
    def trial_settings=(_trial_settings); end
    sig {
      params(add_invoice_items: T.nilable(T::Array[SubscriptionUpdateParams::AddInvoiceItem]), application_fee_percent: T.nilable(T.any(String, Float)), automatic_tax: T.nilable(SubscriptionUpdateParams::AutomaticTax), billing_cycle_anchor: T.nilable(String), billing_thresholds: T.nilable(T.any(String, SubscriptionUpdateParams::BillingThresholds)), cancel_at: T.nilable(T.any(String, T.any(Integer, String))), cancel_at_period_end: T.nilable(T::Boolean), cancellation_details: T.nilable(SubscriptionUpdateParams::CancellationDetails), collection_method: T.nilable(String), days_until_due: T.nilable(Integer), default_payment_method: T.nilable(String), default_source: T.nilable(String), default_tax_rates: T.nilable(T.any(String, T::Array[String])), description: T.nilable(String), discounts: T.nilable(T.any(String, T::Array[SubscriptionUpdateParams::Discount])), expand: T.nilable(T::Array[String]), invoice_settings: T.nilable(SubscriptionUpdateParams::InvoiceSettings), items: T.nilable(T::Array[SubscriptionUpdateParams::Item]), metadata: T.nilable(T.any(String, T::Hash[String, String])), off_session: T.nilable(T::Boolean), on_behalf_of: T.nilable(String), pause_collection: T.nilable(T.any(String, SubscriptionUpdateParams::PauseCollection)), payment_behavior: T.nilable(String), payment_settings: T.nilable(SubscriptionUpdateParams::PaymentSettings), pending_invoice_item_interval: T.nilable(T.any(String, SubscriptionUpdateParams::PendingInvoiceItemInterval)), proration_behavior: T.nilable(String), proration_date: T.nilable(Integer), transfer_data: T.nilable(T.any(String, SubscriptionUpdateParams::TransferData)), trial_end: T.nilable(T.any(String, Integer)), trial_from_plan: T.nilable(T::Boolean), trial_settings: T.nilable(SubscriptionUpdateParams::TrialSettings)).void
     }
    def initialize(
      add_invoice_items: nil,
      application_fee_percent: nil,
      automatic_tax: nil,
      billing_cycle_anchor: nil,
      billing_thresholds: nil,
      cancel_at: nil,
      cancel_at_period_end: nil,
      cancellation_details: nil,
      collection_method: nil,
      days_until_due: nil,
      default_payment_method: nil,
      default_source: nil,
      default_tax_rates: nil,
      description: nil,
      discounts: nil,
      expand: nil,
      invoice_settings: nil,
      items: nil,
      metadata: nil,
      off_session: nil,
      on_behalf_of: nil,
      pause_collection: nil,
      payment_behavior: nil,
      payment_settings: nil,
      pending_invoice_item_interval: nil,
      proration_behavior: nil,
      proration_date: nil,
      transfer_data: nil,
      trial_end: nil,
      trial_from_plan: nil,
      trial_settings: nil
    ); end
  end
end