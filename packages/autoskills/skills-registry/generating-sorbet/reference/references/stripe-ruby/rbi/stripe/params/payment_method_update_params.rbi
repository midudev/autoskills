# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentMethodUpdateParams < ::Stripe::RequestParams
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
      # Billing address.
      sig { returns(T.nilable(T.any(String, PaymentMethodUpdateParams::BillingDetails::Address))) }
      def address; end
      sig {
        params(_address: T.nilable(T.any(String, PaymentMethodUpdateParams::BillingDetails::Address))).returns(T.nilable(T.any(String, PaymentMethodUpdateParams::BillingDetails::Address)))
       }
      def address=(_address); end
      # Email address.
      sig { returns(T.nilable(String)) }
      def email; end
      sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
      def email=(_email); end
      # Full name.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # Billing phone number (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      # Taxpayer identification number. Used only for transactions between LATAM buyers and non-LATAM sellers.
      sig { returns(T.nilable(String)) }
      def tax_id; end
      sig { params(_tax_id: T.nilable(String)).returns(T.nilable(String)) }
      def tax_id=(_tax_id); end
      sig {
        params(address: T.nilable(T.any(String, PaymentMethodUpdateParams::BillingDetails::Address)), email: T.nilable(String), name: T.nilable(String), phone: T.nilable(String), tax_id: T.nilable(String)).void
       }
      def initialize(address: nil, email: nil, name: nil, phone: nil, tax_id: nil); end
    end
    class Card < ::Stripe::RequestParams
      class Networks < ::Stripe::RequestParams
        # The customer's preferred card network for co-branded cards. Supports `cartes_bancaires`, `mastercard`, or `visa`. Selection of a network that does not apply to the card will be stored as `invalid_preference` on the card.
        sig { returns(T.nilable(T.any(String, String))) }
        def preferred; end
        sig {
          params(_preferred: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
         }
        def preferred=(_preferred); end
        sig { params(preferred: T.nilable(T.any(String, String))).void }
        def initialize(preferred: nil); end
      end
      # Two-digit number representing the card's expiration month.
      sig { returns(T.nilable(Integer)) }
      def exp_month; end
      sig { params(_exp_month: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def exp_month=(_exp_month); end
      # Four-digit number representing the card's expiration year.
      sig { returns(T.nilable(Integer)) }
      def exp_year; end
      sig { params(_exp_year: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def exp_year=(_exp_year); end
      # Contains information about card networks used to process the payment.
      sig { returns(T.nilable(PaymentMethodUpdateParams::Card::Networks)) }
      def networks; end
      sig {
        params(_networks: T.nilable(PaymentMethodUpdateParams::Card::Networks)).returns(T.nilable(PaymentMethodUpdateParams::Card::Networks))
       }
      def networks=(_networks); end
      sig {
        params(exp_month: T.nilable(Integer), exp_year: T.nilable(Integer), networks: T.nilable(PaymentMethodUpdateParams::Card::Networks)).void
       }
      def initialize(exp_month: nil, exp_year: nil, networks: nil); end
    end
    class Payto < ::Stripe::RequestParams
      # The account number for the bank account.
      sig { returns(T.nilable(String)) }
      def account_number; end
      sig { params(_account_number: T.nilable(String)).returns(T.nilable(String)) }
      def account_number=(_account_number); end
      # Bank-State-Branch number of the bank account.
      sig { returns(T.nilable(String)) }
      def bsb_number; end
      sig { params(_bsb_number: T.nilable(String)).returns(T.nilable(String)) }
      def bsb_number=(_bsb_number); end
      # The PayID alias for the bank account.
      sig { returns(T.nilable(String)) }
      def pay_id; end
      sig { params(_pay_id: T.nilable(String)).returns(T.nilable(String)) }
      def pay_id=(_pay_id); end
      sig {
        params(account_number: T.nilable(String), bsb_number: T.nilable(String), pay_id: T.nilable(String)).void
       }
      def initialize(account_number: nil, bsb_number: nil, pay_id: nil); end
    end
    class UsBankAccount < ::Stripe::RequestParams
      # Bank account holder type.
      sig { returns(T.nilable(String)) }
      def account_holder_type; end
      sig { params(_account_holder_type: T.nilable(String)).returns(T.nilable(String)) }
      def account_holder_type=(_account_holder_type); end
      # Bank account type.
      sig { returns(T.nilable(String)) }
      def account_type; end
      sig { params(_account_type: T.nilable(String)).returns(T.nilable(String)) }
      def account_type=(_account_type); end
      sig { params(account_holder_type: T.nilable(String), account_type: T.nilable(String)).void }
      def initialize(account_holder_type: nil, account_type: nil); end
    end
    # This field indicates whether this payment method can be shown again to its customer in a checkout flow. Stripe products such as Checkout and Elements use this field to determine whether a payment method can be shown as a saved payment method in a checkout flow. The field defaults to `unspecified`.
    sig { returns(T.nilable(String)) }
    def allow_redisplay; end
    sig { params(_allow_redisplay: T.nilable(String)).returns(T.nilable(String)) }
    def allow_redisplay=(_allow_redisplay); end
    # Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
    sig { returns(T.nilable(PaymentMethodUpdateParams::BillingDetails)) }
    def billing_details; end
    sig {
      params(_billing_details: T.nilable(PaymentMethodUpdateParams::BillingDetails)).returns(T.nilable(PaymentMethodUpdateParams::BillingDetails))
     }
    def billing_details=(_billing_details); end
    # If this is a `card` PaymentMethod, this hash contains the user's card details.
    sig { returns(T.nilable(PaymentMethodUpdateParams::Card)) }
    def card; end
    sig {
      params(_card: T.nilable(PaymentMethodUpdateParams::Card)).returns(T.nilable(PaymentMethodUpdateParams::Card))
     }
    def card=(_card); end
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
    # If this is a `payto` PaymentMethod, this hash contains details about the PayTo payment method.
    sig { returns(T.nilable(PaymentMethodUpdateParams::Payto)) }
    def payto; end
    sig {
      params(_payto: T.nilable(PaymentMethodUpdateParams::Payto)).returns(T.nilable(PaymentMethodUpdateParams::Payto))
     }
    def payto=(_payto); end
    # If this is an `us_bank_account` PaymentMethod, this hash contains details about the US bank account payment method.
    sig { returns(T.nilable(PaymentMethodUpdateParams::UsBankAccount)) }
    def us_bank_account; end
    sig {
      params(_us_bank_account: T.nilable(PaymentMethodUpdateParams::UsBankAccount)).returns(T.nilable(PaymentMethodUpdateParams::UsBankAccount))
     }
    def us_bank_account=(_us_bank_account); end
    sig {
      params(allow_redisplay: T.nilable(String), billing_details: T.nilable(PaymentMethodUpdateParams::BillingDetails), card: T.nilable(PaymentMethodUpdateParams::Card), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), payto: T.nilable(PaymentMethodUpdateParams::Payto), us_bank_account: T.nilable(PaymentMethodUpdateParams::UsBankAccount)).void
     }
    def initialize(
      allow_redisplay: nil,
      billing_details: nil,
      card: nil,
      expand: nil,
      metadata: nil,
      payto: nil,
      us_bank_account: nil
    ); end
  end
end