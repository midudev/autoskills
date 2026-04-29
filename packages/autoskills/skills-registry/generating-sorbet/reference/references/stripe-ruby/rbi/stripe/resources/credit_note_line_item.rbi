# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # The credit note line item object
  class CreditNoteLineItem < StripeObject
    class DiscountAmount < ::Stripe::StripeObject
      # The amount, in cents (or local equivalent), of the discount.
      sig { returns(Integer) }
      def amount; end
      # The discount that was applied to get this discount amount.
      sig { returns(T.any(String, ::Stripe::Discount)) }
      def discount; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PretaxCreditAmount < ::Stripe::StripeObject
      # The amount, in cents (or local equivalent), of the pretax credit amount.
      sig { returns(Integer) }
      def amount; end
      # The credit balance transaction that was applied to get this pretax credit amount.
      sig { returns(T.nilable(T.any(String, ::Stripe::Billing::CreditBalanceTransaction))) }
      def credit_balance_transaction; end
      # The discount that was applied to get this pretax credit amount.
      sig { returns(T.nilable(T.any(String, ::Stripe::Discount))) }
      def discount; end
      # Type of the pretax credit amount referenced.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Tax < ::Stripe::StripeObject
      class TaxRateDetails < ::Stripe::StripeObject
        # ID of the tax rate
        sig { returns(String) }
        def tax_rate; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The amount of the tax, in cents (or local equivalent).
      sig { returns(Integer) }
      def amount; end
      # Whether this tax is inclusive or exclusive.
      sig { returns(String) }
      def tax_behavior; end
      # Additional details about the tax rate. Only present when `type` is `tax_rate_details`.
      sig { returns(T.nilable(TaxRateDetails)) }
      def tax_rate_details; end
      # The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
      sig { returns(String) }
      def taxability_reason; end
      # The amount on which tax is calculated, in cents (or local equivalent).
      sig { returns(T.nilable(Integer)) }
      def taxable_amount; end
      # The type of tax information.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {tax_rate_details: TaxRateDetails}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The integer amount in cents (or local equivalent) representing the gross amount being credited for this line item, excluding (exclusive) tax and discounts.
    sig { returns(Integer) }
    def amount; end
    # Description of the item being credited.
    sig { returns(T.nilable(String)) }
    def description; end
    # The integer amount in cents (or local equivalent) representing the discount being credited for this line item.
    sig { returns(Integer) }
    def discount_amount; end
    # The amount of discount calculated per discount for this line item
    sig { returns(T::Array[DiscountAmount]) }
    def discount_amounts; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # ID of the invoice line item being credited
    sig { returns(T.nilable(String)) }
    def invoice_line_item; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The pretax credit amounts (ex: discount, credit grants, etc) for this line item.
    sig { returns(T::Array[PretaxCreditAmount]) }
    def pretax_credit_amounts; end
    # The number of units of product being credited.
    sig { returns(T.nilable(Integer)) }
    def quantity; end
    # The tax rates which apply to the line item.
    sig { returns(T::Array[::Stripe::TaxRate]) }
    def tax_rates; end
    # The tax information of the line item.
    sig { returns(T.nilable(T::Array[Tax])) }
    def taxes; end
    # The type of the credit note line item, one of `invoice_line_item` or `custom_line_item`. When the type is `invoice_line_item` there is an additional `invoice_line_item` property on the resource the value of which is the id of the credited line item on the invoice.
    sig { returns(String) }
    def type; end
    # The cost of each unit of product being credited.
    sig { returns(T.nilable(Integer)) }
    def unit_amount; end
    # Same as `unit_amount`, but contains a decimal value with at most 12 decimal places.
    sig { returns(T.nilable(String)) }
    def unit_amount_decimal; end
  end
end