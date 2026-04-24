# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # This object represents a customer of your business. Use it to [create recurring charges](https://docs.stripe.com/invoicing/customer), [save payment](https://docs.stripe.com/payments/save-during-payment) and contact information,
  # and track payments that belong to the same customer.
  class Customer < APIResource
    class Address < ::Stripe::StripeObject
      # City, district, suburb, town, or village.
      sig { returns(T.nilable(String)) }
      def city; end
      # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
      sig { returns(T.nilable(String)) }
      def country; end
      # Address line 1, such as the street, PO Box, or company name.
      sig { returns(T.nilable(String)) }
      def line1; end
      # Address line 2, such as the apartment, suite, unit, or building.
      sig { returns(T.nilable(String)) }
      def line2; end
      # ZIP or postal code.
      sig { returns(T.nilable(String)) }
      def postal_code; end
      # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
      sig { returns(T.nilable(String)) }
      def state; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class InvoiceSettings < ::Stripe::StripeObject
      class CustomField < ::Stripe::StripeObject
        # The name of the custom field.
        sig { returns(String) }
        def name; end
        # The value of the custom field.
        sig { returns(String) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RenderingOptions < ::Stripe::StripeObject
        # How line-item prices and amounts will be displayed with respect to tax on invoice PDFs.
        sig { returns(T.nilable(String)) }
        def amount_tax_display; end
        # ID of the invoice rendering template to be used for this customer's invoices. If set, the template will be used on all invoices for this customer unless a template is set directly on the invoice.
        sig { returns(T.nilable(String)) }
        def template; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Default custom fields to be displayed on invoices for this customer.
      sig { returns(T.nilable(T::Array[CustomField])) }
      def custom_fields; end
      # ID of a payment method that's attached to the customer, to be used as the customer's default payment method for subscriptions and invoices.
      sig { returns(T.nilable(T.any(String, ::Stripe::PaymentMethod))) }
      def default_payment_method; end
      # Default footer to be displayed on invoices for this customer.
      sig { returns(T.nilable(String)) }
      def footer; end
      # Default options for invoice PDF rendering for this customer.
      sig { returns(T.nilable(RenderingOptions)) }
      def rendering_options; end
      def self.inner_class_types
        @inner_class_types = {custom_fields: CustomField, rendering_options: RenderingOptions}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Shipping < ::Stripe::StripeObject
      class Address < ::Stripe::StripeObject
        # City, district, suburb, town, or village.
        sig { returns(T.nilable(String)) }
        def city; end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        # Address line 1, such as the street, PO Box, or company name.
        sig { returns(T.nilable(String)) }
        def line1; end
        # Address line 2, such as the apartment, suite, unit, or building.
        sig { returns(T.nilable(String)) }
        def line2; end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
        sig { returns(T.nilable(String)) }
        def state; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field address
      sig { returns(T.nilable(Address)) }
      def address; end
      # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
      sig { returns(T.nilable(String)) }
      def carrier; end
      # Recipient name.
      sig { returns(T.nilable(String)) }
      def name; end
      # Recipient phone (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
      sig { returns(T.nilable(String)) }
      def tracking_number; end
      def self.inner_class_types
        @inner_class_types = {address: Address}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Tax < ::Stripe::StripeObject
      class Location < ::Stripe::StripeObject
        # The identified tax country of the customer.
        sig { returns(String) }
        def country; end
        # The data source used to infer the customer's location.
        sig { returns(String) }
        def source; end
        # The identified tax state, county, province, or region of the customer.
        sig { returns(T.nilable(String)) }
        def state; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Surfaces if automatic tax computation is possible given the current customer location information.
      sig { returns(String) }
      def automatic_tax; end
      # A recent IP address of the customer used for tax reporting and tax location inference.
      sig { returns(T.nilable(String)) }
      def ip_address; end
      # The identified tax location of the customer.
      sig { returns(T.nilable(Location)) }
      def location; end
      # The tax calculation provider used for location resolution. Defaults to `stripe` when not using a [third-party provider](/tax/third-party-apps).
      sig { returns(String) }
      def provider; end
      def self.inner_class_types
        @inner_class_types = {location: Location}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The customer's address.
    sig { returns(T.nilable(Address)) }
    def address; end
    # The current balance, if any, that's stored on the customer in their default currency. If negative, the customer has credit to apply to their next invoice. If positive, the customer has an amount owed that's added to their next invoice. The balance only considers amounts that Stripe hasn't successfully applied to any invoice. It doesn't reflect unpaid invoices. This balance is only taken into account after invoices finalize. For multi-currency balances, see [invoice_credit_balance](https://docs.stripe.com/api/customers/object#customer_object-invoice_credit_balance).
    sig { returns(T.nilable(Integer)) }
    def balance; end
    # The customer's business name.
    sig { returns(T.nilable(String)) }
    def business_name; end
    # The current funds being held by Stripe on behalf of the customer. You can apply these funds towards payment intents when the source is "cash_balance". The `settings[reconciliation_mode]` field describes if these funds apply to these payment intents manually or automatically.
    sig { returns(T.nilable(::Stripe::CashBalance)) }
    def cash_balance; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) the customer can be charged in for recurring billing purposes.
    sig { returns(T.nilable(String)) }
    def currency; end
    # The ID of an Account representing a customer. You can use this ID with any v1 API that accepts a customer_account parameter.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # ID of the default payment source for the customer.
    #
    # If you use payment methods created through the PaymentMethods API, see the [invoice_settings.default_payment_method](https://docs.stripe.com/api/customers/object#customer_object-invoice_settings-default_payment_method) field instead.
    sig {
      returns(T.nilable(T.any(String, T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source))))
     }
    def default_source; end
    # Tracks the most recent state change on any invoice belonging to the customer. Paying an invoice or marking it uncollectible via the API will set this field to false. An automatic payment failure or passing the `invoice.due_date` will set this field to `true`.
    #
    # If an invoice becomes uncollectible by [dunning](https://docs.stripe.com/billing/automatic-collection), `delinquent` doesn't reset to `false`.
    #
    # If you care whether the customer has paid their most recent subscription invoice, use `subscription.status` instead. Paying or marking uncollectible any customer invoice regardless of whether it is the latest invoice for a subscription will always set this field to `false`.
    sig { returns(T.nilable(T::Boolean)) }
    def delinquent; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # Describes the current discount active on the customer, if there is one.
    sig { returns(T.nilable(::Stripe::Discount)) }
    def discount; end
    # The customer's email address.
    sig { returns(T.nilable(String)) }
    def email; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The customer's individual name.
    sig { returns(T.nilable(String)) }
    def individual_name; end
    # The current multi-currency balances, if any, that's stored on the customer. If positive in a currency, the customer has a credit to apply to their next invoice denominated in that currency. If negative, the customer has an amount owed that's added to their next invoice denominated in that currency. These balances don't apply to unpaid invoices. They solely track amounts that Stripe hasn't successfully applied to any invoice. Stripe only applies a balance in a specific currency to an invoice after that invoice (which is in the same currency) finalizes.
    sig { returns(T.nilable(T::Hash[String, Integer])) }
    def invoice_credit_balance; end
    # The prefix for the customer used to generate unique invoice numbers.
    sig { returns(T.nilable(String)) }
    def invoice_prefix; end
    # Attribute for field invoice_settings
    sig { returns(T.nilable(InvoiceSettings)) }
    def invoice_settings; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # The customer's full name or business name.
    sig { returns(T.nilable(String)) }
    def name; end
    # The suffix of the customer's next invoice number (for example, 0001). When the account uses account level sequencing, this parameter is ignored in API requests and the field omitted in API responses.
    sig { returns(T.nilable(Integer)) }
    def next_invoice_sequence; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The customer's phone number.
    sig { returns(T.nilable(String)) }
    def phone; end
    # The customer's preferred locales (languages), ordered by preference.
    sig { returns(T.nilable(T::Array[String])) }
    def preferred_locales; end
    # Mailing and shipping address for the customer. Appears on invoices emailed to this customer.
    sig { returns(T.nilable(Shipping)) }
    def shipping; end
    # The customer's payment sources, if any.
    sig { returns(T.nilable(::Stripe::ListObject)) }
    def sources; end
    # The customer's current subscriptions, if any.
    sig { returns(T.nilable(::Stripe::ListObject)) }
    def subscriptions; end
    # Attribute for field tax
    sig { returns(T.nilable(Tax)) }
    def tax; end
    # Describes the customer's tax exemption status, which is `none`, `exempt`, or `reverse`. When set to `reverse`, invoice and receipt PDFs include the following text: **"Reverse charge"**.
    sig { returns(T.nilable(String)) }
    def tax_exempt; end
    # The customer's tax IDs.
    sig { returns(T.nilable(::Stripe::ListObject)) }
    def tax_ids; end
    # ID of the test clock that this customer belongs to.
    sig { returns(T.nilable(T.any(String, ::Stripe::TestHelpers::TestClock))) }
    def test_clock; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
    # Creates a new customer object.
    sig {
      params(params: T.any(::Stripe::CustomerCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Customer)
     }
    def self.create(params = {}, opts = {}); end

    # Retrieve funding instructions for a customer cash balance. If funding instructions do not yet exist for the customer, new
    # funding instructions will be created. If funding instructions have already been created for a given customer, the same
    # funding instructions will be retrieved. In other words, we will return the same funding instructions each time.
    sig {
      params(params: T.any(::Stripe::CustomerCreateFundingInstructionsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FundingInstructions)
     }
    def create_funding_instructions(params = {}, opts = {}); end

    # Retrieve funding instructions for a customer cash balance. If funding instructions do not yet exist for the customer, new
    # funding instructions will be created. If funding instructions have already been created for a given customer, the same
    # funding instructions will be retrieved. In other words, we will return the same funding instructions each time.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerCreateFundingInstructionsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FundingInstructions)
     }
    def self.create_funding_instructions(customer, params = {}, opts = {}); end

    # Permanently deletes a customer. It cannot be undone. Also immediately cancels any active subscriptions on the customer.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Customer)
     }
    def self.delete(customer, params = {}, opts = {}); end

    # Permanently deletes a customer. It cannot be undone. Also immediately cancels any active subscriptions on the customer.
    sig {
      params(params: T.any(::Stripe::CustomerDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Customer)
     }
    def delete(params = {}, opts = {}); end

    # Removes the currently applied discount on a customer.
    sig {
      params(params: T.any(::Stripe::CustomerDeleteDiscountParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Discount)
     }
    def delete_discount(params = {}, opts = {}); end

    # Removes the currently applied discount on a customer.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerDeleteDiscountParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Discount)
     }
    def self.delete_discount(customer, params = {}, opts = {}); end

    # Returns a list of your customers. The customers are returned sorted by creation date, with the most recent customers appearing first.
    sig {
      params(params: T.any(::Stripe::CustomerListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Returns a list of PaymentMethods for a given Customer
    sig {
      params(params: T.any(::Stripe::CustomerListPaymentMethodsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list_payment_methods(params = {}, opts = {}); end

    # Returns a list of PaymentMethods for a given Customer
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerListPaymentMethodsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list_payment_methods(customer, params = {}, opts = {}); end

    # Retrieves a customer's cash balance.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.untyped)
     }
    def self.retrieve_cash_balance(customer, params = {}, opts = {}); end

    # Retrieves a PaymentMethod object for a given Customer.
    sig {
      params(payment_method: String, params: T.any(::Stripe::CustomerRetrievePaymentMethodParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethod)
     }
    def retrieve_payment_method(payment_method, params = {}, opts = {}); end

    # Retrieves a PaymentMethod object for a given Customer.
    sig {
      params(customer: String, payment_method: String, params: T.any(::Stripe::CustomerRetrievePaymentMethodParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethod)
     }
    def self.retrieve_payment_method(customer, payment_method, params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::CustomerSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search(params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::CustomerSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped, blk: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search_auto_paging_each(params = {}, opts = {}, &blk); end

    # Updates the specified customer by setting the values of the parameters passed. Any parameters not provided will be left unchanged. For example, if you pass the source parameter, that becomes the customer's active source (e.g., a card) to be used for all charges in the future. When you update a customer to a new valid card source by passing the source parameter: for each of the customer's current subscriptions, if the subscription bills automatically and is in the past_due state, then the latest open invoice for the subscription with automatic collection enabled will be retried. This retry will not count as an automatic retry, and will not affect the next regularly scheduled payment for the invoice. Changing the default_source for a customer will not trigger this behavior.
    #
    # This request accepts mostly the same arguments as the customer creation call.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Customer)
     }
    def self.update(customer, params = {}, opts = {}); end

    # Changes the settings on a customer's cash balance.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.untyped)
     }
    def self.update_cash_balance(customer, params = {}, opts = {}); end
  end
end