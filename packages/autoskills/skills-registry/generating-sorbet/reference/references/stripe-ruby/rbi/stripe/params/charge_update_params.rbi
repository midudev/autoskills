# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ChargeUpdateParams < ::Stripe::RequestParams
    class FraudDetails < ::Stripe::RequestParams
      # Either `safe` or `fraudulent`.
      sig { returns(T.any(String, String)) }
      def user_report; end
      sig { params(_user_report: T.any(String, String)).returns(T.any(String, String)) }
      def user_report=(_user_report); end
      sig { params(user_report: T.any(String, String)).void }
      def initialize(user_report: nil); end
    end
    class Shipping < ::Stripe::RequestParams
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
      # Shipping address.
      sig { returns(ChargeUpdateParams::Shipping::Address) }
      def address; end
      sig {
        params(_address: ChargeUpdateParams::Shipping::Address).returns(ChargeUpdateParams::Shipping::Address)
       }
      def address=(_address); end
      # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
      sig { returns(T.nilable(String)) }
      def carrier; end
      sig { params(_carrier: T.nilable(String)).returns(T.nilable(String)) }
      def carrier=(_carrier); end
      # Recipient name.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # Recipient phone (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
      sig { returns(T.nilable(String)) }
      def tracking_number; end
      sig { params(_tracking_number: T.nilable(String)).returns(T.nilable(String)) }
      def tracking_number=(_tracking_number); end
      sig {
        params(address: ChargeUpdateParams::Shipping::Address, carrier: T.nilable(String), name: String, phone: T.nilable(String), tracking_number: T.nilable(String)).void
       }
      def initialize(address: nil, carrier: nil, name: nil, phone: nil, tracking_number: nil); end
    end
    # The ID of an existing customer that will be associated with this request. This field may only be updated if there is no existing associated customer with this charge.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # An arbitrary string which you can attach to a charge object. It is displayed when in the web interface alongside the charge. Note that if you use Stripe to send automatic email receipts to your customers, your receipt emails will include the `description` of the charge(s) that they are describing.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # A set of key-value pairs you can attach to a charge giving information about its riskiness. If you believe a charge is fraudulent, include a `user_report` key with a value of `fraudulent`. If you believe a charge is safe, include a `user_report` key with a value of `safe`. Stripe will use the information you send to improve our fraud detection algorithms.
    sig { returns(T.nilable(ChargeUpdateParams::FraudDetails)) }
    def fraud_details; end
    sig {
      params(_fraud_details: T.nilable(ChargeUpdateParams::FraudDetails)).returns(T.nilable(ChargeUpdateParams::FraudDetails))
     }
    def fraud_details=(_fraud_details); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # This is the email address that the receipt for this charge will be sent to. If this field is updated, then a new email receipt will be sent to the updated address.
    sig { returns(T.nilable(String)) }
    def receipt_email; end
    sig { params(_receipt_email: T.nilable(String)).returns(T.nilable(String)) }
    def receipt_email=(_receipt_email); end
    # Shipping information for the charge. Helps prevent fraud on charges for physical goods.
    sig { returns(T.nilable(ChargeUpdateParams::Shipping)) }
    def shipping; end
    sig {
      params(_shipping: T.nilable(ChargeUpdateParams::Shipping)).returns(T.nilable(ChargeUpdateParams::Shipping))
     }
    def shipping=(_shipping); end
    # A string that identifies this transaction as part of a group. `transfer_group` may only be provided if it has not been set. See the [Connect documentation](https://docs.stripe.com/connect/separate-charges-and-transfers#transfer-options) for details.
    sig { returns(T.nilable(String)) }
    def transfer_group; end
    sig { params(_transfer_group: T.nilable(String)).returns(T.nilable(String)) }
    def transfer_group=(_transfer_group); end
    sig {
      params(customer: T.nilable(String), description: T.nilable(String), expand: T.nilable(T::Array[String]), fraud_details: T.nilable(ChargeUpdateParams::FraudDetails), metadata: T.nilable(T.any(String, T::Hash[String, String])), receipt_email: T.nilable(String), shipping: T.nilable(ChargeUpdateParams::Shipping), transfer_group: T.nilable(String)).void
     }
    def initialize(
      customer: nil,
      description: nil,
      expand: nil,
      fraud_details: nil,
      metadata: nil,
      receipt_email: nil,
      shipping: nil,
      transfer_group: nil
    ); end
  end
end