# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountExternalAccountUpdateParams < ::Stripe::RequestParams
    class Documents < ::Stripe::RequestParams
      class BankAccountOwnershipVerification < ::Stripe::RequestParams
        # One or more document ids returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `account_requirement`.
        sig { returns(T.nilable(T::Array[String])) }
        def files; end
        sig { params(_files: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def files=(_files); end
        sig { params(files: T.nilable(T::Array[String])).void }
        def initialize(files: nil); end
      end
      # One or more documents that support the [Bank account ownership verification](https://support.stripe.com/questions/bank-account-ownership-verification) requirement. Must be a document associated with the bank account that displays the last 4 digits of the account number, either a statement or a check.
      sig {
        returns(T.nilable(AccountExternalAccountUpdateParams::Documents::BankAccountOwnershipVerification))
       }
      def bank_account_ownership_verification; end
      sig {
        params(_bank_account_ownership_verification: T.nilable(AccountExternalAccountUpdateParams::Documents::BankAccountOwnershipVerification)).returns(T.nilable(AccountExternalAccountUpdateParams::Documents::BankAccountOwnershipVerification))
       }
      def bank_account_ownership_verification=(_bank_account_ownership_verification); end
      sig {
        params(bank_account_ownership_verification: T.nilable(AccountExternalAccountUpdateParams::Documents::BankAccountOwnershipVerification)).void
       }
      def initialize(bank_account_ownership_verification: nil); end
    end
    # The name of the person or business that owns the bank account.
    sig { returns(T.nilable(String)) }
    def account_holder_name; end
    sig { params(_account_holder_name: T.nilable(String)).returns(T.nilable(String)) }
    def account_holder_name=(_account_holder_name); end
    # The type of entity that holds the account. This can be either `individual` or `company`.
    sig { returns(T.nilable(T.any(String, String))) }
    def account_holder_type; end
    sig {
      params(_account_holder_type: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
     }
    def account_holder_type=(_account_holder_type); end
    # The bank account type. This can only be `checking` or `savings` in most countries. In Japan, this can only be `futsu` or `toza`.
    sig { returns(T.nilable(String)) }
    def account_type; end
    sig { params(_account_type: T.nilable(String)).returns(T.nilable(String)) }
    def account_type=(_account_type); end
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
    # When set to true, this becomes the default external account for its currency.
    sig { returns(T.nilable(T::Boolean)) }
    def default_for_currency; end
    sig { params(_default_for_currency: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def default_for_currency=(_default_for_currency); end
    # Documents that may be submitted to satisfy various informational requests.
    sig { returns(T.nilable(AccountExternalAccountUpdateParams::Documents)) }
    def documents; end
    sig {
      params(_documents: T.nilable(AccountExternalAccountUpdateParams::Documents)).returns(T.nilable(AccountExternalAccountUpdateParams::Documents))
     }
    def documents=(_documents); end
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
    sig {
      params(account_holder_name: T.nilable(String), account_holder_type: T.nilable(T.any(String, String)), account_type: T.nilable(String), address_city: T.nilable(String), address_country: T.nilable(String), address_line1: T.nilable(String), address_line2: T.nilable(String), address_state: T.nilable(String), address_zip: T.nilable(String), default_for_currency: T.nilable(T::Boolean), documents: T.nilable(AccountExternalAccountUpdateParams::Documents), exp_month: T.nilable(String), exp_year: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), name: T.nilable(String)).void
     }
    def initialize(
      account_holder_name: nil,
      account_holder_type: nil,
      account_type: nil,
      address_city: nil,
      address_country: nil,
      address_line1: nil,
      address_line2: nil,
      address_state: nil,
      address_zip: nil,
      default_for_currency: nil,
      documents: nil,
      exp_month: nil,
      exp_year: nil,
      expand: nil,
      metadata: nil,
      name: nil
    ); end
  end
end