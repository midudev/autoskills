# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class CalculationLineItem < APIResource
      class TaxBreakdown < ::Stripe::StripeObject
        class Jurisdiction < ::Stripe::StripeObject
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(String) }
          def country; end
          # A human-readable name for the jurisdiction imposing the tax.
          sig { returns(String) }
          def display_name; end
          # Indicates the level of the jurisdiction imposing the tax.
          sig { returns(String) }
          def level; end
          # [ISO 3166-2 subdivision code](https://en.wikipedia.org/wiki/ISO_3166-2), without country prefix. For example, "NY" for New York, United States.
          sig { returns(T.nilable(String)) }
          def state; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class TaxRateDetails < ::Stripe::StripeObject
          # A localized display name for tax type, intended to be human-readable. For example, "Local Sales and Use Tax", "Value-added tax (VAT)", or "Umsatzsteuer (USt.)".
          sig { returns(String) }
          def display_name; end
          # The tax rate percentage as a string. For example, 8.5% is represented as "8.5".
          sig { returns(String) }
          def percentage_decimal; end
          # The tax type, such as `vat` or `sales_tax`.
          sig { returns(String) }
          def tax_type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The amount of tax, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(Integer) }
        def amount; end
        # Attribute for field jurisdiction
        sig { returns(Jurisdiction) }
        def jurisdiction; end
        # Indicates whether the jurisdiction was determined by the origin (merchant's address) or destination (customer's address).
        sig { returns(String) }
        def sourcing; end
        # Details regarding the rate for this tax. This field will be `null` when the tax is not imposed, for example if the product is exempt from tax.
        sig { returns(T.nilable(TaxRateDetails)) }
        def tax_rate_details; end
        # The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        sig { returns(String) }
        def taxability_reason; end
        # The amount on which tax is calculated, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(Integer) }
        def taxable_amount; end
        def self.inner_class_types
          @inner_class_types = {jurisdiction: Jurisdiction, tax_rate_details: TaxRateDetails}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The line item amount in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). If `tax_behavior=inclusive`, then this amount includes taxes. Otherwise, taxes were calculated on top of this amount.
      sig { returns(Integer) }
      def amount; end
      # The amount of tax calculated for this line item, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
      sig { returns(Integer) }
      def amount_tax; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The ID of an existing [Product](https://docs.stripe.com/api/products/object).
      sig { returns(T.nilable(String)) }
      def product; end
      # The number of units of the item being purchased. For reversals, this is the quantity reversed.
      sig { returns(Integer) }
      def quantity; end
      # A custom identifier for this line item.
      sig { returns(String) }
      def reference; end
      # Specifies whether the `amount` includes taxes. If `tax_behavior=inclusive`, then the amount includes taxes.
      sig { returns(String) }
      def tax_behavior; end
      # Detailed account of taxes relevant to this line item.
      sig { returns(T.nilable(T::Array[TaxBreakdown])) }
      def tax_breakdown; end
      # The [tax code](https://docs.stripe.com/tax/tax-categories) ID used for this resource.
      sig { returns(String) }
      def tax_code; end
    end
  end
end