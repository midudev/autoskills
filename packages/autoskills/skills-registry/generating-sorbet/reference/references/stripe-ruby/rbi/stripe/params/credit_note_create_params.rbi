# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CreditNoteCreateParams < ::Stripe::RequestParams
    class Line < ::Stripe::RequestParams
      class TaxAmount < ::Stripe::RequestParams
        # The amount, in cents (or local equivalent), of the tax.
        sig { returns(Integer) }
        def amount; end
        sig { params(_amount: Integer).returns(Integer) }
        def amount=(_amount); end
        # The id of the tax rate for this tax amount. The tax rate must have been automatically created by Stripe.
        sig { returns(String) }
        def tax_rate; end
        sig { params(_tax_rate: String).returns(String) }
        def tax_rate=(_tax_rate); end
        # The amount on which tax is calculated, in cents (or local equivalent).
        sig { returns(Integer) }
        def taxable_amount; end
        sig { params(_taxable_amount: Integer).returns(Integer) }
        def taxable_amount=(_taxable_amount); end
        sig { params(amount: Integer, tax_rate: String, taxable_amount: Integer).void }
        def initialize(amount: nil, tax_rate: nil, taxable_amount: nil); end
      end
      # The line item amount to credit. Only valid when `type` is `invoice_line_item`. If invoice is set up with `automatic_tax[enabled]=true`, this amount is tax exclusive
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      # The description of the credit note line item. Only valid when the `type` is `custom_line_item`.
      sig { returns(T.nilable(String)) }
      def description; end
      sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
      def description=(_description); end
      # The invoice line item to credit. Only valid when the `type` is `invoice_line_item`.
      sig { returns(T.nilable(String)) }
      def invoice_line_item; end
      sig { params(_invoice_line_item: T.nilable(String)).returns(T.nilable(String)) }
      def invoice_line_item=(_invoice_line_item); end
      # The line item quantity to credit.
      sig { returns(T.nilable(Integer)) }
      def quantity; end
      sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def quantity=(_quantity); end
      # A list of up to 10 tax amounts for the credit note line item. Cannot be mixed with `tax_rates`.
      sig { returns(T.nilable(T.any(String, T::Array[CreditNoteCreateParams::Line::TaxAmount]))) }
      def tax_amounts; end
      sig {
        params(_tax_amounts: T.nilable(T.any(String, T::Array[CreditNoteCreateParams::Line::TaxAmount]))).returns(T.nilable(T.any(String, T::Array[CreditNoteCreateParams::Line::TaxAmount])))
       }
      def tax_amounts=(_tax_amounts); end
      # The tax rates which apply to the credit note line item. Only valid when the `type` is `custom_line_item` and cannot be mixed with `tax_amounts`.
      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def tax_rates; end
      sig {
        params(_tax_rates: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
       }
      def tax_rates=(_tax_rates); end
      # Type of the credit note line item, one of `invoice_line_item` or `custom_line_item`
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      # The integer unit amount in cents (or local equivalent) of the credit note line item. This `unit_amount` will be multiplied by the quantity to get the full amount to credit for this line item. Only valid when `type` is `custom_line_item`.
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
        params(amount: T.nilable(Integer), description: T.nilable(String), invoice_line_item: T.nilable(String), quantity: T.nilable(Integer), tax_amounts: T.nilable(T.any(String, T::Array[CreditNoteCreateParams::Line::TaxAmount])), tax_rates: T.nilable(T.any(String, T::Array[String])), type: String, unit_amount: T.nilable(Integer), unit_amount_decimal: T.nilable(String)).void
       }
      def initialize(
        amount: nil,
        description: nil,
        invoice_line_item: nil,
        quantity: nil,
        tax_amounts: nil,
        tax_rates: nil,
        type: nil,
        unit_amount: nil,
        unit_amount_decimal: nil
      ); end
    end
    class Refund < ::Stripe::RequestParams
      class PaymentRecordRefund < ::Stripe::RequestParams
        # The ID of the PaymentRecord with the refund to link to this credit note.
        sig { returns(String) }
        def payment_record; end
        sig { params(_payment_record: String).returns(String) }
        def payment_record=(_payment_record); end
        # The PaymentRecord refund group to link to this credit note. For refunds processed off-Stripe, this will correspond to the `processor_details.custom.refund_reference` field provided when reporting the refund on the PaymentRecord.
        sig { returns(String) }
        def refund_group; end
        sig { params(_refund_group: String).returns(String) }
        def refund_group=(_refund_group); end
        sig { params(payment_record: String, refund_group: String).void }
        def initialize(payment_record: nil, refund_group: nil); end
      end
      # Amount of the refund that applies to this credit note, in cents (or local equivalent). Defaults to the entire refund amount.
      sig { returns(T.nilable(Integer)) }
      def amount_refunded; end
      sig { params(_amount_refunded: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount_refunded=(_amount_refunded); end
      # The PaymentRecord refund details to link to this credit note. Required when `type` is `payment_record_refund`.
      sig { returns(T.nilable(CreditNoteCreateParams::Refund::PaymentRecordRefund)) }
      def payment_record_refund; end
      sig {
        params(_payment_record_refund: T.nilable(CreditNoteCreateParams::Refund::PaymentRecordRefund)).returns(T.nilable(CreditNoteCreateParams::Refund::PaymentRecordRefund))
       }
      def payment_record_refund=(_payment_record_refund); end
      # ID of an existing refund to link this credit note to. Required when `type` is `refund`.
      sig { returns(T.nilable(String)) }
      def refund; end
      sig { params(_refund: T.nilable(String)).returns(T.nilable(String)) }
      def refund=(_refund); end
      # Type of the refund, one of `refund` or `payment_record_refund`. Defaults to `refund`.
      sig { returns(T.nilable(String)) }
      def type; end
      sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
      def type=(_type); end
      sig {
        params(amount_refunded: T.nilable(Integer), payment_record_refund: T.nilable(CreditNoteCreateParams::Refund::PaymentRecordRefund), refund: T.nilable(String), type: T.nilable(String)).void
       }
      def initialize(amount_refunded: nil, payment_record_refund: nil, refund: nil, type: nil); end
    end
    class ShippingCost < ::Stripe::RequestParams
      # The ID of the shipping rate to use for this order.
      sig { returns(T.nilable(String)) }
      def shipping_rate; end
      sig { params(_shipping_rate: T.nilable(String)).returns(T.nilable(String)) }
      def shipping_rate=(_shipping_rate); end
      sig { params(shipping_rate: T.nilable(String)).void }
      def initialize(shipping_rate: nil); end
    end
    # The integer amount in cents (or local equivalent) representing the total amount of the credit note. One of `amount`, `lines`, or `shipping_cost` must be provided.
    sig { returns(T.nilable(Integer)) }
    def amount; end
    sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount=(_amount); end
    # The integer amount in cents (or local equivalent) representing the amount to credit the customer's balance, which will be automatically applied to their next invoice.
    sig { returns(T.nilable(Integer)) }
    def credit_amount; end
    sig { params(_credit_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def credit_amount=(_credit_amount); end
    # The date when this credit note is in effect. Same as `created` unless overwritten. When defined, this value replaces the system-generated 'Date of issue' printed on the credit note PDF.
    sig { returns(T.nilable(Integer)) }
    def effective_at; end
    sig { params(_effective_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def effective_at=(_effective_at); end
    # Type of email to send to the customer, one of `credit_note` or `none` and the default is `credit_note`.
    sig { returns(T.nilable(String)) }
    def email_type; end
    sig { params(_email_type: T.nilable(String)).returns(T.nilable(String)) }
    def email_type=(_email_type); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # ID of the invoice.
    sig { returns(String) }
    def invoice; end
    sig { params(_invoice: String).returns(String) }
    def invoice=(_invoice); end
    # Line items that make up the credit note. One of `amount`, `lines`, or `shipping_cost` must be provided.
    sig { returns(T.nilable(T::Array[CreditNoteCreateParams::Line])) }
    def lines; end
    sig {
      params(_lines: T.nilable(T::Array[CreditNoteCreateParams::Line])).returns(T.nilable(T::Array[CreditNoteCreateParams::Line]))
     }
    def lines=(_lines); end
    # The credit note's memo appears on the credit note PDF.
    sig { returns(T.nilable(String)) }
    def memo; end
    sig { params(_memo: T.nilable(String)).returns(T.nilable(String)) }
    def memo=(_memo); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    # The integer amount in cents (or local equivalent) representing the amount that is credited outside of Stripe.
    sig { returns(T.nilable(Integer)) }
    def out_of_band_amount; end
    sig { params(_out_of_band_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def out_of_band_amount=(_out_of_band_amount); end
    # Reason for issuing this credit note, one of `duplicate`, `fraudulent`, `order_change`, or `product_unsatisfactory`
    sig { returns(T.nilable(String)) }
    def reason; end
    sig { params(_reason: T.nilable(String)).returns(T.nilable(String)) }
    def reason=(_reason); end
    # The integer amount in cents (or local equivalent) representing the amount to refund. If set, a refund will be created for the charge associated with the invoice.
    sig { returns(T.nilable(Integer)) }
    def refund_amount; end
    sig { params(_refund_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def refund_amount=(_refund_amount); end
    # Refunds to link to this credit note.
    sig { returns(T.nilable(T::Array[CreditNoteCreateParams::Refund])) }
    def refunds; end
    sig {
      params(_refunds: T.nilable(T::Array[CreditNoteCreateParams::Refund])).returns(T.nilable(T::Array[CreditNoteCreateParams::Refund]))
     }
    def refunds=(_refunds); end
    # When shipping_cost contains the shipping_rate from the invoice, the shipping_cost is included in the credit note. One of `amount`, `lines`, or `shipping_cost` must be provided.
    sig { returns(T.nilable(CreditNoteCreateParams::ShippingCost)) }
    def shipping_cost; end
    sig {
      params(_shipping_cost: T.nilable(CreditNoteCreateParams::ShippingCost)).returns(T.nilable(CreditNoteCreateParams::ShippingCost))
     }
    def shipping_cost=(_shipping_cost); end
    sig {
      params(amount: T.nilable(Integer), credit_amount: T.nilable(Integer), effective_at: T.nilable(Integer), email_type: T.nilable(String), expand: T.nilable(T::Array[String]), invoice: String, lines: T.nilable(T::Array[CreditNoteCreateParams::Line]), memo: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), out_of_band_amount: T.nilable(Integer), reason: T.nilable(String), refund_amount: T.nilable(Integer), refunds: T.nilable(T::Array[CreditNoteCreateParams::Refund]), shipping_cost: T.nilable(CreditNoteCreateParams::ShippingCost)).void
     }
    def initialize(
      amount: nil,
      credit_amount: nil,
      effective_at: nil,
      email_type: nil,
      expand: nil,
      invoice: nil,
      lines: nil,
      memo: nil,
      metadata: nil,
      out_of_band_amount: nil,
      reason: nil,
      refund_amount: nil,
      refunds: nil,
      shipping_cost: nil
    ); end
  end
end