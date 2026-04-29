# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Invoice Items represent the component lines of an [invoice](https://docs.stripe.com/api/invoices). When you create an invoice item with an `invoice` field, it is attached to the specified invoice and included as [an invoice line item](https://docs.stripe.com/api/invoices/line_item) within [invoice.lines](https://docs.stripe.com/api/invoices/object#invoice_object-lines).
  #
  # Invoice Items can be created before you are ready to actually send the invoice. This can be particularly useful when combined
  # with a [subscription](https://docs.stripe.com/api/subscriptions). Sometimes you want to add a charge or credit to a customer, but actually charge
  # or credit the customer's card only at the end of a regular billing cycle. This is useful for combining several charges
  # (to minimize per-transaction fees), or for having Stripe tabulate your usage-based billing totals.
  #
  # Related guides: [Integrate with the Invoicing API](https://docs.stripe.com/invoicing/integration), [Subscription Invoices](https://docs.stripe.com/billing/invoices/subscription#adding-upcoming-invoice-items).
  class InvoiceItem < APIResource
    class Parent < ::Stripe::StripeObject
      class SubscriptionDetails < ::Stripe::StripeObject
        # The subscription that generated this invoice item
        sig { returns(String) }
        def subscription; end
        # The subscription item that generated this invoice item
        sig { returns(T.nilable(String)) }
        def subscription_item; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Details about the subscription that generated this invoice item
      sig { returns(T.nilable(SubscriptionDetails)) }
      def subscription_details; end
      # The type of parent that generated this invoice item
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {subscription_details: SubscriptionDetails}
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
    class ProrationDetails < ::Stripe::StripeObject
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
      # Discount amounts applied when the proration was created.
      sig { returns(T::Array[DiscountAmount]) }
      def discount_amounts; end
      def self.inner_class_types
        @inner_class_types = {discount_amounts: DiscountAmount}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Amount (in the `currency` specified) of the invoice item. This should always be equal to `unit_amount * quantity`.
    sig { returns(Integer) }
    def amount; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # The ID of the customer to bill for this invoice item.
    sig { returns(T.any(String, ::Stripe::Customer)) }
    def customer; end
    # The ID of the account to bill for this invoice item.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def date; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # If true, discounts will apply to this invoice item. Always false for prorations.
    sig { returns(T::Boolean) }
    def discountable; end
    # The discounts which apply to the invoice item. Item discounts are applied before invoice discounts. Use `expand[]=discounts` to expand each discount.
    sig { returns(T.nilable(T::Array[T.any(String, ::Stripe::Discount)])) }
    def discounts; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The ID of the invoice this invoice item belongs to.
    sig { returns(T.nilable(T.any(String, ::Stripe::Invoice))) }
    def invoice; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # The amount after discounts, but before credits and taxes. This field is `null` for `discountable=true` items.
    sig { returns(T.nilable(Integer)) }
    def net_amount; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The parent that generated this invoice item.
    sig { returns(T.nilable(Parent)) }
    def parent; end
    # Attribute for field period
    sig { returns(Period) }
    def period; end
    # The pricing information of the invoice item.
    sig { returns(T.nilable(Pricing)) }
    def pricing; end
    # Whether the invoice item was created automatically as a proration adjustment when the customer switched plans.
    sig { returns(T::Boolean) }
    def proration; end
    # Attribute for field proration_details
    sig { returns(T.nilable(ProrationDetails)) }
    def proration_details; end
    # Quantity of units for the invoice item. If the invoice item is a proration, the quantity of the subscription that the proration was computed for.
    sig { returns(Integer) }
    def quantity; end
    # The tax rates which apply to the invoice item. When set, the `default_tax_rates` on the invoice do not apply to this invoice item.
    sig { returns(T.nilable(T::Array[::Stripe::TaxRate])) }
    def tax_rates; end
    # ID of the test clock this invoice item belongs to.
    sig { returns(T.nilable(T.any(String, ::Stripe::TestHelpers::TestClock))) }
    def test_clock; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # Creates an item to be added to a draft invoice (up to 250 items per invoice). If no invoice is specified, the item will be on the next invoice created for the customer specified.
    sig {
      params(params: T.any(::Stripe::InvoiceItemCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::InvoiceItem)
     }
    def self.create(params = {}, opts = {}); end

    # Deletes an invoice item, removing it from an invoice. Deleting invoice items is only possible when they're not attached to invoices, or if it's attached to a draft invoice.
    sig {
      params(invoiceitem: String, params: T.any(::Stripe::InvoiceItemDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::InvoiceItem)
     }
    def self.delete(invoiceitem, params = {}, opts = {}); end

    # Deletes an invoice item, removing it from an invoice. Deleting invoice items is only possible when they're not attached to invoices, or if it's attached to a draft invoice.
    sig {
      params(params: T.any(::Stripe::InvoiceItemDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::InvoiceItem)
     }
    def delete(params = {}, opts = {}); end

    # Returns a list of your invoice items. Invoice items are returned sorted by creation date, with the most recently created invoice items appearing first.
    sig {
      params(params: T.any(::Stripe::InvoiceItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates the amount or description of an invoice item on an upcoming invoice. Updating an invoice item is only possible before the invoice it's attached to is closed.
    sig {
      params(invoiceitem: String, params: T.any(::Stripe::InvoiceItemUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::InvoiceItem)
     }
    def self.update(invoiceitem, params = {}, opts = {}); end
  end
end