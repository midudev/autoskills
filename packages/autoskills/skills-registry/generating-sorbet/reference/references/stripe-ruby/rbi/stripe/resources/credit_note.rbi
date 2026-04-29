# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Issue a credit note to adjust an invoice's amount after the invoice is finalized.
  #
  # Related guide: [Credit notes](https://docs.stripe.com/billing/invoices/credit-notes)
  class CreditNote < APIResource
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
    class Refund < ::Stripe::StripeObject
      class PaymentRecordRefund < ::Stripe::StripeObject
        # ID of the payment record.
        sig { returns(String) }
        def payment_record; end
        # ID of the refund group.
        sig { returns(String) }
        def refund_group; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Amount of the refund that applies to this credit note, in cents (or local equivalent).
      sig { returns(Integer) }
      def amount_refunded; end
      # The PaymentRecord refund details associated with this credit note refund.
      sig { returns(T.nilable(PaymentRecordRefund)) }
      def payment_record_refund; end
      # ID of the refund.
      sig { returns(T.any(String, ::Stripe::Refund)) }
      def refund; end
      # Type of the refund, one of `refund` or `payment_record_refund`.
      sig { returns(T.nilable(String)) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {payment_record_refund: PaymentRecordRefund}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ShippingCost < ::Stripe::StripeObject
      class Tax < ::Stripe::StripeObject
        # Amount of tax applied for this rate.
        sig { returns(Integer) }
        def amount; end
        # Tax rates can be applied to [invoices](/invoicing/taxes/tax-rates), [subscriptions](/billing/taxes/tax-rates) and [Checkout Sessions](/payments/checkout/use-manual-tax-rates) to collect tax.
        #
        # Related guide: [Tax rates](/billing/taxes/tax-rates)
        sig { returns(::Stripe::TaxRate) }
        def rate; end
        # The reasoning behind this tax, for example, if the product is tax exempt. The possible values for this field may be extended as new tax rules are supported.
        sig { returns(T.nilable(String)) }
        def taxability_reason; end
        # The amount on which tax is calculated, in cents (or local equivalent).
        sig { returns(T.nilable(Integer)) }
        def taxable_amount; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Total shipping cost before any taxes are applied.
      sig { returns(Integer) }
      def amount_subtotal; end
      # Total tax amount applied due to shipping costs. If no tax was applied, defaults to 0.
      sig { returns(Integer) }
      def amount_tax; end
      # Total shipping cost after taxes are applied.
      sig { returns(Integer) }
      def amount_total; end
      # The ID of the ShippingRate for this invoice.
      sig { returns(T.nilable(T.any(String, ::Stripe::ShippingRate))) }
      def shipping_rate; end
      # The taxes applied to the shipping rate.
      sig { returns(T.nilable(T::Array[Tax])) }
      def taxes; end
      def self.inner_class_types
        @inner_class_types = {taxes: Tax}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TotalTax < ::Stripe::StripeObject
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
    # The integer amount in cents (or local equivalent) representing the total amount of the credit note, including tax.
    sig { returns(Integer) }
    def amount; end
    # This is the sum of all the shipping amounts.
    sig { returns(Integer) }
    def amount_shipping; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # ID of the customer.
    sig { returns(T.any(String, ::Stripe::Customer)) }
    def customer; end
    # ID of the account representing the customer.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # Customer balance transaction related to this credit note.
    sig { returns(T.nilable(T.any(String, ::Stripe::CustomerBalanceTransaction))) }
    def customer_balance_transaction; end
    # The integer amount in cents (or local equivalent) representing the total amount of discount that was credited.
    sig { returns(Integer) }
    def discount_amount; end
    # The aggregate amounts calculated per discount for all line items.
    sig { returns(T::Array[DiscountAmount]) }
    def discount_amounts; end
    # The date when this credit note is in effect. Same as `created` unless overwritten. When defined, this value replaces the system-generated 'Date of issue' printed on the credit note PDF.
    sig { returns(T.nilable(Integer)) }
    def effective_at; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # ID of the invoice.
    sig { returns(T.any(String, ::Stripe::Invoice)) }
    def invoice; end
    # Line items that make up the credit note
    sig { returns(::Stripe::ListObject) }
    def lines; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Customer-facing text that appears on the credit note PDF.
    sig { returns(T.nilable(String)) }
    def memo; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # A unique number that identifies this particular credit note and appears on the PDF of the credit note and its associated invoice.
    sig { returns(String) }
    def number; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Amount that was credited outside of Stripe.
    sig { returns(T.nilable(Integer)) }
    def out_of_band_amount; end
    # The link to download the PDF of the credit note.
    sig { returns(String) }
    def pdf; end
    # The amount of the credit note that was refunded to the customer, credited to the customer's balance, credited outside of Stripe, or any combination thereof.
    sig { returns(Integer) }
    def post_payment_amount; end
    # The amount of the credit note by which the invoice's `amount_remaining` and `amount_due` were reduced.
    sig { returns(Integer) }
    def pre_payment_amount; end
    # The pretax credit amounts (ex: discount, credit grants, etc) for all line items.
    sig { returns(T::Array[PretaxCreditAmount]) }
    def pretax_credit_amounts; end
    # Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`
    sig { returns(T.nilable(String)) }
    def reason; end
    # Refunds related to this credit note.
    sig { returns(T::Array[Refund]) }
    def refunds; end
    # The details of the cost of shipping, including the ShippingRate applied to the invoice.
    sig { returns(T.nilable(ShippingCost)) }
    def shipping_cost; end
    # Status of this credit note, one of `issued` or `void`. Learn more about [voiding credit notes](https://docs.stripe.com/billing/invoices/credit-notes#voiding).
    sig { returns(String) }
    def status; end
    # The integer amount in cents (or local equivalent) representing the amount of the credit note, excluding exclusive tax and invoice level discounts.
    sig { returns(Integer) }
    def subtotal; end
    # The integer amount in cents (or local equivalent) representing the amount of the credit note, excluding all tax and invoice level discounts.
    sig { returns(T.nilable(Integer)) }
    def subtotal_excluding_tax; end
    # The integer amount in cents (or local equivalent) representing the total amount of the credit note, including tax and all discount.
    sig { returns(Integer) }
    def total; end
    # The integer amount in cents (or local equivalent) representing the total amount of the credit note, excluding tax, but including discounts.
    sig { returns(T.nilable(Integer)) }
    def total_excluding_tax; end
    # The aggregate tax information for all line items.
    sig { returns(T.nilable(T::Array[TotalTax])) }
    def total_taxes; end
    # Type of this credit note, one of `pre_payment` or `post_payment`. A `pre_payment` credit note means it was issued when the invoice was open. A `post_payment` credit note means it was issued when the invoice was paid.
    sig { returns(String) }
    def type; end
    # The time that the credit note was voided.
    sig { returns(T.nilable(Integer)) }
    def voided_at; end
    # Issue a credit note to adjust the amount of a finalized invoice. A credit note will first reduce the invoice's amount_remaining (and amount_due), but not below zero.
    # This amount is indicated by the credit note's pre_payment_amount. The excess amount is indicated by post_payment_amount, and it can result in any combination of the following:
    #
    #
    # Refunds: create a new refund (using refund_amount) or link existing refunds (using refunds).
    # Customer balance credit: credit the customer's balance (using credit_amount) which will be automatically applied to their next invoice when it's finalized.
    # Outside of Stripe credit: record the amount that is or will be credited outside of Stripe (using out_of_band_amount).
    #
    #
    # The sum of refunds, customer balance credits, and outside of Stripe credits must equal the post_payment_amount.
    #
    # You may issue multiple credit notes for an invoice. Each credit note may increment the invoice's pre_payment_credit_notes_amount,
    # post_payment_credit_notes_amount, or both, depending on the invoice's amount_remaining at the time of credit note creation.
    sig {
      params(params: T.any(::Stripe::CreditNoteCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CreditNote)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of credit notes.
    sig {
      params(params: T.any(::Stripe::CreditNoteListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # When retrieving a credit note preview, you'll get a lines property containing the first handful of those items. This URL you can retrieve the full (paginated) list of line items.
    sig {
      params(params: T.any(::Stripe::CreditNoteListPreviewLineItemsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list_preview_line_items(params = {}, opts = {}); end

    # Get a preview of a credit note without creating it.
    sig {
      params(params: T.any(::Stripe::CreditNotePreviewParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CreditNote)
     }
    def self.preview(params = {}, opts = {}); end

    # Updates an existing credit note.
    sig {
      params(id: String, params: T.any(::Stripe::CreditNoteUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CreditNote)
     }
    def self.update(id, params = {}, opts = {}); end

    # Marks a credit note as void. Learn more about [voiding credit notes](https://docs.stripe.com/docs/billing/invoices/credit-notes#voiding).
    sig {
      params(params: T.any(::Stripe::CreditNoteVoidCreditNoteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CreditNote)
     }
    def void_credit_note(params = {}, opts = {}); end

    # Marks a credit note as void. Learn more about [voiding credit notes](https://docs.stripe.com/docs/billing/invoices/credit-notes#voiding).
    sig {
      params(id: String, params: T.any(::Stripe::CreditNoteVoidCreditNoteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CreditNote)
     }
    def self.void_credit_note(id, params = {}, opts = {}); end
  end
end