# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerPaymentSourceUpdateParams < ::Stripe::RequestParams
    class Owner < ::Stripe::RequestParams
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
      # Owner's address.
      sig { returns(T.nilable(CustomerPaymentSourceUpdateParams::Owner::Address)) }
      def address; end
      sig {
        params(_address: T.nilable(CustomerPaymentSourceUpdateParams::Owner::Address)).returns(T.nilable(CustomerPaymentSourceUpdateParams::Owner::Address))
       }
      def address=(_address); end
      # Owner's email address.
      sig { returns(T.nilable(String)) }
      def email; end
      sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
      def email=(_email); end
      # Owner's full name.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # Owner's phone number.
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      sig {
        params(address: T.nilable(CustomerPaymentSourceUpdateParams::Owner::Address), email: T.nilable(String), name: T.nilable(String), phone: T.nilable(String)).void
       }
      def initialize(address: nil, email: nil, name: nil, phone: nil); end
    end
    # The name of the person or business that owns the bank account.
    sig { returns(T.nilable(String)) }
    def account_holder_name; end
    sig { params(_account_holder_name: T.nilable(String)).returns(T.nilable(String)) }
    def account_holder_name=(_account_holder_name); end
    # The type of entity that holds the account. This can be either `individual` or `company`.
    sig { returns(T.nilable(String)) }
    def account_holder_type; end
    sig { params(_account_holder_type: T.nilable(String)).returns(T.nilable(String)) }
    def account_holder_type=(_account_holder_type); end
    # City/District/Suburb/Town/Village.
    sig { returns(T.nilable(String)) }
    def address_city; end
    sig { params(_address_city: T.nilable(String)).returns(T.nilable(String)) }
    def address_city=(_address_city); end
    # Billing address country, if provided when creating card.
    sig { returns(T.nilable(String)) }
    def address_country; end
    sig { params(_address_country: T.nilable(String)).returns(T.nilable(String)) }
    def address_country=(_address_country); end
    # Address line 1 (Street address/PO Box/Company name).
    sig { returns(T.nilable(String)) }
    def address_line1; end
    sig { params(_address_line1: T.nilable(String)).returns(T.nilable(String)) }
    def address_line1=(_address_line1); end
    # Address line 2 (Apartment/Suite/Unit/Building).
    sig { returns(T.nilable(String)) }
    def address_line2; end
    sig { params(_address_line2: T.nilable(String)).returns(T.nilable(String)) }
    def address_line2=(_address_line2); end
    # State/County/Province/Region.
    sig { returns(T.nilable(String)) }
    def address_state; end
    sig { params(_address_state: T.nilable(String)).returns(T.nilable(String)) }
    def address_state=(_address_state); end
    # ZIP or postal code.
    sig { returns(T.nilable(String)) }
    def address_zip; end
    sig { params(_address_zip: T.nilable(String)).returns(T.nilable(String)) }
    def address_zip=(_address_zip); end
    # Two digit number representing the card’s expiration month.
    sig { returns(T.nilable(String)) }
    def exp_month; end
    sig { params(_exp_month: T.nilable(String)).returns(T.nilable(String)) }
    def exp_month=(_exp_month); end
    # Four digit number representing the card’s expiration year.
    sig { returns(T.nilable(String)) }
    def exp_year; end
    sig { params(_exp_year: T.nilable(String)).returns(T.nilable(String)) }
    def exp_year=(_exp_year); end
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
    # Cardholder name.
    sig { returns(T.nilable(String)) }
    def name; end
    sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
    def name=(_name); end
    # Attribute for param field owner
    sig { returns(T.nilable(CustomerPaymentSourceUpdateParams::Owner)) }
    def owner; end
    sig {
      params(_owner: T.nilable(CustomerPaymentSourceUpdateParams::Owner)).returns(T.nilable(CustomerPaymentSourceUpdateParams::Owner))
     }
    def owner=(_owner); end
    sig {
      params(account_holder_name: T.nilable(String), account_holder_type: T.nilable(String), address_city: T.nilable(String), address_country: T.nilable(String), address_line1: T.nilable(String), address_line2: T.nilable(String), address_state: T.nilable(String), address_zip: T.nilable(String), exp_month: T.nilable(String), exp_year: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), name: T.nilable(String), owner: T.nilable(CustomerPaymentSourceUpdateParams::Owner)).void
     }
    def initialize(
      account_holder_name: nil,
      account_holder_type: nil,
      address_city: nil,
      address_country: nil,
      address_line1: nil,
      address_line2: nil,
      address_state: nil,
      address_zip: nil,
      exp_month: nil,
      exp_year: nil,
      expand: nil,
      metadata: nil,
      name: nil,
      owner: nil
    ); end
  end
end