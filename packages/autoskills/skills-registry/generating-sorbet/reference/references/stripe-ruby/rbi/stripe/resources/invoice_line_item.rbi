# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Invoice Line Items represent the individual lines within an [invoice](https://docs.stripe.com/api/invoices) and only exist within the context of an invoice.
  #
  # Each line item is backed by either an [invoice item](https://docs.stripe.com/api/invoiceitems) or a [subscription item](https://docs.stripe.com/api/subscription_items).
  class InvoiceLineItem < APIResource
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
    class Parent < ::Stripe::StripeObject
      class InvoiceItemDetails < ::Stripe::StripeObject
        class ProrationDetails < ::Stripe::StripeObject
          class CreditedItems < ::Stripe::StripeObject
            # Invoice containing the credited invoice line items
            sig { returns(String) }
            def invoice; end
            # Credited invoice line items
            sig { returns(T::Array[String]) }
            def invoice_line_items; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # For a credit proration `line_item`, the original debit line_items to which the credit proration applies.
          sig { returns(T.nilable(CreditedItems)) }
          def credited_items; end
          def self.inner_class_types
            @inner_class_types = {credited_items: CreditedItems}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The invoice item that generated this line item
        sig { returns(String) }
        def invoice_item; end
        # Whether this is a proration
        sig { returns(T::Boolean) }
        def proration; end
        # Additional details for proration line items
        sig { returns(T.nilable(ProrationDetails)) }
        def proration_details; end
        # The subscription that the invoice item belongs to
        sig { returns(T.nilable(String)) }
        def subscription; end
        def self.inner_class_types
          @inner_class_types = {proration_details: ProrationDetails}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SubscriptionItemDetails < ::Stripe::StripeObject
        class ProrationDetails < ::Stripe::StripeObject
          class CreditedItems < ::Stripe::StripeObject
            # Invoice containing the credited invoice line items
            sig { returns(String) }
            def invoice; end
            # Credited invoice line items
            sig { returns(T::Array[String]) }
            def invoice_line_items; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # For a credit proration `line_item`, the original debit line_items to which the credit proration applies.
          sig { returns(T.nilable(CreditedItems)) }
          def credited_items; end
          def self.inner_class_types
            @inner_class_types = {credited_items: CreditedItems}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The invoice item that generated this line item
        sig { returns(T.nilable(String)) }
        def invoice_item; end
        # Whether this is a proration
        sig { returns(T::Boolean) }
        def proration; end
        # Additional details for proration line items
        sig { returns(T.nilable(ProrationDetails)) }
        def proration_details; end
        # The subscription that the subscription item belongs to
        sig { returns(T.nilable(String)) }
        def subscription; end
        # The subscription item that generated this line item
        sig { returns(String) }
        def subscription_item; end
        def self.inner_class_types
          @inner_class_types = {proration_details: ProrationDetails}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Details about the invoice item that generated this line item
      sig { returns(T.nilable(InvoiceItemDetails)) }
      def invoice_item_details; end
      # Details about the subscription item that generated this line item
      sig { returns(T.nilable(SubscriptionItemDetails)) }
      def subscription_item_details; end
      # The type of parent that generated this line item
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {
          invoice_item_details: InvoiceItemDetails,
          subscription_item_details: SubscriptionItemDetails,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Period < ::Stripe::StripeObject
      # The end of the period, which must be greater than or equal to the start. This value is inclusive.
      sig { returns(Integer) }
      def end; end
      # The start of the period. This value is inclusive.
      sig { returns(Integer) }
      def start; end
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
    class Pricing < ::Stripe::StripeObject
      class PriceDetails < ::Stripe::StripeObject
        # The ID of the price this item is associated with.
        sig { returns(T.any(String, ::Stripe::Price)) }
        def price; end
        # The ID of the product this item is associated with.
        sig { returns(String) }
        def product; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field price_details
      sig { returns(T.nilable(PriceDetails)) }
      def price_details; end
      # The type of the pricing details.
      sig { returns(String) }
      def type; end
      # The unit amount (in the `currency` specified) of the item which contains a decimal value with at most 12 decimal places.
      sig { returns(T.nilable(String)) }
      def unit_amount_decimal; end
      def self.inner_class_types
        @inner_class_types = {price_details: PriceDetails}
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
    # The amount, in cents (or local equivalent).
    sig { returns(Integer) }
    def amount; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # The amount of discount calculated per discount for this line item.
    sig { returns(T.nilable(T::Array[DiscountAmount])) }
    def discount_amounts; end
    # If true, discounts will apply to this line item. Always false for prorations.
    sig { returns(T::Boolean) }
    def discountable; end
    # The discounts applied to the invoice line item. Line item discounts are applied before invoice discounts. Use `expand[]=discounts` to expand each discount.
    sig { returns(T::Array[T.any(String, ::Stripe::Discount)]) }
    def discounts; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The ID of the invoice that contains this line item.
    sig { returns(T.nilable(String)) }
    def invoice; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Note that for line items with `type=subscription`, `metadata` reflects the current metadata from the subscription associated with the line item, unless the invoice line was directly updated with different metadata after creation.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The parent that generated this line item.
    sig { returns(T.nilable(Parent)) }
    def parent; end
    # Attribute for field period
    sig { returns(Period) }
    def period; end
    # Contains pretax credit amounts (ex: discount, credit grants, etc) that apply to this line item.
    sig { returns(T.nilable(T::Array[PretaxCreditAmount])) }
    def pretax_credit_amounts; end
    # The pricing information of the line item.
    sig { returns(T.nilable(Pricing)) }
    def pricing; end
    # The quantity of the subscription, if the line item is a subscription or a proration.
    sig { returns(T.nilable(Integer)) }
    def quantity; end
    # Attribute for field subscription
    sig { returns(T.nilable(T.any(String, ::Stripe::Subscription))) }
    def subscription; end
    # The subtotal of the line item, in cents (or local equivalent), before any discounts or taxes.
    sig { returns(Integer) }
    def subtotal; end
    # The tax information of the line item.
    sig { returns(T.nilable(T::Array[Tax])) }
    def taxes; end
    # Updates an invoice's line item. Some fields, such as tax_amounts, only live on the invoice line item,
    # so they can only be updated through this endpoint. Other fields, such as amount, live on both the invoice
    # item and the invoice line item, so updates on this endpoint will propagate to the invoice item as well.
    # Updating an invoice's line item is only possible before the invoice is finalized.
    sig {
      params(invoice: String, line_item_id: String, params: T.any(::Stripe::InvoiceLineItemUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::InvoiceLineItem)
     }
    def self.update(invoice, line_item_id, params = {}, opts = {}); end
  end
end