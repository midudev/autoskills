# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentRecordReportPaymentParams < ::Stripe::RequestParams
    class AmountRequested < ::Stripe::RequestParams
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      sig { params(_currency: String).returns(String) }
      def currency=(_currency); end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      sig { params(_value: Integer).returns(Integer) }
      def value=(_value); end
      sig { params(currency: String, value: Integer).void }
      def initialize(currency: nil, value: nil); end
    end
    class CustomerDetails < ::Stripe::RequestParams
      # The customer who made the payment.
      sig { returns(T.nilable(String)) }
      def customer; end
      sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
      def customer=(_customer); end
      # The customer's phone number.
      sig { returns(T.nilable(String)) }
      def email; end
      sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
      def email=(_email); end
      # The customer's name.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # The customer's phone number.
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      sig {
        params(customer: T.nilable(String), email: T.nilable(String), name: T.nilable(String), phone: T.nilable(String)).void
       }
      def initialize(customer: nil, email: nil, name: nil, phone: nil); end
    end
    class Failed < ::Stripe::RequestParams
      # When the reported payment failed. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def failed_at; end
      sig { params(_failed_at: Integer).returns(Integer) }
      def failed_at=(_failed_at); end
      sig { params(failed_at: Integer).void }
      def initialize(failed_at: nil); end
    end
    class Guaranteed < ::Stripe::RequestParams
      # When the reported payment was guaranteed. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def guaranteed_at; end
      sig { params(_guaranteed_at: Integer).returns(Integer) }
      def guaranteed_at=(_guaranteed_at); end
      sig { params(guaranteed_at: Integer).void }
      def initialize(guaranteed_at: nil); end
    end
    class PaymentMethodDetails < ::Stripe::RequestParams
      class BillingDetails < ::Stripe::RequestParams
        class Address < ::Stripe::RequestParams
          # City, district, suburb, town, or village.
          sig { returns(T.nilable(String)) }
          def city; end
          sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
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
        # The billing address associated with the method of payment.
        sig {
          returns(T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::BillingDetails::Address))
         }
        def address; end
        sig {
          params(_address: T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::BillingDetails::Address)).returns(T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::BillingDetails::Address))
         }
        def address=(_address); end
        # The billing email associated with the method of payment.
        sig { returns(T.nilable(String)) }
        def email; end
        sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
        def email=(_email); end
        # The billing name associated with the method of payment.
        sig { returns(T.nilable(String)) }
        def name; end
        sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
        def name=(_name); end
        # The billing phone number associated with the method of payment.
        sig { returns(T.nilable(String)) }
        def phone; end
        sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
        def phone=(_phone); end
        sig {
          params(address: T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::BillingDetails::Address), email: T.nilable(String), name: T.nilable(String), phone: T.nilable(String)).void
         }
        def initialize(address: nil, email: nil, name: nil, phone: nil); end
      end
      class Custom < ::Stripe::RequestParams
        # Display name for the custom (user-defined) payment method type used to make this payment.
        sig { returns(T.nilable(String)) }
        def display_name; end
        sig { params(_display_name: T.nilable(String)).returns(T.nilable(String)) }
        def display_name=(_display_name); end
        # The custom payment method type associated with this payment.
        sig { returns(T.nilable(String)) }
        def type; end
        sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
        def type=(_type); end
        sig { params(display_name: T.nilable(String), type: T.nilable(String)).void }
        def initialize(display_name: nil, type: nil); end
      end
      # The billing details associated with the method of payment.
      sig {
        returns(T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::BillingDetails))
       }
      def billing_details; end
      sig {
        params(_billing_details: T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::BillingDetails)).returns(T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::BillingDetails))
       }
      def billing_details=(_billing_details); end
      # Information about the custom (user-defined) payment method used to make this payment.
      sig { returns(T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::Custom)) }
      def custom; end
      sig {
        params(_custom: T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::Custom)).returns(T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::Custom))
       }
      def custom=(_custom); end
      # ID of the Stripe Payment Method used to make this payment.
      sig { returns(T.nilable(String)) }
      def payment_method; end
      sig { params(_payment_method: T.nilable(String)).returns(T.nilable(String)) }
      def payment_method=(_payment_method); end
      # The type of the payment method details. An additional hash is included on the payment_method_details with a name matching this value. It contains additional information specific to the type.
      sig { returns(T.nilable(String)) }
      def type; end
      sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
      def type=(_type); end
      sig {
        params(billing_details: T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::BillingDetails), custom: T.nilable(PaymentRecordReportPaymentParams::PaymentMethodDetails::Custom), payment_method: T.nilable(String), type: T.nilable(String)).void
       }
      def initialize(billing_details: nil, custom: nil, payment_method: nil, type: nil); end
    end
    class ProcessorDetails < ::Stripe::RequestParams
      class Custom < ::Stripe::RequestParams
        # An opaque string for manual reconciliation of this payment, for example a check number or a payment processor ID.
        sig { returns(String) }
        def payment_reference; end
        sig { params(_payment_reference: String).returns(String) }
        def payment_reference=(_payment_reference); end
        sig { params(payment_reference: String).void }
        def initialize(payment_reference: nil); end
      end
      # Information about the custom processor used to make this payment.
      sig { returns(T.nilable(PaymentRecordReportPaymentParams::ProcessorDetails::Custom)) }
      def custom; end
      sig {
        params(_custom: T.nilable(PaymentRecordReportPaymentParams::ProcessorDetails::Custom)).returns(T.nilable(PaymentRecordReportPaymentParams::ProcessorDetails::Custom))
       }
      def custom=(_custom); end
      # The type of the processor details. An additional hash is included on processor_details with a name matching this value. It contains additional information specific to the processor.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig {
        params(custom: T.nilable(PaymentRecordReportPaymentParams::ProcessorDetails::Custom), type: String).void
       }
      def initialize(custom: nil, type: nil); end
    end
    class ShippingDetails < ::Stripe::RequestParams
      class Address < ::Stripe::RequestParams
        # City, district, suburb, town, or village.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
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
      # The physical shipping address.
      sig { returns(T.nilable(PaymentRecordReportPaymentParams::ShippingDetails::Address)) }
      def address; end
      sig {
        params(_address: T.nilable(PaymentRecordReportPaymentParams::ShippingDetails::Address)).returns(T.nilable(PaymentRecordReportPaymentParams::ShippingDetails::Address))
       }
      def address=(_address); end
      # The shipping recipient's name.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # The shipping recipient's phone number.
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      sig {
        params(address: T.nilable(PaymentRecordReportPaymentParams::ShippingDetails::Address), name: T.nilable(String), phone: T.nilable(String)).void
       }
      def initialize(address: nil, name: nil, phone: nil); end
    end
    # The amount you initially requested for this payment.
    sig { returns(PaymentRecordReportPaymentParams::AmountRequested) }
    def amount_requested; end
    sig {
      params(_amount_requested: PaymentRecordReportPaymentParams::AmountRequested).returns(PaymentRecordReportPaymentParams::AmountRequested)
     }
    def amount_requested=(_amount_requested); end
    # Customer information for this payment.
    sig { returns(T.nilable(PaymentRecordReportPaymentParams::CustomerDetails)) }
    def customer_details; end
    sig {
      params(_customer_details: T.nilable(PaymentRecordReportPaymentParams::CustomerDetails)).returns(T.nilable(PaymentRecordReportPaymentParams::CustomerDetails))
     }
    def customer_details=(_customer_details); end
    # Indicates whether the customer was present in your checkout flow during this payment.
    sig { returns(T.nilable(String)) }
    def customer_presence; end
    sig { params(_customer_presence: T.nilable(String)).returns(T.nilable(String)) }
    def customer_presence=(_customer_presence); end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Information about the payment attempt failure.
    sig { returns(T.nilable(PaymentRecordReportPaymentParams::Failed)) }
    def failed; end
    sig {
      params(_failed: T.nilable(PaymentRecordReportPaymentParams::Failed)).returns(T.nilable(PaymentRecordReportPaymentParams::Failed))
     }
    def failed=(_failed); end
    # Information about the payment attempt guarantee.
    sig { returns(T.nilable(PaymentRecordReportPaymentParams::Guaranteed)) }
    def guaranteed; end
    sig {
      params(_guaranteed: T.nilable(PaymentRecordReportPaymentParams::Guaranteed)).returns(T.nilable(PaymentRecordReportPaymentParams::Guaranteed))
     }
    def guaranteed=(_guaranteed); end
    # When the reported payment was initiated. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def initiated_at; end
    sig { params(_initiated_at: Integer).returns(Integer) }
    def initiated_at=(_initiated_at); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # The outcome of the reported payment.
    sig { returns(T.nilable(String)) }
    def outcome; end
    sig { params(_outcome: T.nilable(String)).returns(T.nilable(String)) }
    def outcome=(_outcome); end
    # Information about the Payment Method debited for this payment.
    sig { returns(PaymentRecordReportPaymentParams::PaymentMethodDetails) }
    def payment_method_details; end
    sig {
      params(_payment_method_details: PaymentRecordReportPaymentParams::PaymentMethodDetails).returns(PaymentRecordReportPaymentParams::PaymentMethodDetails)
     }
    def payment_method_details=(_payment_method_details); end
    # Processor information for this payment.
    sig { returns(T.nilable(PaymentRecordReportPaymentParams::ProcessorDetails)) }
    def processor_details; end
    sig {
      params(_processor_details: T.nilable(PaymentRecordReportPaymentParams::ProcessorDetails)).returns(T.nilable(PaymentRecordReportPaymentParams::ProcessorDetails))
     }
    def processor_details=(_processor_details); end
    # Shipping information for this payment.
    sig { returns(T.nilable(PaymentRecordReportPaymentParams::ShippingDetails)) }
    def shipping_details; end
    sig {
      params(_shipping_details: T.nilable(PaymentRecordReportPaymentParams::ShippingDetails)).returns(T.nilable(PaymentRecordReportPaymentParams::ShippingDetails))
     }
    def shipping_details=(_shipping_details); end
    sig {
      params(amount_requested: PaymentRecordReportPaymentParams::AmountRequested, customer_details: T.nilable(PaymentRecordReportPaymentParams::CustomerDetails), customer_presence: T.nilable(String), description: T.nilable(String), expand: T.nilable(T::Array[String]), failed: T.nilable(PaymentRecordReportPaymentParams::Failed), guaranteed: T.nilable(PaymentRecordReportPaymentParams::Guaranteed), initiated_at: Integer, metadata: T.nilable(T.any(String, T::Hash[String, String])), outcome: T.nilable(String), payment_method_details: PaymentRecordReportPaymentParams::PaymentMethodDetails, processor_details: T.nilable(PaymentRecordReportPaymentParams::ProcessorDetails), shipping_details: T.nilable(PaymentRecordReportPaymentParams::ShippingDetails)).void
     }
    def initialize(
      amount_requested: nil,
      customer_details: nil,
      customer_presence: nil,
      description: nil,
      expand: nil,
      failed: nil,
      guaranteed: nil,
      initiated_at: nil,
      metadata: nil,
      outcome: nil,
      payment_method_details: nil,
      processor_details: nil,
      shipping_details: nil
    ); end
  end
end