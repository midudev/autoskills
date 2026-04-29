# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Tax rates can be applied to [invoices](https://docs.stripe.com/invoicing/taxes/tax-rates), [subscriptions](https://docs.stripe.com/billing/taxes/tax-rates) and [Checkout Sessions](https://docs.stripe.com/payments/checkout/use-manual-tax-rates) to collect tax.
  #
  # Related guide: [Tax rates](https://docs.stripe.com/billing/taxes/tax-rates)
  class TaxRate < APIResource
    class FlatAmount < ::Stripe::StripeObject
      # Amount of the tax when the `rate_type` is `flat_amount`. This positive integer represents how much to charge in the smallest currency unit (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
      sig { returns(Integer) }
      def amount; end
      # Three-letter ISO currency code, in lowercase.
      sig { returns(String) }
      def currency; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Defaults to `true`. When set to `false`, this tax rate cannot be used with new applications or Checkout Sessions, but will still work for subscriptions and invoices that already have it set.
    sig { returns(T::Boolean) }
    def active; end
    # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
    sig { returns(T.nilable(String)) }
    def country; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # An arbitrary string attached to the tax rate for your internal use only. It will not be visible to your customers.
    sig { returns(T.nilable(String)) }
    def description; end
    # The display name of the tax rates as it will appear to your customer on their receipt email, PDF, and the hosted invoice page.
    sig { returns(String) }
    def display_name; end
    # Actual/effective tax rate percentage out of 100. For tax calculations with automatic_tax[enabled]=true,
    # this percentage reflects the rate actually used to calculate tax based on the product's taxability
    # and whether the user is registered to collect taxes in the corresponding jurisdiction.
    sig { returns(T.nilable(Float)) }
    def effective_percentage; end
    # The amount of the tax rate when the `rate_type` is `flat_amount`. Tax rates with `rate_type` `percentage` can vary based on the transaction, resulting in this field being `null`. This field exposes the amount and currency of the flat tax rate.
    sig { returns(T.nilable(FlatAmount)) }
    def flat_amount; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # This specifies if the tax rate is inclusive or exclusive.
    sig { returns(T::Boolean) }
    def inclusive; end
    # The jurisdiction for the tax rate. You can use this label field for tax reporting purposes. It also appears on your customer’s invoice.
    sig { returns(T.nilable(String)) }
    def jurisdiction; end
    # The level of the jurisdiction that imposes this tax rate. Will be `null` for manually defined tax rates.
    sig { returns(T.nilable(String)) }
    def jurisdiction_level; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Tax rate percentage out of 100. For tax calculations with automatic_tax[enabled]=true, this percentage includes the statutory tax rate of non-taxable jurisdictions.
    sig { returns(Float) }
    def percentage; end
    # Indicates the type of tax rate applied to the taxable amount. This value can be `null` when no tax applies to the location. This field is only present for TaxRates created by Stripe Tax.
    sig { returns(T.nilable(String)) }
    def rate_type; end
    # [ISO 3166-2 subdivision code](https://en.wikipedia.org/wiki/ISO_3166-2), without country prefix. For example, "NY" for New York, United States.
    sig { returns(T.nilable(String)) }
    def state; end
    # The high-level tax type, such as `vat` or `sales_tax`.
    sig { returns(T.nilable(String)) }
    def tax_type; end
    # Creates a new tax rate.
    sig {
      params(params: T.any(::Stripe::TaxRateCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxRate)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of your tax rates. Tax rates are returned sorted by creation date, with the most recently created tax rates appearing first.
    sig {
      params(params: T.any(::Stripe::TaxRateListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates an existing tax rate.
    sig {
      params(tax_rate: String, params: T.any(::Stripe::TaxRateUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxRate)
     }
    def self.update(tax_rate, params = {}, opts = {}); end
  end
end