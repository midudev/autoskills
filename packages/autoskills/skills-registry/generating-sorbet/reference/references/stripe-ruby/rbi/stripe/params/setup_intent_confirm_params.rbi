# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SetupIntentConfirmParams < ::Stripe::RequestParams
    class MandateData < ::Stripe::RequestParams
      class CustomerAcceptance < ::Stripe::RequestParams
        class Offline < ::Stripe::RequestParams; end
        class Online < ::Stripe::RequestParams
          # The IP address from which the Mandate was accepted by the customer.
          sig { returns(T.nilable(String)) }
          def ip_address; end
          sig { params(_ip_address: T.nilable(String)).returns(T.nilable(String)) }
          def ip_address=(_ip_address); end
          # The user agent of the browser from which the Mandate was accepted by the customer.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
          def user_agent=(_user_agent); end
          sig { params(ip_address: T.nilable(String), user_agent: T.nilable(String)).void }
          def initialize(ip_address: nil, user_agent: nil); end
        end
        # The time at which the customer accepted the Mandate.
        sig { returns(T.nilable(Integer)) }
        def accepted_at; end
        sig { params(_accepted_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def accepted_at=(_accepted_at); end
        # If this is a Mandate accepted offline, this hash contains details about the offline acceptance.
        sig {
          returns(T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance::Offline))
         }
        def offline; end
        sig {
          params(_offline: T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance::Offline)).returns(T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance::Offline))
         }
        def offline=(_offline); end
        # If this is a Mandate accepted online, this hash contains details about the online acceptance.
        sig {
          returns(T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance::Online))
         }
        def online; end
        sig {
          params(_online: T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance::Online)).returns(T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance::Online))
         }
        def online=(_online); end
        # The type of customer acceptance information included with the Mandate. One of `online` or `offline`.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(accepted_at: T.nilable(Integer), offline: T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance::Offline), online: T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance::Online), type: String).void
         }
        def initialize(accepted_at: nil, offline: nil, online: nil, type: nil); end
      end
      # This hash contains details about the customer acceptance of the Mandate.
      sig { returns(T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance)) }
      def customer_acceptance; end
      sig {
        params(_customer_acceptance: T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance)).returns(T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance))
       }
      def customer_acceptance=(_customer_acceptance); end
      sig {
        params(customer_acceptance: T.nilable(SetupIntentConfirmParams::MandateData::CustomerAcceptance)).void
       }
      def initialize(customer_acceptance: nil); end
    end
    class PaymentMethodData < ::Stripe::RequestParams
      class AcssDebit < ::Stripe::RequestParams
        # Customer's bank account number.
        sig { returns(String) }
        def account_number; end
        sig { params(_account_number: String).returns(String) }
        def account_number=(_account_number); end
        # Institution number of the customer's bank.
        sig { returns(String) }
        def institution_number; end
        sig { params(_institution_number: String).returns(String) }
        def institution_number=(_institution_number); end
        # Transit number of the customer's bank.
        sig { returns(String) }
        def transit_number; end
        sig { params(_transit_number: String).returns(String) }
        def transit_number=(_transit_number); end
        sig {
          params(account_number: String, institution_number: String, transit_number: String).void
         }
        def initialize(account_number: nil, institution_number: nil, transit_number: nil); end
      end
      class Affirm < ::Stripe::RequestParams; end
      class AfterpayClearpay < ::Stripe::RequestParams; end
      class Alipay < ::Stripe::RequestParams; end
      class Alma < ::Stripe::RequestParams; end
      class AmazonPay < ::Stripe::RequestParams; end
      class AuBecsDebit < ::Stripe::RequestParams
        # The account number for the bank account.
        sig { returns(String) }
        def account_number; end
        sig { params(_account_number: String).returns(String) }
        def account_number=(_account_number); end
        # Bank-State-Branch number of the bank account.
        sig { returns(String) }
        def bsb_number; end
        sig { params(_bsb_number: String).returns(String) }
        def bsb_number=(_bsb_number); end
        sig { params(account_number: String, bsb_number: String).void }
        def initialize(account_number: nil, bsb_number: nil); end
      end
      class BacsDebit < ::Stripe::RequestParams
        # Account number of the bank account that the funds will be debited from.
        sig { returns(T.nilable(String)) }
        def account_number; end
        sig { params(_account_number: T.nilable(String)).returns(T.nilable(String)) }
        def account_number=(_account_number); end
        # Sort code of the bank account. (e.g., `10-20-30`)
        sig { returns(T.nilable(String)) }
        def sort_code; end
        sig { params(_sort_code: T.nilable(String)).returns(T.nilable(String)) }
        def sort_code=(_sort_code); end
        sig { params(account_number: T.nilable(String), sort_code: T.nilable(String)).void }
        def initialize(account_number: nil, sort_code: nil); end
      end
      class Bancontact < ::Stripe::RequestParams; end
      class Billie < ::Stripe::RequestParams; end
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
        sig {
          returns(T.nilable(T.any(String, SetupIntentConfirmParams::PaymentMethodData::BillingDetails::Address)))
         }
        def address; end
        sig {
          params(_address: T.nilable(T.any(String, SetupIntentConfirmParams::PaymentMethodData::BillingDetails::Address))).returns(T.nilable(T.any(String, SetupIntentConfirmParams::PaymentMethodData::BillingDetails::Address)))
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
          params(address: T.nilable(T.any(String, SetupIntentConfirmParams::PaymentMethodData::BillingDetails::Address)), email: T.nilable(String), name: T.nilable(String), phone: T.nilable(String), tax_id: T.nilable(String)).void
         }
        def initialize(address: nil, email: nil, name: nil, phone: nil, tax_id: nil); end
      end
      class Blik < ::Stripe::RequestParams; end
      class Boleto < ::Stripe::RequestParams
        # The tax ID of the customer (CPF for individual consumers or CNPJ for businesses consumers)
        sig { returns(String) }
        def tax_id; end
        sig { params(_tax_id: String).returns(String) }
        def tax_id=(_tax_id); end
        sig { params(tax_id: String).void }
        def initialize(tax_id: nil); end
      end
      class Cashapp < ::Stripe::RequestParams; end
      class Crypto < ::Stripe::RequestParams; end
      class CustomerBalance < ::Stripe::RequestParams; end
      class Eps < ::Stripe::RequestParams
        # The customer's bank.
        sig { returns(T.nilable(String)) }
        def bank; end
        sig { params(_bank: T.nilable(String)).returns(T.nilable(String)) }
        def bank=(_bank); end
        sig { params(bank: T.nilable(String)).void }
        def initialize(bank: nil); end
      end
      class Fpx < ::Stripe::RequestParams
        # Account holder type for FPX transaction
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        sig { params(_account_holder_type: T.nilable(String)).returns(T.nilable(String)) }
        def account_holder_type=(_account_holder_type); end
        # The customer's bank.
        sig { returns(String) }
        def bank; end
        sig { params(_bank: String).returns(String) }
        def bank=(_bank); end
        sig { params(account_holder_type: T.nilable(String), bank: String).void }
        def initialize(account_holder_type: nil, bank: nil); end
      end
      class Giropay < ::Stripe::RequestParams; end
      class Grabpay < ::Stripe::RequestParams; end
      class Ideal < ::Stripe::RequestParams
        # The customer's bank. Only use this parameter for existing customers. Don't use it for new customers.
        sig { returns(T.nilable(String)) }
        def bank; end
        sig { params(_bank: T.nilable(String)).returns(T.nilable(String)) }
        def bank=(_bank); end
        sig { params(bank: T.nilable(String)).void }
        def initialize(bank: nil); end
      end
      class InteracPresent < ::Stripe::RequestParams; end
      class KakaoPay < ::Stripe::RequestParams; end
      class Klarna < ::Stripe::RequestParams
        class Dob < ::Stripe::RequestParams
          # The day of birth, between 1 and 31.
          sig { returns(Integer) }
          def day; end
          sig { params(_day: Integer).returns(Integer) }
          def day=(_day); end
          # The month of birth, between 1 and 12.
          sig { returns(Integer) }
          def month; end
          sig { params(_month: Integer).returns(Integer) }
          def month=(_month); end
          # The four-digit year of birth.
          sig { returns(Integer) }
          def year; end
          sig { params(_year: Integer).returns(Integer) }
          def year=(_year); end
          sig { params(day: Integer, month: Integer, year: Integer).void }
          def initialize(day: nil, month: nil, year: nil); end
        end
        # Customer's date of birth
        sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Klarna::Dob)) }
        def dob; end
        sig {
          params(_dob: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Klarna::Dob)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Klarna::Dob))
         }
        def dob=(_dob); end
        sig {
          params(dob: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Klarna::Dob)).void
         }
        def initialize(dob: nil); end
      end
      class Konbini < ::Stripe::RequestParams; end
      class KrCard < ::Stripe::RequestParams; end
      class Link < ::Stripe::RequestParams; end
      class MbWay < ::Stripe::RequestParams; end
      class Mobilepay < ::Stripe::RequestParams; end
      class Multibanco < ::Stripe::RequestParams; end
      class NaverPay < ::Stripe::RequestParams
        # Whether to use Naver Pay points or a card to fund this transaction. If not provided, this defaults to `card`.
        sig { returns(T.nilable(String)) }
        def funding; end
        sig { params(_funding: T.nilable(String)).returns(T.nilable(String)) }
        def funding=(_funding); end
        sig { params(funding: T.nilable(String)).void }
        def initialize(funding: nil); end
      end
      class NzBankAccount < ::Stripe::RequestParams
        # The name on the bank account. Only required if the account holder name is different from the name of the authorized signatory collected in the PaymentMethod’s billing details.
        sig { returns(T.nilable(String)) }
        def account_holder_name; end
        sig { params(_account_holder_name: T.nilable(String)).returns(T.nilable(String)) }
        def account_holder_name=(_account_holder_name); end
        # The account number for the bank account.
        sig { returns(String) }
        def account_number; end
        sig { params(_account_number: String).returns(String) }
        def account_number=(_account_number); end
        # The numeric code for the bank account's bank.
        sig { returns(String) }
        def bank_code; end
        sig { params(_bank_code: String).returns(String) }
        def bank_code=(_bank_code); end
        # The numeric code for the bank account's bank branch.
        sig { returns(String) }
        def branch_code; end
        sig { params(_branch_code: String).returns(String) }
        def branch_code=(_branch_code); end
        # Attribute for param field reference
        sig { returns(T.nilable(String)) }
        def reference; end
        sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
        def reference=(_reference); end
        # The suffix of the bank account number.
        sig { returns(String) }
        def suffix; end
        sig { params(_suffix: String).returns(String) }
        def suffix=(_suffix); end
        sig {
          params(account_holder_name: T.nilable(String), account_number: String, bank_code: String, branch_code: String, reference: T.nilable(String), suffix: String).void
         }
        def initialize(
          account_holder_name: nil,
          account_number: nil,
          bank_code: nil,
          branch_code: nil,
          reference: nil,
          suffix: nil
        ); end
      end
      class Oxxo < ::Stripe::RequestParams; end
      class P24 < ::Stripe::RequestParams
        # The customer's bank.
        sig { returns(T.nilable(String)) }
        def bank; end
        sig { params(_bank: T.nilable(String)).returns(T.nilable(String)) }
        def bank=(_bank); end
        sig { params(bank: T.nilable(String)).void }
        def initialize(bank: nil); end
      end
      class PayByBank < ::Stripe::RequestParams; end
      class Payco < ::Stripe::RequestParams; end
      class Paynow < ::Stripe::RequestParams; end
      class Paypal < ::Stripe::RequestParams; end
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
      class Pix < ::Stripe::RequestParams; end
      class Promptpay < ::Stripe::RequestParams; end
      class RadarOptions < ::Stripe::RequestParams
        # A [Radar Session](https://docs.stripe.com/radar/radar-session) is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
        sig { returns(T.nilable(String)) }
        def session; end
        sig { params(_session: T.nilable(String)).returns(T.nilable(String)) }
        def session=(_session); end
        sig { params(session: T.nilable(String)).void }
        def initialize(session: nil); end
      end
      class RevolutPay < ::Stripe::RequestParams; end
      class SamsungPay < ::Stripe::RequestParams; end
      class Satispay < ::Stripe::RequestParams; end
      class SepaDebit < ::Stripe::RequestParams
        # IBAN of the bank account.
        sig { returns(String) }
        def iban; end
        sig { params(_iban: String).returns(String) }
        def iban=(_iban); end
        sig { params(iban: String).void }
        def initialize(iban: nil); end
      end
      class Sofort < ::Stripe::RequestParams
        # Two-letter ISO code representing the country the bank account is located in.
        sig { returns(String) }
        def country; end
        sig { params(_country: String).returns(String) }
        def country=(_country); end
        sig { params(country: String).void }
        def initialize(country: nil); end
      end
      class Swish < ::Stripe::RequestParams; end
      class Twint < ::Stripe::RequestParams; end
      class UsBankAccount < ::Stripe::RequestParams
        # Account holder type: individual or company.
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        sig { params(_account_holder_type: T.nilable(String)).returns(T.nilable(String)) }
        def account_holder_type=(_account_holder_type); end
        # Account number of the bank account.
        sig { returns(T.nilable(String)) }
        def account_number; end
        sig { params(_account_number: T.nilable(String)).returns(T.nilable(String)) }
        def account_number=(_account_number); end
        # Account type: checkings or savings. Defaults to checking if omitted.
        sig { returns(T.nilable(String)) }
        def account_type; end
        sig { params(_account_type: T.nilable(String)).returns(T.nilable(String)) }
        def account_type=(_account_type); end
        # The ID of a Financial Connections Account to use as a payment method.
        sig { returns(T.nilable(String)) }
        def financial_connections_account; end
        sig { params(_financial_connections_account: T.nilable(String)).returns(T.nilable(String)) }
        def financial_connections_account=(_financial_connections_account); end
        # Routing number of the bank account.
        sig { returns(T.nilable(String)) }
        def routing_number; end
        sig { params(_routing_number: T.nilable(String)).returns(T.nilable(String)) }
        def routing_number=(_routing_number); end
        sig {
          params(account_holder_type: T.nilable(String), account_number: T.nilable(String), account_type: T.nilable(String), financial_connections_account: T.nilable(String), routing_number: T.nilable(String)).void
         }
        def initialize(
          account_holder_type: nil,
          account_number: nil,
          account_type: nil,
          financial_connections_account: nil,
          routing_number: nil
        ); end
      end
      class WechatPay < ::Stripe::RequestParams; end
      class Zip < ::Stripe::RequestParams; end
      # If this is an `acss_debit` PaymentMethod, this hash contains details about the ACSS Debit payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::AcssDebit)) }
      def acss_debit; end
      sig {
        params(_acss_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodData::AcssDebit)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::AcssDebit))
       }
      def acss_debit=(_acss_debit); end
      # If this is an `affirm` PaymentMethod, this hash contains details about the Affirm payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Affirm)) }
      def affirm; end
      sig {
        params(_affirm: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Affirm)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Affirm))
       }
      def affirm=(_affirm); end
      # If this is an `AfterpayClearpay` PaymentMethod, this hash contains details about the AfterpayClearpay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::AfterpayClearpay)) }
      def afterpay_clearpay; end
      sig {
        params(_afterpay_clearpay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::AfterpayClearpay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::AfterpayClearpay))
       }
      def afterpay_clearpay=(_afterpay_clearpay); end
      # If this is an `Alipay` PaymentMethod, this hash contains details about the Alipay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Alipay)) }
      def alipay; end
      sig {
        params(_alipay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Alipay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Alipay))
       }
      def alipay=(_alipay); end
      # This field indicates whether this payment method can be shown again to its customer in a checkout flow. Stripe products such as Checkout and Elements use this field to determine whether a payment method can be shown as a saved payment method in a checkout flow. The field defaults to `unspecified`.
      sig { returns(T.nilable(String)) }
      def allow_redisplay; end
      sig { params(_allow_redisplay: T.nilable(String)).returns(T.nilable(String)) }
      def allow_redisplay=(_allow_redisplay); end
      # If this is a Alma PaymentMethod, this hash contains details about the Alma payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Alma)) }
      def alma; end
      sig {
        params(_alma: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Alma)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Alma))
       }
      def alma=(_alma); end
      # If this is a AmazonPay PaymentMethod, this hash contains details about the AmazonPay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::AmazonPay)) }
      def amazon_pay; end
      sig {
        params(_amazon_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::AmazonPay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::AmazonPay))
       }
      def amazon_pay=(_amazon_pay); end
      # If this is an `au_becs_debit` PaymentMethod, this hash contains details about the bank account.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::AuBecsDebit)) }
      def au_becs_debit; end
      sig {
        params(_au_becs_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodData::AuBecsDebit)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::AuBecsDebit))
       }
      def au_becs_debit=(_au_becs_debit); end
      # If this is a `bacs_debit` PaymentMethod, this hash contains details about the Bacs Direct Debit bank account.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::BacsDebit)) }
      def bacs_debit; end
      sig {
        params(_bacs_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodData::BacsDebit)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::BacsDebit))
       }
      def bacs_debit=(_bacs_debit); end
      # If this is a `bancontact` PaymentMethod, this hash contains details about the Bancontact payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Bancontact)) }
      def bancontact; end
      sig {
        params(_bancontact: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Bancontact)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Bancontact))
       }
      def bancontact=(_bancontact); end
      # If this is a `billie` PaymentMethod, this hash contains details about the Billie payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Billie)) }
      def billie; end
      sig {
        params(_billie: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Billie)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Billie))
       }
      def billie=(_billie); end
      # Billing information associated with the PaymentMethod that may be used or required by particular types of payment methods.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::BillingDetails)) }
      def billing_details; end
      sig {
        params(_billing_details: T.nilable(SetupIntentConfirmParams::PaymentMethodData::BillingDetails)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::BillingDetails))
       }
      def billing_details=(_billing_details); end
      # If this is a `blik` PaymentMethod, this hash contains details about the BLIK payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Blik)) }
      def blik; end
      sig {
        params(_blik: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Blik)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Blik))
       }
      def blik=(_blik); end
      # If this is a `boleto` PaymentMethod, this hash contains details about the Boleto payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Boleto)) }
      def boleto; end
      sig {
        params(_boleto: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Boleto)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Boleto))
       }
      def boleto=(_boleto); end
      # If this is a `cashapp` PaymentMethod, this hash contains details about the Cash App Pay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Cashapp)) }
      def cashapp; end
      sig {
        params(_cashapp: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Cashapp)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Cashapp))
       }
      def cashapp=(_cashapp); end
      # If this is a Crypto PaymentMethod, this hash contains details about the Crypto payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Crypto)) }
      def crypto; end
      sig {
        params(_crypto: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Crypto)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Crypto))
       }
      def crypto=(_crypto); end
      # If this is a `customer_balance` PaymentMethod, this hash contains details about the CustomerBalance payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::CustomerBalance)) }
      def customer_balance; end
      sig {
        params(_customer_balance: T.nilable(SetupIntentConfirmParams::PaymentMethodData::CustomerBalance)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::CustomerBalance))
       }
      def customer_balance=(_customer_balance); end
      # If this is an `eps` PaymentMethod, this hash contains details about the EPS payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Eps)) }
      def eps; end
      sig {
        params(_eps: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Eps)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Eps))
       }
      def eps=(_eps); end
      # If this is an `fpx` PaymentMethod, this hash contains details about the FPX payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Fpx)) }
      def fpx; end
      sig {
        params(_fpx: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Fpx)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Fpx))
       }
      def fpx=(_fpx); end
      # If this is a `giropay` PaymentMethod, this hash contains details about the Giropay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Giropay)) }
      def giropay; end
      sig {
        params(_giropay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Giropay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Giropay))
       }
      def giropay=(_giropay); end
      # If this is a `grabpay` PaymentMethod, this hash contains details about the GrabPay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Grabpay)) }
      def grabpay; end
      sig {
        params(_grabpay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Grabpay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Grabpay))
       }
      def grabpay=(_grabpay); end
      # If this is an `ideal` PaymentMethod, this hash contains details about the iDEAL payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Ideal)) }
      def ideal; end
      sig {
        params(_ideal: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Ideal)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Ideal))
       }
      def ideal=(_ideal); end
      # If this is an `interac_present` PaymentMethod, this hash contains details about the Interac Present payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::InteracPresent)) }
      def interac_present; end
      sig {
        params(_interac_present: T.nilable(SetupIntentConfirmParams::PaymentMethodData::InteracPresent)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::InteracPresent))
       }
      def interac_present=(_interac_present); end
      # If this is a `kakao_pay` PaymentMethod, this hash contains details about the Kakao Pay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::KakaoPay)) }
      def kakao_pay; end
      sig {
        params(_kakao_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::KakaoPay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::KakaoPay))
       }
      def kakao_pay=(_kakao_pay); end
      # If this is a `klarna` PaymentMethod, this hash contains details about the Klarna payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Klarna)) }
      def klarna; end
      sig {
        params(_klarna: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Klarna)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Klarna))
       }
      def klarna=(_klarna); end
      # If this is a `konbini` PaymentMethod, this hash contains details about the Konbini payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Konbini)) }
      def konbini; end
      sig {
        params(_konbini: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Konbini)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Konbini))
       }
      def konbini=(_konbini); end
      # If this is a `kr_card` PaymentMethod, this hash contains details about the Korean Card payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::KrCard)) }
      def kr_card; end
      sig {
        params(_kr_card: T.nilable(SetupIntentConfirmParams::PaymentMethodData::KrCard)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::KrCard))
       }
      def kr_card=(_kr_card); end
      # If this is an `Link` PaymentMethod, this hash contains details about the Link payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Link)) }
      def link; end
      sig {
        params(_link: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Link)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Link))
       }
      def link=(_link); end
      # If this is a MB WAY PaymentMethod, this hash contains details about the MB WAY payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::MbWay)) }
      def mb_way; end
      sig {
        params(_mb_way: T.nilable(SetupIntentConfirmParams::PaymentMethodData::MbWay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::MbWay))
       }
      def mb_way=(_mb_way); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # If this is a `mobilepay` PaymentMethod, this hash contains details about the MobilePay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Mobilepay)) }
      def mobilepay; end
      sig {
        params(_mobilepay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Mobilepay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Mobilepay))
       }
      def mobilepay=(_mobilepay); end
      # If this is a `multibanco` PaymentMethod, this hash contains details about the Multibanco payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Multibanco)) }
      def multibanco; end
      sig {
        params(_multibanco: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Multibanco)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Multibanco))
       }
      def multibanco=(_multibanco); end
      # If this is a `naver_pay` PaymentMethod, this hash contains details about the Naver Pay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::NaverPay)) }
      def naver_pay; end
      sig {
        params(_naver_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::NaverPay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::NaverPay))
       }
      def naver_pay=(_naver_pay); end
      # If this is an nz_bank_account PaymentMethod, this hash contains details about the nz_bank_account payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::NzBankAccount)) }
      def nz_bank_account; end
      sig {
        params(_nz_bank_account: T.nilable(SetupIntentConfirmParams::PaymentMethodData::NzBankAccount)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::NzBankAccount))
       }
      def nz_bank_account=(_nz_bank_account); end
      # If this is an `oxxo` PaymentMethod, this hash contains details about the OXXO payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Oxxo)) }
      def oxxo; end
      sig {
        params(_oxxo: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Oxxo)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Oxxo))
       }
      def oxxo=(_oxxo); end
      # If this is a `p24` PaymentMethod, this hash contains details about the P24 payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::P24)) }
      def p24; end
      sig {
        params(_p24: T.nilable(SetupIntentConfirmParams::PaymentMethodData::P24)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::P24))
       }
      def p24=(_p24); end
      # If this is a `pay_by_bank` PaymentMethod, this hash contains details about the PayByBank payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::PayByBank)) }
      def pay_by_bank; end
      sig {
        params(_pay_by_bank: T.nilable(SetupIntentConfirmParams::PaymentMethodData::PayByBank)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::PayByBank))
       }
      def pay_by_bank=(_pay_by_bank); end
      # If this is a `payco` PaymentMethod, this hash contains details about the PAYCO payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Payco)) }
      def payco; end
      sig {
        params(_payco: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Payco)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Payco))
       }
      def payco=(_payco); end
      # If this is a `paynow` PaymentMethod, this hash contains details about the PayNow payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Paynow)) }
      def paynow; end
      sig {
        params(_paynow: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Paynow)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Paynow))
       }
      def paynow=(_paynow); end
      # If this is a `paypal` PaymentMethod, this hash contains details about the PayPal payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Paypal)) }
      def paypal; end
      sig {
        params(_paypal: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Paypal)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Paypal))
       }
      def paypal=(_paypal); end
      # If this is a `payto` PaymentMethod, this hash contains details about the PayTo payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Payto)) }
      def payto; end
      sig {
        params(_payto: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Payto)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Payto))
       }
      def payto=(_payto); end
      # If this is a `pix` PaymentMethod, this hash contains details about the Pix payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Pix)) }
      def pix; end
      sig {
        params(_pix: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Pix)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Pix))
       }
      def pix=(_pix); end
      # If this is a `promptpay` PaymentMethod, this hash contains details about the PromptPay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Promptpay)) }
      def promptpay; end
      sig {
        params(_promptpay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Promptpay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Promptpay))
       }
      def promptpay=(_promptpay); end
      # Options to configure Radar. See [Radar Session](https://docs.stripe.com/radar/radar-session) for more information.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::RadarOptions)) }
      def radar_options; end
      sig {
        params(_radar_options: T.nilable(SetupIntentConfirmParams::PaymentMethodData::RadarOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::RadarOptions))
       }
      def radar_options=(_radar_options); end
      # If this is a `revolut_pay` PaymentMethod, this hash contains details about the Revolut Pay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::RevolutPay)) }
      def revolut_pay; end
      sig {
        params(_revolut_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::RevolutPay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::RevolutPay))
       }
      def revolut_pay=(_revolut_pay); end
      # If this is a `samsung_pay` PaymentMethod, this hash contains details about the SamsungPay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::SamsungPay)) }
      def samsung_pay; end
      sig {
        params(_samsung_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::SamsungPay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::SamsungPay))
       }
      def samsung_pay=(_samsung_pay); end
      # If this is a `satispay` PaymentMethod, this hash contains details about the Satispay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Satispay)) }
      def satispay; end
      sig {
        params(_satispay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Satispay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Satispay))
       }
      def satispay=(_satispay); end
      # If this is a `sepa_debit` PaymentMethod, this hash contains details about the SEPA debit bank account.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::SepaDebit)) }
      def sepa_debit; end
      sig {
        params(_sepa_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodData::SepaDebit)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::SepaDebit))
       }
      def sepa_debit=(_sepa_debit); end
      # If this is a `sofort` PaymentMethod, this hash contains details about the SOFORT payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Sofort)) }
      def sofort; end
      sig {
        params(_sofort: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Sofort)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Sofort))
       }
      def sofort=(_sofort); end
      # If this is a `swish` PaymentMethod, this hash contains details about the Swish payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Swish)) }
      def swish; end
      sig {
        params(_swish: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Swish)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Swish))
       }
      def swish=(_swish); end
      # If this is a TWINT PaymentMethod, this hash contains details about the TWINT payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Twint)) }
      def twint; end
      sig {
        params(_twint: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Twint)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Twint))
       }
      def twint=(_twint); end
      # The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      # If this is an `us_bank_account` PaymentMethod, this hash contains details about the US bank account payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::UsBankAccount)) }
      def us_bank_account; end
      sig {
        params(_us_bank_account: T.nilable(SetupIntentConfirmParams::PaymentMethodData::UsBankAccount)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::UsBankAccount))
       }
      def us_bank_account=(_us_bank_account); end
      # If this is an `wechat_pay` PaymentMethod, this hash contains details about the wechat_pay payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::WechatPay)) }
      def wechat_pay; end
      sig {
        params(_wechat_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::WechatPay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::WechatPay))
       }
      def wechat_pay=(_wechat_pay); end
      # If this is a `zip` PaymentMethod, this hash contains details about the Zip payment method.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Zip)) }
      def zip; end
      sig {
        params(_zip: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Zip)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData::Zip))
       }
      def zip=(_zip); end
      sig {
        params(acss_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodData::AcssDebit), affirm: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Affirm), afterpay_clearpay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::AfterpayClearpay), alipay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Alipay), allow_redisplay: T.nilable(String), alma: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Alma), amazon_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::AmazonPay), au_becs_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodData::AuBecsDebit), bacs_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodData::BacsDebit), bancontact: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Bancontact), billie: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Billie), billing_details: T.nilable(SetupIntentConfirmParams::PaymentMethodData::BillingDetails), blik: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Blik), boleto: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Boleto), cashapp: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Cashapp), crypto: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Crypto), customer_balance: T.nilable(SetupIntentConfirmParams::PaymentMethodData::CustomerBalance), eps: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Eps), fpx: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Fpx), giropay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Giropay), grabpay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Grabpay), ideal: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Ideal), interac_present: T.nilable(SetupIntentConfirmParams::PaymentMethodData::InteracPresent), kakao_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::KakaoPay), klarna: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Klarna), konbini: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Konbini), kr_card: T.nilable(SetupIntentConfirmParams::PaymentMethodData::KrCard), link: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Link), mb_way: T.nilable(SetupIntentConfirmParams::PaymentMethodData::MbWay), metadata: T.nilable(T::Hash[String, String]), mobilepay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Mobilepay), multibanco: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Multibanco), naver_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::NaverPay), nz_bank_account: T.nilable(SetupIntentConfirmParams::PaymentMethodData::NzBankAccount), oxxo: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Oxxo), p24: T.nilable(SetupIntentConfirmParams::PaymentMethodData::P24), pay_by_bank: T.nilable(SetupIntentConfirmParams::PaymentMethodData::PayByBank), payco: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Payco), paynow: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Paynow), paypal: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Paypal), payto: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Payto), pix: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Pix), promptpay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Promptpay), radar_options: T.nilable(SetupIntentConfirmParams::PaymentMethodData::RadarOptions), revolut_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::RevolutPay), samsung_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::SamsungPay), satispay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Satispay), sepa_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodData::SepaDebit), sofort: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Sofort), swish: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Swish), twint: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Twint), type: String, us_bank_account: T.nilable(SetupIntentConfirmParams::PaymentMethodData::UsBankAccount), wechat_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodData::WechatPay), zip: T.nilable(SetupIntentConfirmParams::PaymentMethodData::Zip)).void
       }
      def initialize(
        acss_debit: nil,
        affirm: nil,
        afterpay_clearpay: nil,
        alipay: nil,
        allow_redisplay: nil,
        alma: nil,
        amazon_pay: nil,
        au_becs_debit: nil,
        bacs_debit: nil,
        bancontact: nil,
        billie: nil,
        billing_details: nil,
        blik: nil,
        boleto: nil,
        cashapp: nil,
        crypto: nil,
        customer_balance: nil,
        eps: nil,
        fpx: nil,
        giropay: nil,
        grabpay: nil,
        ideal: nil,
        interac_present: nil,
        kakao_pay: nil,
        klarna: nil,
        konbini: nil,
        kr_card: nil,
        link: nil,
        mb_way: nil,
        metadata: nil,
        mobilepay: nil,
        multibanco: nil,
        naver_pay: nil,
        nz_bank_account: nil,
        oxxo: nil,
        p24: nil,
        pay_by_bank: nil,
        payco: nil,
        paynow: nil,
        paypal: nil,
        payto: nil,
        pix: nil,
        promptpay: nil,
        radar_options: nil,
        revolut_pay: nil,
        samsung_pay: nil,
        satispay: nil,
        sepa_debit: nil,
        sofort: nil,
        swish: nil,
        twint: nil,
        type: nil,
        us_bank_account: nil,
        wechat_pay: nil,
        zip: nil
      ); end
    end
    class PaymentMethodOptions < ::Stripe::RequestParams
      class AcssDebit < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # A URL for custom mandate text to render during confirmation step.
          # The URL will be rendered with additional GET parameters `payment_intent` and `payment_intent_client_secret` when confirming a Payment Intent,
          # or `setup_intent` and `setup_intent_client_secret` when confirming a Setup Intent.
          sig { returns(T.nilable(String)) }
          def custom_mandate_url; end
          sig { params(_custom_mandate_url: T.nilable(String)).returns(T.nilable(String)) }
          def custom_mandate_url=(_custom_mandate_url); end
          # List of Stripe products where this mandate can be selected automatically.
          sig { returns(T.nilable(T::Array[String])) }
          def default_for; end
          sig {
            params(_default_for: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def default_for=(_default_for); end
          # Description of the mandate interval. Only required if 'payment_schedule' parameter is 'interval' or 'combined'.
          sig { returns(T.nilable(String)) }
          def interval_description; end
          sig { params(_interval_description: T.nilable(String)).returns(T.nilable(String)) }
          def interval_description=(_interval_description); end
          # Payment schedule for the mandate.
          sig { returns(T.nilable(String)) }
          def payment_schedule; end
          sig { params(_payment_schedule: T.nilable(String)).returns(T.nilable(String)) }
          def payment_schedule=(_payment_schedule); end
          # Transaction type of the mandate.
          sig { returns(T.nilable(String)) }
          def transaction_type; end
          sig { params(_transaction_type: T.nilable(String)).returns(T.nilable(String)) }
          def transaction_type=(_transaction_type); end
          sig {
            params(custom_mandate_url: T.nilable(String), default_for: T.nilable(T::Array[String]), interval_description: T.nilable(String), payment_schedule: T.nilable(String), transaction_type: T.nilable(String)).void
           }
          def initialize(
            custom_mandate_url: nil,
            default_for: nil,
            interval_description: nil,
            payment_schedule: nil,
            transaction_type: nil
          ); end
        end
        # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
        sig { returns(T.nilable(String)) }
        def currency; end
        sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
        def currency=(_currency); end
        # Additional fields for Mandate creation
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AcssDebit::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AcssDebit::MandateOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AcssDebit::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # Bank account verification method.
        sig { returns(T.nilable(String)) }
        def verification_method; end
        sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
        def verification_method=(_verification_method); end
        sig {
          params(currency: T.nilable(String), mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AcssDebit::MandateOptions), verification_method: T.nilable(String)).void
         }
        def initialize(currency: nil, mandate_options: nil, verification_method: nil); end
      end
      class AmazonPay < ::Stripe::RequestParams; end
      class BacsDebit < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'DDIC' or 'STRIPE'.
          sig { returns(T.nilable(String)) }
          def reference_prefix; end
          sig { params(_reference_prefix: T.nilable(String)).returns(T.nilable(String)) }
          def reference_prefix=(_reference_prefix); end
          sig { params(reference_prefix: T.nilable(String)).void }
          def initialize(reference_prefix: nil); end
        end
        # Additional fields for Mandate creation
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::BacsDebit::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::BacsDebit::MandateOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::BacsDebit::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        sig {
          params(mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::BacsDebit::MandateOptions)).void
         }
        def initialize(mandate_options: nil); end
      end
      class Card < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # Amount to be charged for future payments.
          sig { returns(Integer) }
          def amount; end
          sig { params(_amount: Integer).returns(Integer) }
          def amount=(_amount); end
          # One of `fixed` or `maximum`. If `fixed`, the `amount` param refers to the exact amount to be charged in future payments. If `maximum`, the amount charged can be up to the value passed for the `amount` param.
          sig { returns(String) }
          def amount_type; end
          sig { params(_amount_type: String).returns(String) }
          def amount_type=(_amount_type); end
          # Currency in which future payments will be charged. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
          sig { returns(String) }
          def currency; end
          sig { params(_currency: String).returns(String) }
          def currency=(_currency); end
          # A description of the mandate or subscription that is meant to be displayed to the customer.
          sig { returns(T.nilable(String)) }
          def description; end
          sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
          def description=(_description); end
          # End date of the mandate or subscription. If not provided, the mandate will be active until canceled. If provided, end date should be after start date.
          sig { returns(T.nilable(Integer)) }
          def end_date; end
          sig { params(_end_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def end_date=(_end_date); end
          # Specifies payment frequency. One of `day`, `week`, `month`, `year`, or `sporadic`.
          sig { returns(String) }
          def interval; end
          sig { params(_interval: String).returns(String) }
          def interval=(_interval); end
          # The number of intervals between payments. For example, `interval=month` and `interval_count=3` indicates one payment every three months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks). This parameter is optional when `interval=sporadic`.
          sig { returns(T.nilable(Integer)) }
          def interval_count; end
          sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def interval_count=(_interval_count); end
          # Unique identifier for the mandate or subscription.
          sig { returns(String) }
          def reference; end
          sig { params(_reference: String).returns(String) }
          def reference=(_reference); end
          # Start date of the mandate or subscription. Start date should not be lesser than yesterday.
          sig { returns(Integer) }
          def start_date; end
          sig { params(_start_date: Integer).returns(Integer) }
          def start_date=(_start_date); end
          # Specifies the type of mandates supported. Possible values are `india`.
          sig { returns(T.nilable(T::Array[String])) }
          def supported_types; end
          sig {
            params(_supported_types: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def supported_types=(_supported_types); end
          sig {
            params(amount: Integer, amount_type: String, currency: String, description: T.nilable(String), end_date: T.nilable(Integer), interval: String, interval_count: T.nilable(Integer), reference: String, start_date: Integer, supported_types: T.nilable(T::Array[String])).void
           }
          def initialize(
            amount: nil,
            amount_type: nil,
            currency: nil,
            description: nil,
            end_date: nil,
            interval: nil,
            interval_count: nil,
            reference: nil,
            start_date: nil,
            supported_types: nil
          ); end
        end
        class ThreeDSecure < ::Stripe::RequestParams
          class NetworkOptions < ::Stripe::RequestParams
            class CartesBancaires < ::Stripe::RequestParams
              # The cryptogram calculation algorithm used by the card Issuer's ACS
              # to calculate the Authentication cryptogram. Also known as `cavvAlgorithm`.
              # messageExtension: CB-AVALGO
              sig { returns(String) }
              def cb_avalgo; end
              sig { params(_cb_avalgo: String).returns(String) }
              def cb_avalgo=(_cb_avalgo); end
              # The exemption indicator returned from Cartes Bancaires in the ARes.
              # message extension: CB-EXEMPTION; string (4 characters)
              # This is a 3 byte bitmap (low significant byte first and most significant
              # bit first) that has been Base64 encoded
              sig { returns(T.nilable(String)) }
              def cb_exemption; end
              sig { params(_cb_exemption: T.nilable(String)).returns(T.nilable(String)) }
              def cb_exemption=(_cb_exemption); end
              # The risk score returned from Cartes Bancaires in the ARes.
              # message extension: CB-SCORE; numeric value 0-99
              sig { returns(T.nilable(Integer)) }
              def cb_score; end
              sig { params(_cb_score: T.nilable(Integer)).returns(T.nilable(Integer)) }
              def cb_score=(_cb_score); end
              sig {
                params(cb_avalgo: String, cb_exemption: T.nilable(String), cb_score: T.nilable(Integer)).void
               }
              def initialize(cb_avalgo: nil, cb_exemption: nil, cb_score: nil); end
            end
            # Cartes Bancaires-specific 3DS fields.
            sig {
              returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions::CartesBancaires))
             }
            def cartes_bancaires; end
            sig {
              params(_cartes_bancaires: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions::CartesBancaires)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions::CartesBancaires))
             }
            def cartes_bancaires=(_cartes_bancaires); end
            sig {
              params(cartes_bancaires: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions::CartesBancaires)).void
             }
            def initialize(cartes_bancaires: nil); end
          end
          # The `transStatus` returned from the card Issuer’s ACS in the ARes.
          sig { returns(T.nilable(String)) }
          def ares_trans_status; end
          sig { params(_ares_trans_status: T.nilable(String)).returns(T.nilable(String)) }
          def ares_trans_status=(_ares_trans_status); end
          # The cryptogram, also known as the "authentication value" (AAV, CAVV or
          # AEVV). This value is 20 bytes, base64-encoded into a 28-character string.
          # (Most 3D Secure providers will return the base64-encoded version, which
          # is what you should specify here.)
          sig { returns(T.nilable(String)) }
          def cryptogram; end
          sig { params(_cryptogram: T.nilable(String)).returns(T.nilable(String)) }
          def cryptogram=(_cryptogram); end
          # The Electronic Commerce Indicator (ECI) is returned by your 3D Secure
          # provider and indicates what degree of authentication was performed.
          sig { returns(T.nilable(String)) }
          def electronic_commerce_indicator; end
          sig {
            params(_electronic_commerce_indicator: T.nilable(String)).returns(T.nilable(String))
           }
          def electronic_commerce_indicator=(_electronic_commerce_indicator); end
          # Network specific 3DS fields. Network specific arguments require an
          # explicit card brand choice. The parameter `payment_method_options.card.network``
          # must be populated accordingly
          sig {
            returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions))
           }
          def network_options; end
          sig {
            params(_network_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions))
           }
          def network_options=(_network_options); end
          # The challenge indicator (`threeDSRequestorChallengeInd`) which was requested in the
          # AReq sent to the card Issuer's ACS. A string containing 2 digits from 01-99.
          sig { returns(T.nilable(String)) }
          def requestor_challenge_indicator; end
          sig {
            params(_requestor_challenge_indicator: T.nilable(String)).returns(T.nilable(String))
           }
          def requestor_challenge_indicator=(_requestor_challenge_indicator); end
          # For 3D Secure 1, the XID. For 3D Secure 2, the Directory Server
          # Transaction ID (dsTransID).
          sig { returns(T.nilable(String)) }
          def transaction_id; end
          sig { params(_transaction_id: T.nilable(String)).returns(T.nilable(String)) }
          def transaction_id=(_transaction_id); end
          # The version of 3D Secure that was performed.
          sig { returns(T.nilable(String)) }
          def version; end
          sig { params(_version: T.nilable(String)).returns(T.nilable(String)) }
          def version=(_version); end
          sig {
            params(ares_trans_status: T.nilable(String), cryptogram: T.nilable(String), electronic_commerce_indicator: T.nilable(String), network_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure::NetworkOptions), requestor_challenge_indicator: T.nilable(String), transaction_id: T.nilable(String), version: T.nilable(String)).void
           }
          def initialize(
            ares_trans_status: nil,
            cryptogram: nil,
            electronic_commerce_indicator: nil,
            network_options: nil,
            requestor_challenge_indicator: nil,
            transaction_id: nil,
            version: nil
          ); end
        end
        # Configuration options for setting up an eMandate for cards issued in India.
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::MandateOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # When specified, this parameter signals that a card has been collected
        # as MOTO (Mail Order Telephone Order) and thus out of scope for SCA. This
        # parameter can only be provided during confirmation.
        sig { returns(T.nilable(T::Boolean)) }
        def moto; end
        sig { params(_moto: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def moto=(_moto); end
        # Selected network to process this SetupIntent on. Depends on the available networks of the card attached to the SetupIntent. Can be only set confirm-time.
        sig { returns(T.nilable(String)) }
        def network; end
        sig { params(_network: T.nilable(String)).returns(T.nilable(String)) }
        def network=(_network); end
        # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. If not provided, this value defaults to `automatic`. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
        sig { returns(T.nilable(String)) }
        def request_three_d_secure; end
        sig { params(_request_three_d_secure: T.nilable(String)).returns(T.nilable(String)) }
        def request_three_d_secure=(_request_three_d_secure); end
        # If 3D Secure authentication was performed with a third-party provider,
        # the authentication details to use for this setup.
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure))
         }
        def three_d_secure; end
        sig {
          params(_three_d_secure: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure))
         }
        def three_d_secure=(_three_d_secure); end
        sig {
          params(mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::MandateOptions), moto: T.nilable(T::Boolean), network: T.nilable(String), request_three_d_secure: T.nilable(String), three_d_secure: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card::ThreeDSecure)).void
         }
        def initialize(
          mandate_options: nil,
          moto: nil,
          network: nil,
          request_three_d_secure: nil,
          three_d_secure: nil
        ); end
      end
      class CardPresent < ::Stripe::RequestParams; end
      class Klarna < ::Stripe::RequestParams
        class OnDemand < ::Stripe::RequestParams
          # Your average amount value. You can use a value across your customer base, or segment based on customer type, country, etc.
          sig { returns(T.nilable(Integer)) }
          def average_amount; end
          sig { params(_average_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def average_amount=(_average_amount); end
          # The maximum value you may charge a customer per purchase. You can use a value across your customer base, or segment based on customer type, country, etc.
          sig { returns(T.nilable(Integer)) }
          def maximum_amount; end
          sig { params(_maximum_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def maximum_amount=(_maximum_amount); end
          # The lowest or minimum value you may charge a customer per purchase. You can use a value across your customer base, or segment based on customer type, country, etc.
          sig { returns(T.nilable(Integer)) }
          def minimum_amount; end
          sig { params(_minimum_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def minimum_amount=(_minimum_amount); end
          # Interval at which the customer is making purchases
          sig { returns(T.nilable(String)) }
          def purchase_interval; end
          sig { params(_purchase_interval: T.nilable(String)).returns(T.nilable(String)) }
          def purchase_interval=(_purchase_interval); end
          # The number of `purchase_interval` between charges
          sig { returns(T.nilable(Integer)) }
          def purchase_interval_count; end
          sig { params(_purchase_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def purchase_interval_count=(_purchase_interval_count); end
          sig {
            params(average_amount: T.nilable(Integer), maximum_amount: T.nilable(Integer), minimum_amount: T.nilable(Integer), purchase_interval: T.nilable(String), purchase_interval_count: T.nilable(Integer)).void
           }
          def initialize(
            average_amount: nil,
            maximum_amount: nil,
            minimum_amount: nil,
            purchase_interval: nil,
            purchase_interval_count: nil
          ); end
        end
        class Subscription < ::Stripe::RequestParams
          class NextBilling < ::Stripe::RequestParams
            # The amount of the next charge for the subscription.
            sig { returns(Integer) }
            def amount; end
            sig { params(_amount: Integer).returns(Integer) }
            def amount=(_amount); end
            # The date of the next charge for the subscription in YYYY-MM-DD format.
            sig { returns(String) }
            def date; end
            sig { params(_date: String).returns(String) }
            def date=(_date); end
            sig { params(amount: Integer, date: String).void }
            def initialize(amount: nil, date: nil); end
          end
          # Unit of time between subscription charges.
          sig { returns(String) }
          def interval; end
          sig { params(_interval: String).returns(String) }
          def interval=(_interval); end
          # The number of intervals (specified in the `interval` attribute) between subscription charges. For example, `interval=month` and `interval_count=3` charges every 3 months.
          sig { returns(T.nilable(Integer)) }
          def interval_count; end
          sig { params(_interval_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def interval_count=(_interval_count); end
          # Name for subscription.
          sig { returns(T.nilable(String)) }
          def name; end
          sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
          def name=(_name); end
          # Describes the upcoming charge for this subscription.
          sig {
            returns(SetupIntentConfirmParams::PaymentMethodOptions::Klarna::Subscription::NextBilling)
           }
          def next_billing; end
          sig {
            params(_next_billing: SetupIntentConfirmParams::PaymentMethodOptions::Klarna::Subscription::NextBilling).returns(SetupIntentConfirmParams::PaymentMethodOptions::Klarna::Subscription::NextBilling)
           }
          def next_billing=(_next_billing); end
          # A non-customer-facing reference to correlate subscription charges in the Klarna app. Use a value that persists across subscription charges.
          sig { returns(String) }
          def reference; end
          sig { params(_reference: String).returns(String) }
          def reference=(_reference); end
          sig {
            params(interval: String, interval_count: T.nilable(Integer), name: T.nilable(String), next_billing: SetupIntentConfirmParams::PaymentMethodOptions::Klarna::Subscription::NextBilling, reference: String).void
           }
          def initialize(
            interval: nil,
            interval_count: nil,
            name: nil,
            next_billing: nil,
            reference: nil
          ); end
        end
        # The currency of the SetupIntent. Three letter ISO currency code.
        sig { returns(T.nilable(String)) }
        def currency; end
        sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
        def currency=(_currency); end
        # On-demand details if setting up a payment method for on-demand payments.
        sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Klarna::OnDemand)) }
        def on_demand; end
        sig {
          params(_on_demand: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Klarna::OnDemand)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Klarna::OnDemand))
         }
        def on_demand=(_on_demand); end
        # Preferred language of the Klarna authorization page that the customer is redirected to
        sig { returns(T.nilable(String)) }
        def preferred_locale; end
        sig { params(_preferred_locale: T.nilable(String)).returns(T.nilable(String)) }
        def preferred_locale=(_preferred_locale); end
        # Subscription details if setting up or charging a subscription
        sig {
          returns(T.nilable(T.any(String, T::Array[SetupIntentConfirmParams::PaymentMethodOptions::Klarna::Subscription])))
         }
        def subscriptions; end
        sig {
          params(_subscriptions: T.nilable(T.any(String, T::Array[SetupIntentConfirmParams::PaymentMethodOptions::Klarna::Subscription]))).returns(T.nilable(T.any(String, T::Array[SetupIntentConfirmParams::PaymentMethodOptions::Klarna::Subscription])))
         }
        def subscriptions=(_subscriptions); end
        sig {
          params(currency: T.nilable(String), on_demand: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Klarna::OnDemand), preferred_locale: T.nilable(String), subscriptions: T.nilable(T.any(String, T::Array[SetupIntentConfirmParams::PaymentMethodOptions::Klarna::Subscription]))).void
         }
        def initialize(
          currency: nil,
          on_demand: nil,
          preferred_locale: nil,
          subscriptions: nil
        ); end
      end
      class Link < ::Stripe::RequestParams
        # [Deprecated] This is a legacy parameter that no longer has any function.
        sig { returns(T.nilable(String)) }
        def persistent_token; end
        sig { params(_persistent_token: T.nilable(String)).returns(T.nilable(String)) }
        def persistent_token=(_persistent_token); end
        sig { params(persistent_token: T.nilable(String)).void }
        def initialize(persistent_token: nil); end
      end
      class Paypal < ::Stripe::RequestParams
        # The PayPal Billing Agreement ID (BAID). This is an ID generated by PayPal which represents the mandate between the merchant and the customer.
        sig { returns(T.nilable(String)) }
        def billing_agreement_id; end
        sig { params(_billing_agreement_id: T.nilable(String)).returns(T.nilable(String)) }
        def billing_agreement_id=(_billing_agreement_id); end
        sig { params(billing_agreement_id: T.nilable(String)).void }
        def initialize(billing_agreement_id: nil); end
      end
      class Payto < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # Amount that will be collected. It is required when `amount_type` is `fixed`.
          sig { returns(T.nilable(T.any(String, Integer))) }
          def amount; end
          sig {
            params(_amount: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
           }
          def amount=(_amount); end
          # The type of amount that will be collected. The amount charged must be exact or up to the value of `amount` param for `fixed` or `maximum` type respectively. Defaults to `maximum`.
          sig { returns(T.nilable(T.any(String, String))) }
          def amount_type; end
          sig {
            params(_amount_type: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
           }
          def amount_type=(_amount_type); end
          # Date, in YYYY-MM-DD format, after which payments will not be collected. Defaults to no end date.
          sig { returns(T.nilable(String)) }
          def end_date; end
          sig { params(_end_date: T.nilable(String)).returns(T.nilable(String)) }
          def end_date=(_end_date); end
          # The periodicity at which payments will be collected. Defaults to `adhoc`.
          sig { returns(T.nilable(T.any(String, String))) }
          def payment_schedule; end
          sig {
            params(_payment_schedule: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
           }
          def payment_schedule=(_payment_schedule); end
          # The number of payments that will be made during a payment period. Defaults to 1 except for when `payment_schedule` is `adhoc`. In that case, it defaults to no limit.
          sig { returns(T.nilable(T.any(String, Integer))) }
          def payments_per_period; end
          sig {
            params(_payments_per_period: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
           }
          def payments_per_period=(_payments_per_period); end
          # The purpose for which payments are made. Has a default value based on your merchant category code.
          sig { returns(T.nilable(T.any(String, String))) }
          def purpose; end
          sig {
            params(_purpose: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
           }
          def purpose=(_purpose); end
          # Date, in YYYY-MM-DD format, from which payments will be collected. Defaults to confirmation time.
          sig { returns(T.nilable(String)) }
          def start_date; end
          sig { params(_start_date: T.nilable(String)).returns(T.nilable(String)) }
          def start_date=(_start_date); end
          sig {
            params(amount: T.nilable(T.any(String, Integer)), amount_type: T.nilable(T.any(String, String)), end_date: T.nilable(String), payment_schedule: T.nilable(T.any(String, String)), payments_per_period: T.nilable(T.any(String, Integer)), purpose: T.nilable(T.any(String, String)), start_date: T.nilable(String)).void
           }
          def initialize(
            amount: nil,
            amount_type: nil,
            end_date: nil,
            payment_schedule: nil,
            payments_per_period: nil,
            purpose: nil,
            start_date: nil
          ); end
        end
        # Additional fields for Mandate creation.
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Payto::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Payto::MandateOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Payto::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        sig {
          params(mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Payto::MandateOptions)).void
         }
        def initialize(mandate_options: nil); end
      end
      class SepaDebit < ::Stripe::RequestParams
        class MandateOptions < ::Stripe::RequestParams
          # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'STRIPE'.
          sig { returns(T.nilable(String)) }
          def reference_prefix; end
          sig { params(_reference_prefix: T.nilable(String)).returns(T.nilable(String)) }
          def reference_prefix=(_reference_prefix); end
          sig { params(reference_prefix: T.nilable(String)).void }
          def initialize(reference_prefix: nil); end
        end
        # Additional fields for Mandate creation
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::SepaDebit::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::SepaDebit::MandateOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::SepaDebit::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        sig {
          params(mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::SepaDebit::MandateOptions)).void
         }
        def initialize(mandate_options: nil); end
      end
      class UsBankAccount < ::Stripe::RequestParams
        class FinancialConnections < ::Stripe::RequestParams
          class Filters < ::Stripe::RequestParams
            # The account subcategories to use to filter for selectable accounts. Valid subcategories are `checking` and `savings`.
            sig { returns(T.nilable(T::Array[String])) }
            def account_subcategories; end
            sig {
              params(_account_subcategories: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
             }
            def account_subcategories=(_account_subcategories); end
            sig { params(account_subcategories: T.nilable(T::Array[String])).void }
            def initialize(account_subcategories: nil); end
          end
          # Provide filters for the linked accounts that the customer can select for the payment method.
          sig {
            returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters))
           }
          def filters; end
          sig {
            params(_filters: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters))
           }
          def filters=(_filters); end
          # The list of permissions to request. If this parameter is passed, the `payment_method` permission must be included. Valid permissions include: `balances`, `ownership`, `payment_method`, and `transactions`.
          sig { returns(T.nilable(T::Array[String])) }
          def permissions; end
          sig {
            params(_permissions: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def permissions=(_permissions); end
          # List of data features that you would like to retrieve upon account creation.
          sig { returns(T.nilable(T::Array[String])) }
          def prefetch; end
          sig {
            params(_prefetch: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def prefetch=(_prefetch); end
          # For webview integrations only. Upon completing OAuth login in the native browser, the user will be redirected to this URL to return to your app.
          sig { returns(T.nilable(String)) }
          def return_url; end
          sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
          def return_url=(_return_url); end
          sig {
            params(filters: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters), permissions: T.nilable(T::Array[String]), prefetch: T.nilable(T::Array[String]), return_url: T.nilable(String)).void
           }
          def initialize(filters: nil, permissions: nil, prefetch: nil, return_url: nil); end
        end
        class MandateOptions < ::Stripe::RequestParams
          # The method used to collect offline mandate customer acceptance.
          sig { returns(T.nilable(String)) }
          def collection_method; end
          sig { params(_collection_method: T.nilable(String)).returns(T.nilable(String)) }
          def collection_method=(_collection_method); end
          sig { params(collection_method: T.nilable(String)).void }
          def initialize(collection_method: nil); end
        end
        class Networks < ::Stripe::RequestParams
          # Triggers validations to run across the selected networks
          sig { returns(T.nilable(T::Array[String])) }
          def requested; end
          sig {
            params(_requested: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def requested=(_requested); end
          sig { params(requested: T.nilable(T::Array[String])).void }
          def initialize(requested: nil); end
        end
        # Additional fields for Financial Connections Session creation
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::FinancialConnections))
         }
        def financial_connections; end
        sig {
          params(_financial_connections: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::FinancialConnections)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::FinancialConnections))
         }
        def financial_connections=(_financial_connections); end
        # Additional fields for Mandate creation
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::MandateOptions))
         }
        def mandate_options; end
        sig {
          params(_mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::MandateOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::MandateOptions))
         }
        def mandate_options=(_mandate_options); end
        # Additional fields for network related functions
        sig {
          returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::Networks))
         }
        def networks; end
        sig {
          params(_networks: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::Networks)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::Networks))
         }
        def networks=(_networks); end
        # Bank account verification method.
        sig { returns(T.nilable(String)) }
        def verification_method; end
        sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
        def verification_method=(_verification_method); end
        sig {
          params(financial_connections: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::FinancialConnections), mandate_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::MandateOptions), networks: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount::Networks), verification_method: T.nilable(String)).void
         }
        def initialize(
          financial_connections: nil,
          mandate_options: nil,
          networks: nil,
          verification_method: nil
        ); end
      end
      # If this is a `acss_debit` SetupIntent, this sub-hash contains details about the ACSS Debit payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AcssDebit)) }
      def acss_debit; end
      sig {
        params(_acss_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AcssDebit)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AcssDebit))
       }
      def acss_debit=(_acss_debit); end
      # If this is a `amazon_pay` SetupIntent, this sub-hash contains details about the AmazonPay payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AmazonPay)) }
      def amazon_pay; end
      sig {
        params(_amazon_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AmazonPay)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AmazonPay))
       }
      def amazon_pay=(_amazon_pay); end
      # If this is a `bacs_debit` SetupIntent, this sub-hash contains details about the Bacs Debit payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::BacsDebit)) }
      def bacs_debit; end
      sig {
        params(_bacs_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::BacsDebit)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::BacsDebit))
       }
      def bacs_debit=(_bacs_debit); end
      # Configuration for any card setup attempted on this SetupIntent.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card)) }
      def card; end
      sig {
        params(_card: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card))
       }
      def card=(_card); end
      # If this is a `card_present` PaymentMethod, this sub-hash contains details about the card-present payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::CardPresent)) }
      def card_present; end
      sig {
        params(_card_present: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::CardPresent)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::CardPresent))
       }
      def card_present=(_card_present); end
      # If this is a `klarna` PaymentMethod, this hash contains details about the Klarna payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Klarna)) }
      def klarna; end
      sig {
        params(_klarna: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Klarna)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Klarna))
       }
      def klarna=(_klarna); end
      # If this is a `link` PaymentMethod, this sub-hash contains details about the Link payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Link)) }
      def link; end
      sig {
        params(_link: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Link)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Link))
       }
      def link=(_link); end
      # If this is a `paypal` PaymentMethod, this sub-hash contains details about the PayPal payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Paypal)) }
      def paypal; end
      sig {
        params(_paypal: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Paypal)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Paypal))
       }
      def paypal=(_paypal); end
      # If this is a `payto` SetupIntent, this sub-hash contains details about the PayTo payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Payto)) }
      def payto; end
      sig {
        params(_payto: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Payto)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Payto))
       }
      def payto=(_payto); end
      # If this is a `sepa_debit` SetupIntent, this sub-hash contains details about the SEPA Debit payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::SepaDebit)) }
      def sepa_debit; end
      sig {
        params(_sepa_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::SepaDebit)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::SepaDebit))
       }
      def sepa_debit=(_sepa_debit); end
      # If this is a `us_bank_account` SetupIntent, this sub-hash contains details about the US bank account payment method options.
      sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount)) }
      def us_bank_account; end
      sig {
        params(_us_bank_account: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount))
       }
      def us_bank_account=(_us_bank_account); end
      sig {
        params(acss_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AcssDebit), amazon_pay: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::AmazonPay), bacs_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::BacsDebit), card: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Card), card_present: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::CardPresent), klarna: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Klarna), link: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Link), paypal: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Paypal), payto: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::Payto), sepa_debit: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::SepaDebit), us_bank_account: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions::UsBankAccount)).void
       }
      def initialize(
        acss_debit: nil,
        amazon_pay: nil,
        bacs_debit: nil,
        card: nil,
        card_present: nil,
        klarna: nil,
        link: nil,
        paypal: nil,
        payto: nil,
        sepa_debit: nil,
        us_bank_account: nil
      ); end
    end
    # ID of the ConfirmationToken used to confirm this SetupIntent.
    #
    # If the provided ConfirmationToken contains properties that are also being provided in this request, such as `payment_method`, then the values in this request will take precedence.
    sig { returns(T.nilable(String)) }
    def confirmation_token; end
    sig { params(_confirmation_token: T.nilable(String)).returns(T.nilable(String)) }
    def confirmation_token=(_confirmation_token); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Attribute for param field mandate_data
    sig { returns(T.nilable(T.any(String, SetupIntentConfirmParams::MandateData))) }
    def mandate_data; end
    sig {
      params(_mandate_data: T.nilable(T.any(String, SetupIntentConfirmParams::MandateData))).returns(T.nilable(T.any(String, SetupIntentConfirmParams::MandateData)))
     }
    def mandate_data=(_mandate_data); end
    # ID of the payment method (a PaymentMethod, Card, or saved Source object) to attach to this SetupIntent.
    sig { returns(T.nilable(String)) }
    def payment_method; end
    sig { params(_payment_method: T.nilable(String)).returns(T.nilable(String)) }
    def payment_method=(_payment_method); end
    # When included, this hash creates a PaymentMethod that is set as the [`payment_method`](https://docs.stripe.com/api/setup_intents/object#setup_intent_object-payment_method)
    # value in the SetupIntent.
    sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData)) }
    def payment_method_data; end
    sig {
      params(_payment_method_data: T.nilable(SetupIntentConfirmParams::PaymentMethodData)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodData))
     }
    def payment_method_data=(_payment_method_data); end
    # Payment method-specific configuration for this SetupIntent.
    sig { returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions)) }
    def payment_method_options; end
    sig {
      params(_payment_method_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions)).returns(T.nilable(SetupIntentConfirmParams::PaymentMethodOptions))
     }
    def payment_method_options=(_payment_method_options); end
    # The URL to redirect your customer back to after they authenticate on the payment method's app or site.
    # If you'd prefer to redirect to a mobile application, you can alternatively supply an application URI scheme.
    # This parameter is only used for cards and other redirect-based payment methods.
    sig { returns(T.nilable(String)) }
    def return_url; end
    sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
    def return_url=(_return_url); end
    # Set to `true` when confirming server-side and using Stripe.js, iOS, or Android client-side SDKs to handle the next actions.
    sig { returns(T.nilable(T::Boolean)) }
    def use_stripe_sdk; end
    sig { params(_use_stripe_sdk: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def use_stripe_sdk=(_use_stripe_sdk); end
    sig {
      params(confirmation_token: T.nilable(String), expand: T.nilable(T::Array[String]), mandate_data: T.nilable(T.any(String, SetupIntentConfirmParams::MandateData)), payment_method: T.nilable(String), payment_method_data: T.nilable(SetupIntentConfirmParams::PaymentMethodData), payment_method_options: T.nilable(SetupIntentConfirmParams::PaymentMethodOptions), return_url: T.nilable(String), use_stripe_sdk: T.nilable(T::Boolean)).void
     }
    def initialize(
      confirmation_token: nil,
      expand: nil,
      mandate_data: nil,
      payment_method: nil,
      payment_method_data: nil,
      payment_method_options: nil,
      return_url: nil,
      use_stripe_sdk: nil
    ); end
  end
end