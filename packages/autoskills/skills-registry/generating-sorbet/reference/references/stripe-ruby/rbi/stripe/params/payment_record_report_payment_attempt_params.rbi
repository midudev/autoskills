# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentRecordReportPaymentAttemptParams < ::Stripe::RequestParams
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
          returns(T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::BillingDetails::Address))
         }
        def address; end
        sig {
          params(_address: T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::BillingDetails::Address)).returns(T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::BillingDetails::Address))
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
          params(address: T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::BillingDetails::Address), email: T.nilable(String), name: T.nilable(String), phone: T.nilable(String)).void
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
        returns(T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::BillingDetails))
       }
      def billing_details; end
      sig {
        params(_billing_details: T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::BillingDetails)).returns(T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::BillingDetails))
       }
      def billing_details=(_billing_details); end
      # Information about the custom (user-defined) payment method used to make this payment.
      sig {
        returns(T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::Custom))
       }
      def custom; end
      sig {
        params(_custom: T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::Custom)).returns(T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::Custom))
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
        params(billing_details: T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::BillingDetails), custom: T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails::Custom), payment_method: T.nilable(String), type: T.nilable(String)).void
       }
      def initialize(billing_details: nil, custom: nil, payment_method: nil, type: nil); end
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
      sig { returns(T.nilable(PaymentRecordReportPaymentAttemptParams::ShippingDetails::Address)) }
      def address; end
      sig {
        params(_address: T.nilable(PaymentRecordReportPaymentAttemptParams::ShippingDetails::Address)).returns(T.nilable(PaymentRecordReportPaymentAttemptParams::ShippingDetails::Address))
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
        params(address: T.nilable(PaymentRecordReportPaymentAttemptParams::ShippingDetails::Address), name: T.nilable(String), phone: T.nilable(String)).void
       }
      def initialize(address: nil, name: nil, phone: nil); end
    end
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
    sig { returns(T.nilable(PaymentRecordReportPaymentAttemptParams::Failed)) }
    def failed; end
    sig {
      params(_failed: T.nilable(PaymentRecordReportPaymentAttemptParams::Failed)).returns(T.nilable(PaymentRecordReportPaymentAttemptParams::Failed))
     }
    def failed=(_failed); end
    # Information about the payment attempt guarantee.
    sig { returns(T.nilable(PaymentRecordReportPaymentAttemptParams::Guaranteed)) }
    def guaranteed; end
    sig {
      params(_guaranteed: T.nilable(PaymentRecordReportPaymentAttemptParams::Guaranteed)).returns(T.nilable(PaymentRecordReportPaymentAttemptParams::Guaranteed))
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
    sig { returns(T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails)) }
    def payment_method_details; end
    sig {
      params(_payment_method_details: T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails)).returns(T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails))
     }
    def payment_method_details=(_payment_method_details); end
    # Shipping information for this payment.
    sig { returns(T.nilable(PaymentRecordReportPaymentAttemptParams::ShippingDetails)) }
    def shipping_details; end
    sig {
      params(_shipping_details: T.nilable(PaymentRecordReportPaymentAttemptParams::ShippingDetails)).returns(T.nilable(PaymentRecordReportPaymentAttemptParams::ShippingDetails))
     }
    def shipping_details=(_shipping_details); end
    sig {
      params(description: T.nilable(String), expand: T.nilable(T::Array[String]), failed: T.nilable(PaymentRecordReportPaymentAttemptParams::Failed), guaranteed: T.nilable(PaymentRecordReportPaymentAttemptParams::Guaranteed), initiated_at: Integer, metadata: T.nilable(T.any(String, T::Hash[String, String])), outcome: T.nilable(String), payment_method_details: T.nilable(PaymentRecordReportPaymentAttemptParams::PaymentMethodDetails), shipping_details: T.nilable(PaymentRecordReportPaymentAttemptParams::ShippingDetails)).void
     }
    def initialize(
      description: nil,
      expand: nil,
      failed: nil,
      guaranteed: nil,
      initiated_at: nil,
      metadata: nil,
      outcome: nil,
      payment_method_details: nil,
      shipping_details: nil
    ); end
  end
end