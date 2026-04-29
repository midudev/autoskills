# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Each customer has a [`balance`](https://docs.stripe.com/api/customers/object#customer_object-balance) that is
  # automatically applied to future invoices and payments using the `customer_balance` payment method.
  # Customers can fund this balance by initiating a bank transfer to any account in the
  # `financial_addresses` field.
  # Related guide: [Customer balance funding instructions](https://docs.stripe.com/payments/customer-balance/funding-instructions)
  class FundingInstructions < APIResource
    class BankTransfer < ::Stripe::StripeObject
      class FinancialAddress < ::Stripe::StripeObject
        class Aba < ::Stripe::StripeObject
          class AccountHolderAddress < ::Stripe::StripeObject
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
          class BankAddress < ::Stripe::StripeObject
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
          # Attribute for field account_holder_address
          sig { returns(AccountHolderAddress) }
          def account_holder_address; end
          # The account holder name
          sig { returns(String) }
          def account_holder_name; end
          # The ABA account number
          sig { returns(String) }
          def account_number; end
          # The account type
          sig { returns(String) }
          def account_type; end
          # Attribute for field bank_address
          sig { returns(BankAddress) }
          def bank_address; end
          # The bank name
          sig { returns(String) }
          def bank_name; end
          # The ABA routing number
          sig { returns(String) }
          def routing_number; end
          def self.inner_class_types
            @inner_class_types = {
              account_holder_address: AccountHolderAddress,
              bank_address: BankAddress,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Iban < ::Stripe::StripeObject
          class AccountHolderAddress < ::Stripe::StripeObject
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
          class BankAddress < ::Stripe::StripeObject
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
          # Attribute for field account_holder_address
          sig { returns(AccountHolderAddress) }
          def account_holder_address; end
          # The name of the person or business that owns the bank account
          sig { returns(String) }
          def account_holder_name; end
          # Attribute for field bank_address
          sig { returns(BankAddress) }
          def bank_address; end
          # The BIC/SWIFT code of the account.
          sig { returns(String) }
          def bic; end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(String) }
          def country; end
          # The IBAN of the account.
          sig { returns(String) }
          def iban; end
          def self.inner_class_types
            @inner_class_types = {
              account_holder_address: AccountHolderAddress,
              bank_address: BankAddress,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class SortCode < ::Stripe::StripeObject
          class AccountHolderAddress < ::Stripe::StripeObject
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
          class BankAddress < ::Stripe::StripeObject
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
          # Attribute for field account_holder_address
          sig { returns(AccountHolderAddress) }
          def account_holder_address; end
          # The name of the person or business that owns the bank account
          sig { returns(String) }
          def account_holder_name; end
          # The account number
          sig { returns(String) }
          def account_number; end
          # Attribute for field bank_address
          sig { returns(BankAddress) }
          def bank_address; end
          # The six-digit sort code
          sig { returns(String) }
          def sort_code; end
          def self.inner_class_types
            @inner_class_types = {
              account_holder_address: AccountHolderAddress,
              bank_address: BankAddress,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Spei < ::Stripe::StripeObject
          class AccountHolderAddress < ::Stripe::StripeObject
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
          class BankAddress < ::Stripe::StripeObject
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
          # Attribute for field account_holder_address
          sig { returns(AccountHolderAddress) }
          def account_holder_address; end
          # The account holder name
          sig { returns(String) }
          def account_holder_name; end
          # Attribute for field bank_address
          sig { returns(BankAddress) }
          def bank_address; end
          # The three-digit bank code
          sig { returns(String) }
          def bank_code; end
          # The short banking institution name
          sig { returns(String) }
          def bank_name; end
          # The CLABE number
          sig { returns(String) }
          def clabe; end
          def self.inner_class_types
            @inner_class_types = {
              account_holder_address: AccountHolderAddress,
              bank_address: BankAddress,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Swift < ::Stripe::StripeObject
          class AccountHolderAddress < ::Stripe::StripeObject
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
          class BankAddress < ::Stripe::StripeObject
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
          # Attribute for field account_holder_address
          sig { returns(AccountHolderAddress) }
          def account_holder_address; end
          # The account holder name
          sig { returns(String) }
          def account_holder_name; end
          # The account number
          sig { returns(String) }
          def account_number; end
          # The account type
          sig { returns(String) }
          def account_type; end
          # Attribute for field bank_address
          sig { returns(BankAddress) }
          def bank_address; end
          # The bank name
          sig { returns(String) }
          def bank_name; end
          # The SWIFT code
          sig { returns(String) }
          def swift_code; end
          def self.inner_class_types
            @inner_class_types = {
              account_holder_address: AccountHolderAddress,
              bank_address: BankAddress,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Zengin < ::Stripe::StripeObject
          class AccountHolderAddress < ::Stripe::StripeObject
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
          class BankAddress < ::Stripe::StripeObject
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
          # Attribute for field account_holder_address
          sig { returns(AccountHolderAddress) }
          def account_holder_address; end
          # The account holder name
          sig { returns(T.nilable(String)) }
          def account_holder_name; end
          # The account number
          sig { returns(T.nilable(String)) }
          def account_number; end
          # The bank account type. In Japan, this can only be `futsu` or `toza`.
          sig { returns(T.nilable(String)) }
          def account_type; end
          # Attribute for field bank_address
          sig { returns(BankAddress) }
          def bank_address; end
          # The bank code of the account
          sig { returns(T.nilable(String)) }
          def bank_code; end
          # The bank name of the account
          sig { returns(T.nilable(String)) }
          def bank_name; end
          # The branch code of the account
          sig { returns(T.nilable(String)) }
          def branch_code; end
          # The branch name of the account
          sig { returns(T.nilable(String)) }
          def branch_name; end
          def self.inner_class_types
            @inner_class_types = {
              account_holder_address: AccountHolderAddress,
              bank_address: BankAddress,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # ABA Records contain U.S. bank account details per the ABA format.
        sig { returns(T.nilable(Aba)) }
        def aba; end
        # Iban Records contain E.U. bank account details per the SEPA format.
        sig { returns(T.nilable(Iban)) }
        def iban; end
        # Sort Code Records contain U.K. bank account details per the sort code format.
        sig { returns(T.nilable(SortCode)) }
        def sort_code; end
        # SPEI Records contain Mexico bank account details per the SPEI format.
        sig { returns(T.nilable(Spei)) }
        def spei; end
        # The payment networks supported by this FinancialAddress
        sig { returns(T.nilable(T::Array[String])) }
        def supported_networks; end
        # SWIFT Records contain U.S. bank account details per the SWIFT format.
        sig { returns(T.nilable(Swift)) }
        def swift; end
        # The type of financial address
        sig { returns(String) }
        def type; end
        # Zengin Records contain Japan bank account details per the Zengin format.
        sig { returns(T.nilable(Zengin)) }
        def zengin; end
        def self.inner_class_types
          @inner_class_types = {
            aba: Aba,
            iban: Iban,
            sort_code: SortCode,
            spei: Spei,
            swift: Swift,
            zengin: Zengin,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The country of the bank account to fund
      sig { returns(String) }
      def country; end
      # A list of financial addresses that can be used to fund a particular balance
      sig { returns(T::Array[FinancialAddress]) }
      def financial_addresses; end
      # The bank_transfer type
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {financial_addresses: FinancialAddress}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Attribute for field bank_transfer
    sig { returns(BankTransfer) }
    def bank_transfer; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # The `funding_type` of the returned instructions
    sig { returns(String) }
    def funding_type; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
  end
end