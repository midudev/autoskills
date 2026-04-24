# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentRecordReportPaymentAttemptInformationalParams < ::Stripe::RequestParams
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
      sig {
        returns(T.nilable(PaymentRecordReportPaymentAttemptInformationalParams::ShippingDetails::Address))
       }
      def address; end
      sig {
        params(_address: T.nilable(PaymentRecordReportPaymentAttemptInformationalParams::ShippingDetails::Address)).returns(T.nilable(PaymentRecordReportPaymentAttemptInformationalParams::ShippingDetails::Address))
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
        params(address: T.nilable(PaymentRecordReportPaymentAttemptInformationalParams::ShippingDetails::Address), name: T.nilable(String), phone: T.nilable(String)).void
       }
      def initialize(address: nil, name: nil, phone: nil); end
    end
    # Customer information for this payment.
    sig {
      returns(T.nilable(PaymentRecordReportPaymentAttemptInformationalParams::CustomerDetails))
     }
    def customer_details; end
    sig {
      params(_customer_details: T.nilable(PaymentRecordReportPaymentAttemptInformationalParams::CustomerDetails)).returns(T.nilable(PaymentRecordReportPaymentAttemptInformationalParams::CustomerDetails))
     }
    def customer_details=(_customer_details); end
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
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # Shipping information for this payment.
    sig {
      returns(T.nilable(T.any(String, PaymentRecordReportPaymentAttemptInformationalParams::ShippingDetails)))
     }
    def shipping_details; end
    sig {
      params(_shipping_details: T.nilable(T.any(String, PaymentRecordReportPaymentAttemptInformationalParams::ShippingDetails))).returns(T.nilable(T.any(String, PaymentRecordReportPaymentAttemptInformationalParams::ShippingDetails)))
     }
    def shipping_details=(_shipping_details); end
    sig {
      params(customer_details: T.nilable(PaymentRecordReportPaymentAttemptInformationalParams::CustomerDetails), description: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), shipping_details: T.nilable(T.any(String, PaymentRecordReportPaymentAttemptInformationalParams::ShippingDetails))).void
     }
    def initialize(
      customer_details: nil,
      description: nil,
      expand: nil,
      metadata: nil,
      shipping_details: nil
    ); end
  end
end