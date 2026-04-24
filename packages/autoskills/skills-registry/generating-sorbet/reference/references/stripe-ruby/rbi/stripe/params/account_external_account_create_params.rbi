# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountExternalAccountCreateParams < ::Stripe::RequestParams
    class BankAccount < ::Stripe::RequestParams
      # Attribute for param field object
      sig { returns(String) }
      def object; end
      sig { params(_object: String).returns(String) }
      def object=(_object); end
      # The name of the person or business that owns the bank account.This field is required when attaching the bank account to a `Customer` object.
      sig { returns(T.nilable(String)) }
      def account_holder_name; end
      sig { params(_account_holder_name: T.nilable(String)).returns(T.nilable(String)) }
      def account_holder_name=(_account_holder_name); end
      # The type of entity that holds the account. It can be `company` or `individual`. This field is required when attaching the bank account to a `Customer` object.
      sig { returns(T.nilable(String)) }
      def account_holder_type; end
      sig { params(_account_holder_type: T.nilable(String)).returns(T.nilable(String)) }
      def account_holder_type=(_account_holder_type); end
      # The account number for the bank account, in string form. Must be a checking account.
      sig { returns(String) }
      def account_number; end
      sig { params(_account_number: String).returns(String) }
      def account_number=(_account_number); end
      # The country in which the bank account is located.
      sig { returns(String) }
      def country; end
      sig { params(_country: String).returns(String) }
      def country=(_country); end
      # The currency the bank account is in. This must be a country/currency pairing that [Stripe supports.](docs/payouts)
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # The routing number, sort code, or other country-appropriate institution number for the bank account. For US bank accounts, this is required and should be the ACH routing number, not the wire routing number. If you are providing an IBAN for `account_number`, this field is not required.
      sig { returns(T.nilable(String)) }
      def routing_number; end
      sig { params(_routing_number: T.nilable(String)).returns(T.nilable(String)) }
      def routing_number=(_routing_number); end
      sig {
        params(object: String, account_holder_name: T.nilable(String), account_holder_type: T.nilable(String), account_number: String, country: String, currency: T.nilable(String), routing_number: T.nilable(String)).void
       }
      def initialize(
        object: nil,
        account_holder_name: nil,
        account_holder_type: nil,
        account_number: nil,
        country: nil,
        currency: nil,
        routing_number: nil
      ); end
    end
    class Card < ::Stripe::RequestParams
      # Attribute for param field object
      sig { returns(String) }
      def object; end
      sig { params(_object: String).returns(String) }
      def object=(_object); end
      # Attribute for param field address_city
      sig { returns(T.nilable(String)) }
      def address_city; end
      sig { params(_address_city: T.nilable(String)).returns(T.nilable(String)) }
      def address_city=(_address_city); end
      # Attribute for param field address_country
      sig { returns(T.nilable(String)) }
      def address_country; end
      sig { params(_address_country: T.nilable(String)).returns(T.nilable(String)) }
      def address_country=(_address_country); end
      # Attribute for param field address_line1
      sig { returns(T.nilable(String)) }
      def address_line1; end
      sig { params(_address_line1: T.nilable(String)).returns(T.nilable(String)) }
      def address_line1=(_address_line1); end
      # Attribute for param field address_line2
      sig { returns(T.nilable(String)) }
      def address_line2; end
      sig { params(_address_line2: T.nilable(String)).returns(T.nilable(String)) }
      def address_line2=(_address_line2); end
      # Attribute for param field address_state
      sig { returns(T.nilable(String)) }
      def address_state; end
      sig { params(_address_state: T.nilable(String)).returns(T.nilable(String)) }
      def address_state=(_address_state); end
      # Attribute for param field address_zip
      sig { returns(T.nilable(String)) }
      def address_zip; end
      sig { params(_address_zip: T.nilable(String)).returns(T.nilable(String)) }
      def address_zip=(_address_zip); end
      # Attribute for param field currency
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # Attribute for param field cvc
      sig { returns(T.nilable(String)) }
      def cvc; end
      sig { params(_cvc: T.nilable(String)).returns(T.nilable(String)) }
      def cvc=(_cvc); end
      # Attribute for param field exp_month
      sig { returns(Integer) }
      def exp_month; end
      sig { params(_exp_month: Integer).returns(Integer) }
      def exp_month=(_exp_month); end
      # Attribute for param field exp_year
      sig { returns(Integer) }
      def exp_year; end
      sig { params(_exp_year: Integer).returns(Integer) }
      def exp_year=(_exp_year); end
      # Attribute for param field name
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # Attribute for param field number
      sig { returns(String) }
      def number; end
      sig { params(_number: String).returns(String) }
      def number=(_number); end
      # Set of [key-value pairs](https://stripe.com/docs/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      sig {
        params(object: String, address_city: T.nilable(String), address_country: T.nilable(String), address_line1: T.nilable(String), address_line2: T.nilable(String), address_state: T.nilable(String), address_zip: T.nilable(String), currency: T.nilable(String), cvc: T.nilable(String), exp_month: Integer, exp_year: Integer, name: T.nilable(String), number: String, metadata: T.nilable(T::Hash[String, String])).void
       }
      def initialize(
        object: nil,
        address_city: nil,
        address_country: nil,
        address_line1: nil,
        address_line2: nil,
        address_state: nil,
        address_zip: nil,
        currency: nil,
        cvc: nil,
        exp_month: nil,
        exp_year: nil,
        name: nil,
        number: nil,
        metadata: nil
      ); end
    end
    class CardToken < ::Stripe::RequestParams
      # Attribute for param field object
      sig { returns(String) }
      def object; end
      sig { params(_object: String).returns(String) }
      def object=(_object); end
      # Attribute for param field currency
      sig { returns(T.nilable(String)) }
      def currency; end
      sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
      def currency=(_currency); end
      # Attribute for param field token
      sig { returns(String) }
      def token; end
      sig { params(_token: String).returns(String) }
      def token=(_token); end
      sig { params(object: String, currency: T.nilable(String), token: String).void }
      def initialize(object: nil, currency: nil, token: nil); end
    end
    # When set to true, or if this is the first external account added in this currency, this account becomes the default external account for its currency.
    sig { returns(T.nilable(T::Boolean)) }
    def default_for_currency; end
    sig { params(_default_for_currency: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def default_for_currency=(_default_for_currency); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # A token, like the ones returned by [Stripe.js](https://docs.stripe.com/js) or a dictionary containing a user's external account details (with the options shown below). Please refer to full [documentation](https://stripe.com/docs/api/external_accounts) instead.
    sig {
      returns(T.any(String, AccountExternalAccountCreateParams::Card, AccountExternalAccountCreateParams::BankAccount, AccountExternalAccountCreateParams::CardToken))
     }
    def external_account; end
    sig {
      params(_external_account: T.any(String, AccountExternalAccountCreateParams::Card, AccountExternalAccountCreateParams::BankAccount, AccountExternalAccountCreateParams::CardToken)).returns(T.any(String, AccountExternalAccountCreateParams::Card, AccountExternalAccountCreateParams::BankAccount, AccountExternalAccountCreateParams::CardToken))
     }
    def external_account=(_external_account); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    sig {
      params(default_for_currency: T.nilable(T::Boolean), expand: T.nilable(T::Array[String]), external_account: T.any(String, AccountExternalAccountCreateParams::Card, AccountExternalAccountCreateParams::BankAccount, AccountExternalAccountCreateParams::CardToken), metadata: T.nilable(T::Hash[String, String])).void
     }
    def initialize(
      default_for_currency: nil,
      expand: nil,
      external_account: nil,
      metadata: nil
    ); end
  end
end