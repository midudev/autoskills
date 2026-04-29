# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerUpdateParams < ::Stripe::RequestParams
    class Address < ::Stripe::RequestParams
      # City, district, suburb, town, or village.
      sig { returns(T.nilable(String)) }
      def city; end
      sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
      def city=(_city); end
      # A freeform text field for the country. However, in order to activate some tax features, the format should be a two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
      sig { returns(T.nilable(String)) }
      def country; end
      sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
      def country=(_country); end
      # Address line 1, such as the street, PO Box, or company name.
      sig { returns(T.nilable(String)) }
      def line1; end
      sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
      def line1=(_line1); end
      # Address line 2, such as the apartment, suite, unit, or building.
      sig { returns(T.nilable(String)) }
      def line2; end
      sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
      def line2=(_line2); end
      # ZIP or postal code.
      sig { returns(T.nilable(String)) }
      def postal_code; end
      sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
      def postal_code=(_postal_code); end
      # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
      sig { returns(T.nilable(String)) }
      def state; end
      sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
      def state=(_state); end
      sig {
        params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
       }
      def initialize(
        city: nil,
        country: nil,
        line1: nil,
        line2: nil,
        postal_code: nil,
        state: nil
      ); end
    end
    class CashBalance < ::Stripe::RequestParams
      class Settings < ::Stripe::RequestParams
        # Controls how funds transferred by the customer are applied to payment intents and invoices. Valid options are `automatic`, `manual`, or `merchant_default`. For more information about these reconciliation modes, see [Reconciliation](https://docs.stripe.com/payments/customer-balance/reconciliation).
        sig { returns(T.nilable(String)) }
        def reconciliation_mode; end
        sig { params(_reconciliation_mode: T.nilable(String)).returns(T.nilable(String)) }
        def reconciliation_mode=(_reconciliation_mode); end
        sig { params(reconciliation_mode: T.nilable(String)).void }
        def initialize(reconciliation_mode: nil); end
      end
      # Settings controlling the behavior of the customer's cash balance,
      # such as reconciliation of funds received.
      sig { returns(T.nilable(CustomerUpdateParams::CashBalance::Settings)) }
      def settings; end
      sig {
        params(_settings: T.nilable(CustomerUpdateParams::CashBalance::Settings)).returns(T.nilable(CustomerUpdateParams::CashBalance::Settings))
       }
      def settings=(_settings); end
      sig { params(settings: T.nilable(CustomerUpdateParams::CashBalance::Settings)).void }
      def initialize(settings: nil); end
    end
    class InvoiceSettings < ::Stripe::RequestParams
      class CustomField < ::Stripe::RequestParams
        # The name of the custom field. This may be up to 40 characters.
        sig { returns(String) }
        def name; end
        sig { params(_name: String).returns(String) }
        def name=(_name); end
        # The value of the custom field. This may be up to 140 characters.
        sig { returns(String) }
        def value; end
        sig { params(_value: String).returns(String) }
        def value=(_value); end
        sig { params(name: String, value: String).void }
        def initialize(name: nil, value: nil); end
      end
      class RenderingOptions < ::Stripe::RequestParams
        # How line-item prices and amounts will be displayed with respect to tax on invoice PDFs. One of `exclude_tax` or `include_inclusive_tax`. `include_inclusive_tax` will include inclusive tax (and exclude exclusive tax) in invoice PDF amounts. `exclude_tax` will exclude all tax (inclusive and exclusive alike) from invoice PDF amounts.
        sig { returns(T.nilable(T.any(String, String))) }
        def amount_tax_display; end
        sig {
          params(_amount_tax_display: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def amount_tax_display=(_amount_tax_display); end
        # ID of the invoice rendering template to use for future invoices.
        sig { returns(T.nilable(String)) }
        def template; end
        sig { params(_template: T.nilable(String)).returns(T.nilable(String)) }
        def template=(_template); end
        sig {
          params(amount_tax_display: T.nilable(T.any(String, String)), template: T.nilable(String)).void
         }
        def initialize(amount_tax_display: nil, template: nil); end
      end
      # The list of up to 4 default custom fields to be displayed on invoices for this customer. When updating, pass an empty string to remove previously-defined fields.
      sig {
        returns(T.nilable(T.any(String, T::Array[CustomerUpdateParams::InvoiceSettings::CustomField])))
       }
      def custom_fields; end
      sig {
        params(_custom_fields: T.nilable(T.any(String, T::Array[CustomerUpdateParams::InvoiceSettings::CustomField]))).returns(T.nilable(T.any(String, T::Array[CustomerUpdateParams::InvoiceSettings::CustomField])))
       }
      def custom_fields=(_custom_fields); end
      # ID of a payment method that's attached to the customer, to be used as the customer's default payment method for subscriptions and invoices.
      sig { returns(T.nilable(String)) }
      def default_payment_method; end
      sig { params(_default_payment_method: T.nilable(String)).returns(T.nilable(String)) }
      def default_payment_method=(_default_payment_method); end
      # Default footer to be displayed on invoices for this customer.
      sig { returns(T.nilable(String)) }
      def footer; end
      sig { params(_footer: T.nilable(String)).returns(T.nilable(String)) }
      def footer=(_footer); end
      # Default options for invoice PDF rendering for this customer.
      sig {
        returns(T.nilable(T.any(String, CustomerUpdateParams::InvoiceSettings::RenderingOptions)))
       }
      def rendering_options; end
      sig {
        params(_rendering_options: T.nilable(T.any(String, CustomerUpdateParams::InvoiceSettings::RenderingOptions))).returns(T.nilable(T.any(String, CustomerUpdateParams::InvoiceSettings::RenderingOptions)))
       }
      def rendering_options=(_rendering_options); end
      sig {
        params(custom_fields: T.nilable(T.any(String, T::Array[CustomerUpdateParams::InvoiceSettings::CustomField])), default_payment_method: T.nilable(String), footer: T.nilable(String), rendering_options: T.nilable(T.any(String, CustomerUpdateParams::InvoiceSettings::RenderingOptions))).void
       }
      def initialize(
        custom_fields: nil,
        default_payment_method: nil,
        footer: nil,
        rendering_options: nil
      ); end
    end
    class Shipping < ::Stripe::RequestParams
      class Address < ::Stripe::RequestParams
        # City, district, suburb, town, or village.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # A freeform text field for the country. However, in order to activate some tax features, the format should be a two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
        def country=(_country); end
        # Address line 1, such as the street, PO Box, or company name.
        sig { returns(T.nilable(String)) }
        def line1; end
        sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
        def line1=(_line1); end
        # Address line 2, such as the apartment, suite, unit, or building.
        sig { returns(T.nilable(String)) }
        def line2; end
        sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
        def line2=(_line2); end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def postal_code=(_postal_code); end
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        sig {
          params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
         }
        def initialize(
          city: nil,
          country: nil,
          line1: nil,
          line2: nil,
          postal_code: nil,
          state: nil
        ); end
      end
      # Customer shipping address.
      sig { returns(CustomerUpdateParams::Shipping::Address) }
      def address; end
      sig {
        params(_address: CustomerUpdateParams::Shipping::Address).returns(CustomerUpdateParams::Shipping::Address)
       }
      def address=(_address); end
      # Customer name.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # Customer phone (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      sig {
        params(address: CustomerUpdateParams::Shipping::Address, name: String, phone: T.nilable(String)).void
       }
      def initialize(address: nil, name: nil, phone: nil); end
    end
    class Tax < ::Stripe::RequestParams
      # A recent IP address of the customer used for tax reporting and tax location inference. Stripe recommends updating the IP address when a new PaymentMethod is attached or the address field on the customer is updated. We recommend against updating this field more frequently since it could result in unexpected tax location/reporting outcomes.
      sig { returns(T.nilable(String)) }
      def ip_address; end
      sig { params(_ip_address: T.nilable(String)).returns(T.nilable(String)) }
      def ip_address=(_ip_address); end
      # A flag that indicates when Stripe should validate the customer tax location. Defaults to `auto`.
      sig { returns(T.nilable(String)) }
      def validate_location; end
      sig { params(_validate_location: T.nilable(String)).returns(T.nilable(String)) }
      def validate_location=(_validate_location); end
      sig { params(ip_address: T.nilable(String), validate_location: T.nilable(String)).void }
      def initialize(ip_address: nil, validate_location: nil); end
    end
    # The customer's address. Learn about [country-specific requirements for calculating tax](https://docs.stripe.com/invoicing/taxes?dashboard-or-api=dashboard#set-up-customer).
    sig { returns(T.nilable(T.any(String, CustomerUpdateParams::Address))) }
    def address; end
    sig {
      params(_address: T.nilable(T.any(String, CustomerUpdateParams::Address))).returns(T.nilable(T.any(String, CustomerUpdateParams::Address)))
     }
    def address=(_address); end
    # An integer amount in cents (or local equivalent) that represents the customer's current balance, which affect the customer's future invoices. A negative amount represents a credit that decreases the amount due on an invoice; a positive amount increases the amount due on an invoice.
    sig { returns(T.nilable(Integer)) }
    def balance; end
    sig { params(_balance: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def balance=(_balance); end
    # The customer's business name. This may be up to *150 characters*.
    sig { returns(T.nilable(String)) }
    def business_name; end
    sig { params(_business_name: T.nilable(String)).returns(T.nilable(String)) }
    def business_name=(_business_name); end
    # Balance information and default balance settings for this customer.
    sig { returns(T.nilable(CustomerUpdateParams::CashBalance)) }
    def cash_balance; end
    sig {
      params(_cash_balance: T.nilable(CustomerUpdateParams::CashBalance)).returns(T.nilable(CustomerUpdateParams::CashBalance))
     }
    def cash_balance=(_cash_balance); end
    # If you are using payment methods created via the PaymentMethods API, see the [invoice_settings.default_payment_method](https://docs.stripe.com/api/customers/update#update_customer-invoice_settings-default_payment_method) parameter.
    #
    # Provide the ID of a payment source already attached to this customer to make it this customer's default payment source.
    #
    # If you want to add a new payment source and make it the default, see the [source](https://docs.stripe.com/api/customers/update#update_customer-source) property.
    sig { returns(T.nilable(String)) }
    def default_source; end
    sig { params(_default_source: T.nilable(String)).returns(T.nilable(String)) }
    def default_source=(_default_source); end
    # An arbitrary string that you can attach to a customer object. It is displayed alongside the customer in the dashboard.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # Customer's email address. It's displayed alongside the customer in your dashboard and can be useful for searching and tracking. This may be up to *512 characters*.
    sig { returns(T.nilable(String)) }
    def email; end
    sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
    def email=(_email); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # The customer's full name. This may be up to *150 characters*.
    sig { returns(T.nilable(String)) }
    def individual_name; end
    sig { params(_individual_name: T.nilable(String)).returns(T.nilable(String)) }
    def individual_name=(_individual_name); end
    # The prefix for the customer used to generate unique invoice numbers. Must be 3–12 uppercase letters or numbers.
    sig { returns(T.nilable(String)) }
    def invoice_prefix; end
    sig { params(_invoice_prefix: T.nilable(String)).returns(T.nilable(String)) }
    def invoice_prefix=(_invoice_prefix); end
    # Default invoice settings for this customer.
    sig { returns(T.nilable(CustomerUpdateParams::InvoiceSettings)) }
    def invoice_settings; end
    sig {
      params(_invoice_settings: T.nilable(CustomerUpdateParams::InvoiceSettings)).returns(T.nilable(CustomerUpdateParams::InvoiceSettings))
     }
    def invoice_settings=(_invoice_settings); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # The customer's full name or business name.
    sig { returns(T.nilable(String)) }
    def name; end
    sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
    def name=(_name); end
    # The sequence to be used on the customer's next invoice. Defaults to 1.
    sig { returns(T.nilable(Integer)) }
    def next_invoice_sequence; end
    sig { params(_next_invoice_sequence: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def next_invoice_sequence=(_next_invoice_sequence); end
    # The customer's phone number.
    sig { returns(T.nilable(String)) }
    def phone; end
    sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
    def phone=(_phone); end
    # Customer's preferred languages, ordered by preference.
    sig { returns(T.nilable(T::Array[String])) }
    def preferred_locales; end
    sig {
      params(_preferred_locales: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
     }
    def preferred_locales=(_preferred_locales); end
    # The customer's shipping information. Appears on invoices emailed to this customer.
    sig { returns(T.nilable(T.any(String, CustomerUpdateParams::Shipping))) }
    def shipping; end
    sig {
      params(_shipping: T.nilable(T.any(String, CustomerUpdateParams::Shipping))).returns(T.nilable(T.any(String, CustomerUpdateParams::Shipping)))
     }
    def shipping=(_shipping); end
    # Attribute for param field source
    sig { returns(T.nilable(String)) }
    def source; end
    sig { params(_source: T.nilable(String)).returns(T.nilable(String)) }
    def source=(_source); end
    # Tax details about the customer.
    sig { returns(T.nilable(CustomerUpdateParams::Tax)) }
    def tax; end
    sig {
      params(_tax: T.nilable(CustomerUpdateParams::Tax)).returns(T.nilable(CustomerUpdateParams::Tax))
     }
    def tax=(_tax); end
    # The customer's tax exemption. One of `none`, `exempt`, or `reverse`.
    sig { returns(T.nilable(T.any(String, String))) }
    def tax_exempt; end
    sig {
      params(_tax_exempt: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
     }
    def tax_exempt=(_tax_exempt); end
    # Attribute for param field validate
    sig { returns(T.nilable(T::Boolean)) }
    def validate; end
    sig { params(_validate: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def validate=(_validate); end
    sig {
      params(address: T.nilable(T.any(String, CustomerUpdateParams::Address)), balance: T.nilable(Integer), business_name: T.nilable(String), cash_balance: T.nilable(CustomerUpdateParams::CashBalance), default_source: T.nilable(String), description: T.nilable(String), email: T.nilable(String), expand: T.nilable(T::Array[String]), individual_name: T.nilable(String), invoice_prefix: T.nilable(String), invoice_settings: T.nilable(CustomerUpdateParams::InvoiceSettings), metadata: T.nilable(T.any(String, T::Hash[String, String])), name: T.nilable(String), next_invoice_sequence: T.nilable(Integer), phone: T.nilable(String), preferred_locales: T.nilable(T::Array[String]), shipping: T.nilable(T.any(String, CustomerUpdateParams::Shipping)), source: T.nilable(String), tax: T.nilable(CustomerUpdateParams::Tax), tax_exempt: T.nilable(T.any(String, String)), validate: T.nilable(T::Boolean)).void
     }
    def initialize(
      address: nil,
      balance: nil,
      business_name: nil,
      cash_balance: nil,
      default_source: nil,
      description: nil,
      email: nil,
      expand: nil,
      individual_name: nil,
      invoice_prefix: nil,
      invoice_settings: nil,
      metadata: nil,
      name: nil,
      next_invoice_sequence: nil,
      phone: nil,
      preferred_locales: nil,
      shipping: nil,
      source: nil,
      tax: nil,
      tax_exempt: nil,
      validate: nil
    ); end
  end
end