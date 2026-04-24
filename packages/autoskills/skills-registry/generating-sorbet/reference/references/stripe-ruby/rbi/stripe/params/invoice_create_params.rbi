# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceCreateParams < ::Stripe::RequestParams
    class AutomaticTax < ::Stripe::RequestParams
      class Liability < ::Stripe::RequestParams
        # The connected account being referenced when `type` is `account`.
        sig { returns(T.nilable(String)) }
        def account; end
        sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
        def account=(_account); end
        # Type of the account referenced in the request.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig { params(account: T.nilable(String), type: String).void }
        def initialize(account: nil, type: nil); end
      end
      # Whether Stripe automatically computes tax on this invoice. Note that incompatible invoice items (invoice items with manually specified [tax rates](https://docs.stripe.com/api/tax_rates), negative amounts, or `tax_behavior=unspecified`) cannot be added to automatic tax invoices.
      sig { returns(T::Boolean) }
      def enabled; end
      sig { params(_enabled: T::Boolean).returns(T::Boolean) }
      def enabled=(_enabled); end
      # The account that's liable for tax. If set, the business address and tax registrations required to perform the tax calculation are loaded from this account. The tax transaction is returned in the report of the connected account.
      sig { returns(T.nilable(InvoiceCreateParams::AutomaticTax::Liability)) }
      def liability; end
      sig {
        params(_liability: T.nilable(InvoiceCreateParams::AutomaticTax::Liability)).returns(T.nilable(InvoiceCreateParams::AutomaticTax::Liability))
       }
      def liability=(_liability); end
      sig {
        params(enabled: T::Boolean, liability: T.nilable(InvoiceCreateParams::AutomaticTax::Liability)).void
       }
      def initialize(enabled: nil, liability: nil); end
    end
    class CustomField < ::Stripe::RequestParams
      # The name of the custom field. This may be up to 40 characters.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # The value of the custom field. This may be up to 140 characters.
      sig { returns(String) }
      def value; end
      sig { params(_value: String).returns(String) }
      def value=(_value); end
      sig { params(name: String, value: String).void }
      def initialize(name: nil, value: nil); end
    end
    class Discount < ::Stripe::RequestParams
      # ID of the coupon to create a new discount for.
      sig { returns(T.nilable(String)) }
      def coupon; end
      sig { params(_coupon: T.nilable(String)).returns(T.nilable(String)) }
      def coupon=(_coupon); end
      # ID of an existing discount on the object (or one of its ancestors) to reuse.
      sig { returns(T.nilable(String)) }
      def discount; end
      sig { params(_discount: T.nilable(String)).returns(T.nilable(String)) }
      def discount=(_discount); end
      # ID of the promotion code to create a new discount for.
      sig { returns(T.nilable(String)) }
      def promotion_code; end
      sig { params(_promotion_code: T.nilable(String)).returns(T.nilable(String)) }
      def promotion_code=(_promotion_code); end
      sig {
        params(coupon: T.nilable(String), discount: T.nilable(String), promotion_code: T.nilable(String)).void
       }
      def initialize(coupon: nil, discount: nil, promotion_code: nil); end
    end
    class FromInvoice < ::Stripe::RequestParams
      # The relation between the new invoice and the original invoice. Currently, only 'revision' is permitted
      sig { returns(String) }
      def action; end
      sig { params(_action: String).returns(String) }
      def action=(_action); end
      # The `id` of the invoice that will be cloned.
      sig { returns(String) }
      def invoice; end
      sig { params(_invoice: String).returns(String) }
      def invoice=(_invoice); end
      sig { params(action: String, invoice: String).void }
      def initialize(action: nil, invoice: nil); end
    end
    class Issuer < ::Stripe::RequestParams
      # The connected account being referenced when `type` is `account`.
      sig { returns(T.nilable(String)) }
      def account; end
      sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
      def account=(_account); end
      # Type of the account referenced in the request.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig { params(account: T.nilable(String), type: String).void }
      def initialize(account: nil, type: nil); end
    end
    class PaymentSettings < ::Stripe::RequestParams
      class PaymentMethodOptions < ::Stripe::RequestParams
        class AcssDebit < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # Transaction type of the mandate.
            sig { returns(T.nilable(String)) }
            def transaction_type; end
            sig { params(_transaction_type: T.nilable(String)).returns(T.nilable(String)) }
            def transaction_type=(_transaction_type); end
            sig { params(transaction_type: T.nilable(String)).void }
            def initialize(transaction_type: nil); end
          end
          # Additional fields for Mandate creation
          sig {
            returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::AcssDebit::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::AcssDebit::MandateOptions)).returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::AcssDebit::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          # Verification method for the intent
          sig { returns(T.nilable(String)) }
          def verification_method; end
          sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
          def verification_method=(_verification_method); end
          sig {
            params(mandate_options: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::AcssDebit::MandateOptions), verification_method: T.nilable(String)).void
           }
          def initialize(mandate_options: nil, verification_method: nil); end
        end
        class Bancontact < ::Stripe::RequestParams
          # Preferred language of the Bancontact authorization page that the customer is redirected to.
          sig { returns(T.nilable(String)) }
          def preferred_language; end
          sig { params(_preferred_language: T.nilable(String)).returns(T.nilable(String)) }
          def preferred_language=(_preferred_language); end
          sig { params(preferred_language: T.nilable(String)).void }
          def initialize(preferred_language: nil); end
        end
        class Card < ::Stripe::RequestParams
          class Installments < ::Stripe::RequestParams
            class Plan < ::Stripe::RequestParams
              # For `fixed_count` installment plans, this is required. It represents the number of installment payments your customer will make to their credit card.
              sig { returns(T.nilable(Integer)) }
              def count; end
              sig { params(_count: T.nilable(Integer)).returns(T.nilable(Integer)) }
              def count=(_count); end
              # For `fixed_count` installment plans, this is required. It represents the interval between installment payments your customer will make to their credit card.
              # One of `month`.
              sig { returns(T.nilable(String)) }
              def interval; end
              sig { params(_interval: T.nilable(String)).returns(T.nilable(String)) }
              def interval=(_interval); end
              # Type of installment plan, one of `fixed_count`, `bonus`, or `revolving`.
              sig { returns(String) }
              def type; end
              sig { params(_type: String).returns(String) }
              def type=(_type); end
              sig {
                params(count: T.nilable(Integer), interval: T.nilable(String), type: String).void
               }
              def initialize(count: nil, interval: nil, type: nil); end
            end
            # Setting to true enables installments for this invoice.
            # Setting to false will prevent any selected plan from applying to a payment.
            sig { returns(T.nilable(T::Boolean)) }
            def enabled; end
            sig { params(_enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
            def enabled=(_enabled); end
            # The selected installment plan to use for this invoice.
            sig {
              returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card::Installments::Plan)))
             }
            def plan; end
            sig {
              params(_plan: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card::Installments::Plan))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card::Installments::Plan)))
             }
            def plan=(_plan); end
            sig {
              params(enabled: T.nilable(T::Boolean), plan: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card::Installments::Plan))).void
             }
            def initialize(enabled: nil, plan: nil); end
          end
          # Installment configuration for payments attempted on this invoice.
          #
          # For more information, see the [installments integration guide](https://docs.stripe.com/payments/installments).
          sig {
            returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card::Installments))
           }
          def installments; end
          sig {
            params(_installments: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card::Installments)).returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card::Installments))
           }
          def installments=(_installments); end
          # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
          sig { returns(T.nilable(String)) }
          def request_three_d_secure; end
          sig { params(_request_three_d_secure: T.nilable(String)).returns(T.nilable(String)) }
          def request_three_d_secure=(_request_three_d_secure); end
          sig {
            params(installments: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card::Installments), request_three_d_secure: T.nilable(String)).void
           }
          def initialize(installments: nil, request_three_d_secure: nil); end
        end
        class CustomerBalance < ::Stripe::RequestParams
          class BankTransfer < ::Stripe::RequestParams
            class EuBankTransfer < ::Stripe::RequestParams
              # The desired country code of the bank account information. Permitted values include: `BE`, `DE`, `ES`, `FR`, `IE`, or `NL`.
              sig { returns(String) }
              def country; end
              sig { params(_country: String).returns(String) }
              def country=(_country); end
              sig { params(country: String).void }
              def initialize(country: nil); end
            end
            # Configuration for eu_bank_transfer funding type.
            sig {
              returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer))
             }
            def eu_bank_transfer; end
            sig {
              params(_eu_bank_transfer: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer)).returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer))
             }
            def eu_bank_transfer=(_eu_bank_transfer); end
            # The bank transfer type that can be used for funding. Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, `mx_bank_transfer`, or `us_bank_transfer`.
            sig { returns(T.nilable(String)) }
            def type; end
            sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
            def type=(_type); end
            sig {
              params(eu_bank_transfer: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer::EuBankTransfer), type: T.nilable(String)).void
             }
            def initialize(eu_bank_transfer: nil, type: nil); end
          end
          # Configuration for the bank transfer funding type, if the `funding_type` is set to `bank_transfer`.
          sig {
            returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer))
           }
          def bank_transfer; end
          sig {
            params(_bank_transfer: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer)).returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer))
           }
          def bank_transfer=(_bank_transfer); end
          # The funding method type to be used when there are not enough funds in the customer balance. Permitted values include: `bank_transfer`.
          sig { returns(T.nilable(String)) }
          def funding_type; end
          sig { params(_funding_type: T.nilable(String)).returns(T.nilable(String)) }
          def funding_type=(_funding_type); end
          sig {
            params(bank_transfer: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance::BankTransfer), funding_type: T.nilable(String)).void
           }
          def initialize(bank_transfer: nil, funding_type: nil); end
        end
        class Konbini < ::Stripe::RequestParams; end
        class Payto < ::Stripe::RequestParams
          class MandateOptions < ::Stripe::RequestParams
            # The maximum amount that can be collected in a single invoice. If you don't specify a maximum, then there is no limit.
            sig { returns(T.nilable(Integer)) }
            def amount; end
            sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def amount=(_amount); end
            # The purpose for which payments are made. Has a default value based on your merchant category code.
            sig { returns(T.nilable(String)) }
            def purpose; end
            sig { params(_purpose: T.nilable(String)).returns(T.nilable(String)) }
            def purpose=(_purpose); end
            sig { params(amount: T.nilable(Integer), purpose: T.nilable(String)).void }
            def initialize(amount: nil, purpose: nil); end
          end
          # Additional fields for Mandate creation.
          sig {
            returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Payto::MandateOptions))
           }
          def mandate_options; end
          sig {
            params(_mandate_options: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Payto::MandateOptions)).returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Payto::MandateOptions))
           }
          def mandate_options=(_mandate_options); end
          sig {
            params(mandate_options: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Payto::MandateOptions)).void
           }
          def initialize(mandate_options: nil); end
        end
        class SepaDebit < ::Stripe::RequestParams; end
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
              returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters))
             }
            def filters; end
            sig {
              params(_filters: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters)).returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters))
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
            sig {
              params(filters: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections::Filters), permissions: T.nilable(T::Array[String]), prefetch: T.nilable(T::Array[String])).void
             }
            def initialize(filters: nil, permissions: nil, prefetch: nil); end
          end
          # Additional fields for Financial Connections Session creation
          sig {
            returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections))
           }
          def financial_connections; end
          sig {
            params(_financial_connections: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections)).returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections))
           }
          def financial_connections=(_financial_connections); end
          # Verification method for the intent
          sig { returns(T.nilable(String)) }
          def verification_method; end
          sig { params(_verification_method: T.nilable(String)).returns(T.nilable(String)) }
          def verification_method=(_verification_method); end
          sig {
            params(financial_connections: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount::FinancialConnections), verification_method: T.nilable(String)).void
           }
          def initialize(financial_connections: nil, verification_method: nil); end
        end
        # If paying by `acss_debit`, this sub-hash contains details about the Canadian pre-authorized debit payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::AcssDebit)))
         }
        def acss_debit; end
        sig {
          params(_acss_debit: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::AcssDebit))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::AcssDebit)))
         }
        def acss_debit=(_acss_debit); end
        # If paying by `bancontact`, this sub-hash contains details about the Bancontact payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Bancontact)))
         }
        def bancontact; end
        sig {
          params(_bancontact: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Bancontact))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Bancontact)))
         }
        def bancontact=(_bancontact); end
        # If paying by `card`, this sub-hash contains details about the Card payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card)))
         }
        def card; end
        sig {
          params(_card: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card)))
         }
        def card=(_card); end
        # If paying by `customer_balance`, this sub-hash contains details about the Bank transfer payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance)))
         }
        def customer_balance; end
        sig {
          params(_customer_balance: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance)))
         }
        def customer_balance=(_customer_balance); end
        # If paying by `konbini`, this sub-hash contains details about the Konbini payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Konbini)))
         }
        def konbini; end
        sig {
          params(_konbini: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Konbini))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Konbini)))
         }
        def konbini=(_konbini); end
        # If paying by `payto`, this sub-hash contains details about the PayTo payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Payto)))
         }
        def payto; end
        sig {
          params(_payto: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Payto))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Payto)))
         }
        def payto=(_payto); end
        # If paying by `sepa_debit`, this sub-hash contains details about the SEPA Direct Debit payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::SepaDebit)))
         }
        def sepa_debit; end
        sig {
          params(_sepa_debit: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::SepaDebit))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::SepaDebit)))
         }
        def sepa_debit=(_sepa_debit); end
        # If paying by `us_bank_account`, this sub-hash contains details about the ACH direct debit payment method options to pass to the invoice’s PaymentIntent.
        sig {
          returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount)))
         }
        def us_bank_account; end
        sig {
          params(_us_bank_account: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount))).returns(T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount)))
         }
        def us_bank_account=(_us_bank_account); end
        sig {
          params(acss_debit: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::AcssDebit)), bancontact: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Bancontact)), card: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Card)), customer_balance: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::CustomerBalance)), konbini: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Konbini)), payto: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::Payto)), sepa_debit: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::SepaDebit)), us_bank_account: T.nilable(T.any(String, InvoiceCreateParams::PaymentSettings::PaymentMethodOptions::UsBankAccount))).void
         }
        def initialize(
          acss_debit: nil,
          bancontact: nil,
          card: nil,
          customer_balance: nil,
          konbini: nil,
          payto: nil,
          sepa_debit: nil,
          us_bank_account: nil
        ); end
      end
      # ID of the mandate to be used for this invoice. It must correspond to the payment method used to pay the invoice, including the invoice's default_payment_method or default_source, if set.
      sig { returns(T.nilable(String)) }
      def default_mandate; end
      sig { params(_default_mandate: T.nilable(String)).returns(T.nilable(String)) }
      def default_mandate=(_default_mandate); end
      # Payment-method-specific configuration to provide to the invoice’s PaymentIntent.
      sig { returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions)) }
      def payment_method_options; end
      sig {
        params(_payment_method_options: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions)).returns(T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions))
       }
      def payment_method_options=(_payment_method_options); end
      # The list of payment method types (e.g. card) to provide to the invoice’s PaymentIntent. If not set, Stripe attempts to automatically determine the types to use by looking at the invoice’s default payment method, the subscription’s default payment method, the customer’s default payment method, and your [invoice template settings](https://dashboard.stripe.com/settings/billing/invoice).
      sig { returns(T.nilable(T.any(String, T::Array[String]))) }
      def payment_method_types; end
      sig {
        params(_payment_method_types: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
       }
      def payment_method_types=(_payment_method_types); end
      sig {
        params(default_mandate: T.nilable(String), payment_method_options: T.nilable(InvoiceCreateParams::PaymentSettings::PaymentMethodOptions), payment_method_types: T.nilable(T.any(String, T::Array[String]))).void
       }
      def initialize(
        default_mandate: nil,
        payment_method_options: nil,
        payment_method_types: nil
      ); end
    end
    class Rendering < ::Stripe::RequestParams
      class Pdf < ::Stripe::RequestParams
        # Page size for invoice PDF. Can be set to `a4`, `letter`, or `auto`.
        #  If set to `auto`, invoice PDF page size defaults to `a4` for customers with
        #  Japanese locale and `letter` for customers with other locales.
        sig { returns(T.nilable(String)) }
        def page_size; end
        sig { params(_page_size: T.nilable(String)).returns(T.nilable(String)) }
        def page_size=(_page_size); end
        sig { params(page_size: T.nilable(String)).void }
        def initialize(page_size: nil); end
      end
      # How line-item prices and amounts will be displayed with respect to tax on invoice PDFs. One of `exclude_tax` or `include_inclusive_tax`. `include_inclusive_tax` will include inclusive tax (and exclude exclusive tax) in invoice PDF amounts. `exclude_tax` will exclude all tax (inclusive and exclusive alike) from invoice PDF amounts.
      sig { returns(T.nilable(T.any(String, String))) }
      def amount_tax_display; end
      sig {
        params(_amount_tax_display: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
       }
      def amount_tax_display=(_amount_tax_display); end
      # Invoice pdf rendering options
      sig { returns(T.nilable(InvoiceCreateParams::Rendering::Pdf)) }
      def pdf; end
      sig {
        params(_pdf: T.nilable(InvoiceCreateParams::Rendering::Pdf)).returns(T.nilable(InvoiceCreateParams::Rendering::Pdf))
       }
      def pdf=(_pdf); end
      # ID of the invoice rendering template to use for this invoice.
      sig { returns(T.nilable(String)) }
      def template; end
      sig { params(_template: T.nilable(String)).returns(T.nilable(String)) }
      def template=(_template); end
      # The specific version of invoice rendering template to use for this invoice.
      sig { returns(T.nilable(T.any(String, Integer))) }
      def template_version; end
      sig {
        params(_template_version: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
       }
      def template_version=(_template_version); end
      sig {
        params(amount_tax_display: T.nilable(T.any(String, String)), pdf: T.nilable(InvoiceCreateParams::Rendering::Pdf), template: T.nilable(String), template_version: T.nilable(T.any(String, Integer))).void
       }
      def initialize(amount_tax_display: nil, pdf: nil, template: nil, template_version: nil); end
    end
    class ShippingCost < ::Stripe::RequestParams
      class ShippingRateData < ::Stripe::RequestParams
        class DeliveryEstimate < ::Stripe::RequestParams
          class Maximum < ::Stripe::RequestParams
            # A unit of time.
            sig { returns(String) }
            def unit; end
            sig { params(_unit: String).returns(String) }
            def unit=(_unit); end
            # Must be greater than 0.
            sig { returns(Integer) }
            def value; end
            sig { params(_value: Integer).returns(Integer) }
            def value=(_value); end
            sig { params(unit: String, value: Integer).void }
            def initialize(unit: nil, value: nil); end
          end
          class Minimum < ::Stripe::RequestParams
            # A unit of time.
            sig { returns(String) }
            def unit; end
            sig { params(_unit: String).returns(String) }
            def unit=(_unit); end
            # Must be greater than 0.
            sig { returns(Integer) }
            def value; end
            sig { params(_value: Integer).returns(Integer) }
            def value=(_value); end
            sig { params(unit: String, value: Integer).void }
            def initialize(unit: nil, value: nil); end
          end
          # The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite.
          sig {
            returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate::Maximum))
           }
          def maximum; end
          sig {
            params(_maximum: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate::Maximum)).returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate::Maximum))
           }
          def maximum=(_maximum); end
          # The lower bound of the estimated range. If empty, represents no lower bound.
          sig {
            returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate::Minimum))
           }
          def minimum; end
          sig {
            params(_minimum: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate::Minimum)).returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate::Minimum))
           }
          def minimum=(_minimum); end
          sig {
            params(maximum: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate::Maximum), minimum: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate::Minimum)).void
           }
          def initialize(maximum: nil, minimum: nil); end
        end
        class FixedAmount < ::Stripe::RequestParams
          class CurrencyOptions < ::Stripe::RequestParams
            # A non-negative integer in cents representing how much to charge.
            sig { returns(Integer) }
            def amount; end
            sig { params(_amount: Integer).returns(Integer) }
            def amount=(_amount); end
            # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
            sig { returns(T.nilable(String)) }
            def tax_behavior; end
            sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
            def tax_behavior=(_tax_behavior); end
            sig { params(amount: Integer, tax_behavior: T.nilable(String)).void }
            def initialize(amount: nil, tax_behavior: nil); end
          end
          # A non-negative integer in cents representing how much to charge.
          sig { returns(Integer) }
          def amount; end
          sig { params(_amount: Integer).returns(Integer) }
          def amount=(_amount); end
          # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
          sig { returns(String) }
          def currency; end
          sig { params(_currency: String).returns(String) }
          def currency=(_currency); end
          # Shipping rates defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
          sig {
            returns(T.nilable(T::Hash[String, InvoiceCreateParams::ShippingCost::ShippingRateData::FixedAmount::CurrencyOptions]))
           }
          def currency_options; end
          sig {
            params(_currency_options: T.nilable(T::Hash[String, InvoiceCreateParams::ShippingCost::ShippingRateData::FixedAmount::CurrencyOptions])).returns(T.nilable(T::Hash[String, InvoiceCreateParams::ShippingCost::ShippingRateData::FixedAmount::CurrencyOptions]))
           }
          def currency_options=(_currency_options); end
          sig {
            params(amount: Integer, currency: String, currency_options: T.nilable(T::Hash[String, InvoiceCreateParams::ShippingCost::ShippingRateData::FixedAmount::CurrencyOptions])).void
           }
          def initialize(amount: nil, currency: nil, currency_options: nil); end
        end
        # The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
        sig {
          returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate))
         }
        def delivery_estimate; end
        sig {
          params(_delivery_estimate: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate)).returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate))
         }
        def delivery_estimate=(_delivery_estimate); end
        # The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
        sig { returns(String) }
        def display_name; end
        sig { params(_display_name: String).returns(String) }
        def display_name=(_display_name); end
        # Describes a fixed amount to charge for shipping. Must be present if type is `fixed_amount`.
        sig { returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::FixedAmount)) }
        def fixed_amount; end
        sig {
          params(_fixed_amount: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::FixedAmount)).returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::FixedAmount))
         }
        def fixed_amount=(_fixed_amount); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
        sig { returns(T.nilable(String)) }
        def tax_behavior; end
        sig { params(_tax_behavior: T.nilable(String)).returns(T.nilable(String)) }
        def tax_behavior=(_tax_behavior); end
        # A [tax code](https://docs.stripe.com/tax/tax-categories) ID. The Shipping tax code is `txcd_92010001`.
        sig { returns(T.nilable(String)) }
        def tax_code; end
        sig { params(_tax_code: T.nilable(String)).returns(T.nilable(String)) }
        def tax_code=(_tax_code); end
        # The type of calculation to use on the shipping rate.
        sig { returns(T.nilable(String)) }
        def type; end
        sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
        def type=(_type); end
        sig {
          params(delivery_estimate: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::DeliveryEstimate), display_name: String, fixed_amount: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData::FixedAmount), metadata: T.nilable(T::Hash[String, String]), tax_behavior: T.nilable(String), tax_code: T.nilable(String), type: T.nilable(String)).void
         }
        def initialize(
          delivery_estimate: nil,
          display_name: nil,
          fixed_amount: nil,
          metadata: nil,
          tax_behavior: nil,
          tax_code: nil,
          type: nil
        ); end
      end
      # The ID of the shipping rate to use for this order.
      sig { returns(T.nilable(String)) }
      def shipping_rate; end
      sig { params(_shipping_rate: T.nilable(String)).returns(T.nilable(String)) }
      def shipping_rate=(_shipping_rate); end
      # Parameters to create a new ad-hoc shipping rate for this order.
      sig { returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData)) }
      def shipping_rate_data; end
      sig {
        params(_shipping_rate_data: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData)).returns(T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData))
       }
      def shipping_rate_data=(_shipping_rate_data); end
      sig {
        params(shipping_rate: T.nilable(String), shipping_rate_data: T.nilable(InvoiceCreateParams::ShippingCost::ShippingRateData)).void
       }
      def initialize(shipping_rate: nil, shipping_rate_data: nil); end
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
      # Shipping address
      sig { returns(InvoiceCreateParams::ShippingDetails::Address) }
      def address; end
      sig {
        params(_address: InvoiceCreateParams::ShippingDetails::Address).returns(InvoiceCreateParams::ShippingDetails::Address)
       }
      def address=(_address); end
      # Recipient name.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # Recipient phone (including extension)
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      sig {
        params(address: InvoiceCreateParams::ShippingDetails::Address, name: String, phone: T.nilable(String)).void
       }
      def initialize(address: nil, name: nil, phone: nil); end
    end
    class TransferData < ::Stripe::RequestParams
      # The amount that will be transferred automatically when the invoice is paid. If no amount is set, the full amount is transferred.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      # ID of an existing, connected Stripe account.
      sig { returns(String) }
      def destination; end
      sig { params(_destination: String).returns(String) }
      def destination=(_destination); end
      sig { params(amount: T.nilable(Integer), destination: String).void }
      def initialize(amount: nil, destination: nil); end
    end
    # The account tax IDs associated with the invoice. Only editable when the invoice is a draft.
    sig { returns(T.nilable(T.any(String, T::Array[String]))) }
    def account_tax_ids; end
    sig {
      params(_account_tax_ids: T.nilable(T.any(String, T::Array[String]))).returns(T.nilable(T.any(String, T::Array[String])))
     }
    def account_tax_ids=(_account_tax_ids); end
    # A fee in cents (or local equivalent) that will be applied to the invoice and transferred to the application owner's Stripe account. The request must be made with an OAuth key or the Stripe-Account header in order to take an application fee. For more information, see the application fees [documentation](https://docs.stripe.com/billing/invoices/connect#collecting-fees).
    sig { returns(T.nilable(Integer)) }
    def application_fee_amount; end
    sig { params(_application_fee_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def application_fee_amount=(_application_fee_amount); end
    # Controls whether Stripe performs [automatic collection](https://docs.stripe.com/invoicing/integration/automatic-advancement-collection) of the invoice. If `false`, the invoice's state doesn't automatically advance without an explicit action. Defaults to false.
    sig { returns(T.nilable(T::Boolean)) }
    def auto_advance; end
    sig { params(_auto_advance: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def auto_advance=(_auto_advance); end
    # Settings for automatic tax lookup for this invoice.
    sig { returns(T.nilable(InvoiceCreateParams::AutomaticTax)) }
    def automatic_tax; end
    sig {
      params(_automatic_tax: T.nilable(InvoiceCreateParams::AutomaticTax)).returns(T.nilable(InvoiceCreateParams::AutomaticTax))
     }
    def automatic_tax=(_automatic_tax); end
    # The time when this invoice should be scheduled to finalize (up to 5 years in the future). The invoice is finalized at this time if it's still in draft state.
    sig { returns(T.nilable(Integer)) }
    def automatically_finalizes_at; end
    sig { params(_automatically_finalizes_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def automatically_finalizes_at=(_automatically_finalizes_at); end
    # Either `charge_automatically`, or `send_invoice`. When charging automatically, Stripe will attempt to pay this invoice using the default source attached to the customer. When sending an invoice, Stripe will email this invoice to the customer with payment instructions. Defaults to `charge_automatically`.
    sig { returns(T.nilable(String)) }
    def collection_method; end
    sig { params(_collection_method: T.nilable(String)).returns(T.nilable(String)) }
    def collection_method=(_collection_method); end
    # The currency to create this invoice in. Defaults to that of `customer` if not specified.
    sig { returns(T.nilable(String)) }
    def currency; end
    sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
    def currency=(_currency); end
    # A list of up to 4 custom fields to be displayed on the invoice.
    sig { returns(T.nilable(T.any(String, T::Array[InvoiceCreateParams::CustomField]))) }
    def custom_fields; end
    sig {
      params(_custom_fields: T.nilable(T.any(String, T::Array[InvoiceCreateParams::CustomField]))).returns(T.nilable(T.any(String, T::Array[InvoiceCreateParams::CustomField])))
     }
    def custom_fields=(_custom_fields); end
    # The ID of the customer to bill.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # The ID of the account to bill.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
    def customer_account=(_customer_account); end
    # The number of days from when the invoice is created until it is due. Valid only for invoices where `collection_method=send_invoice`.
    sig { returns(T.nilable(Integer)) }
    def days_until_due; end
    sig { params(_days_until_due: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def days_until_due=(_days_until_due); end
    # ID of the default payment method for the invoice. It must belong to the customer associated with the invoice. If not set, defaults to the subscription's default payment method, if any, or to the default payment method in the customer's invoice settings.
    sig { returns(T.nilable(String)) }
    def default_payment_method; end
    sig { params(_default_payment_method: T.nilable(String)).returns(T.nilable(String)) }
    def default_payment_method=(_default_payment_method); end
    # ID of the default payment source for the invoice. It must belong to the customer associated with the invoice and be in a chargeable state. If not set, defaults to the subscription's default source, if any, or to the customer's default source.
    sig { returns(T.nilable(String)) }
    def default_source; end
    sig { params(_default_source: T.nilable(String)).returns(T.nilable(String)) }
    def default_source=(_default_source); end
    # The tax rates that will apply to any line item that does not have `tax_rates` set.
    sig { returns(T.nilable(T::Array[String])) }
    def default_tax_rates; end
    sig {
      params(_default_tax_rates: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
     }
    def default_tax_rates=(_default_tax_rates); end
    # An arbitrary string attached to the object. Often useful for displaying to users. Referenced as 'memo' in the Dashboard.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # The coupons and promotion codes to redeem into discounts for the invoice. If not specified, inherits the discount from the invoice's customer. Pass an empty string to avoid inheriting any discounts.
    sig { returns(T.nilable(T.any(String, T::Array[InvoiceCreateParams::Discount]))) }
    def discounts; end
    sig {
      params(_discounts: T.nilable(T.any(String, T::Array[InvoiceCreateParams::Discount]))).returns(T.nilable(T.any(String, T::Array[InvoiceCreateParams::Discount])))
     }
    def discounts=(_discounts); end
    # The date on which payment for this invoice is due. Valid only for invoices where `collection_method=send_invoice`.
    sig { returns(T.nilable(Integer)) }
    def due_date; end
    sig { params(_due_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def due_date=(_due_date); end
    # The date when this invoice is in effect. Same as `finalized_at` unless overwritten. When defined, this value replaces the system-generated 'Date of issue' printed on the invoice PDF and receipt.
    sig { returns(T.nilable(Integer)) }
    def effective_at; end
    sig { params(_effective_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def effective_at=(_effective_at); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Footer to be displayed on the invoice.
    sig { returns(T.nilable(String)) }
    def footer; end
    sig { params(_footer: T.nilable(String)).returns(T.nilable(String)) }
    def footer=(_footer); end
    # Revise an existing invoice. The new invoice will be created in `status=draft`. See the [revision documentation](https://docs.stripe.com/invoicing/invoice-revisions) for more details.
    sig { returns(T.nilable(InvoiceCreateParams::FromInvoice)) }
    def from_invoice; end
    sig {
      params(_from_invoice: T.nilable(InvoiceCreateParams::FromInvoice)).returns(T.nilable(InvoiceCreateParams::FromInvoice))
     }
    def from_invoice=(_from_invoice); end
    # The connected account that issues the invoice. The invoice is presented with the branding and support information of the specified account.
    sig { returns(T.nilable(InvoiceCreateParams::Issuer)) }
    def issuer; end
    sig {
      params(_issuer: T.nilable(InvoiceCreateParams::Issuer)).returns(T.nilable(InvoiceCreateParams::Issuer))
     }
    def issuer=(_issuer); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # Set the number for this invoice. If no number is present then a number will be assigned automatically when the invoice is finalized. In many markets, regulations require invoices to be unique, sequential and / or gapless. You are responsible for ensuring this is true across all your different invoicing systems in the event that you edit the invoice number using our API. If you use only Stripe for your invoices and do not change invoice numbers, Stripe handles this aspect of compliance for you automatically.
    sig { returns(T.nilable(String)) }
    def number; end
    sig { params(_number: T.nilable(String)).returns(T.nilable(String)) }
    def number=(_number); end
    # The account (if any) for which the funds of the invoice payment are intended. If set, the invoice will be presented with the branding and support information of the specified account. See the [Invoices with Connect](https://docs.stripe.com/billing/invoices/connect) documentation for details.
    sig { returns(T.nilable(String)) }
    def on_behalf_of; end
    sig { params(_on_behalf_of: T.nilable(String)).returns(T.nilable(String)) }
    def on_behalf_of=(_on_behalf_of); end
    # Configuration settings for the PaymentIntent that is generated when the invoice is finalized.
    sig { returns(T.nilable(InvoiceCreateParams::PaymentSettings)) }
    def payment_settings; end
    sig {
      params(_payment_settings: T.nilable(InvoiceCreateParams::PaymentSettings)).returns(T.nilable(InvoiceCreateParams::PaymentSettings))
     }
    def payment_settings=(_payment_settings); end
    # How to handle pending invoice items on invoice creation. Defaults to `exclude` if the parameter is omitted.
    sig { returns(T.nilable(String)) }
    def pending_invoice_items_behavior; end
    sig { params(_pending_invoice_items_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def pending_invoice_items_behavior=(_pending_invoice_items_behavior); end
    # The rendering-related settings that control how the invoice is displayed on customer-facing surfaces such as PDF and Hosted Invoice Page.
    sig { returns(T.nilable(InvoiceCreateParams::Rendering)) }
    def rendering; end
    sig {
      params(_rendering: T.nilable(InvoiceCreateParams::Rendering)).returns(T.nilable(InvoiceCreateParams::Rendering))
     }
    def rendering=(_rendering); end
    # Settings for the cost of shipping for this invoice.
    sig { returns(T.nilable(InvoiceCreateParams::ShippingCost)) }
    def shipping_cost; end
    sig {
      params(_shipping_cost: T.nilable(InvoiceCreateParams::ShippingCost)).returns(T.nilable(InvoiceCreateParams::ShippingCost))
     }
    def shipping_cost=(_shipping_cost); end
    # Shipping details for the invoice. The Invoice PDF will use the `shipping_details` value if it is set, otherwise the PDF will render the shipping address from the customer.
    sig { returns(T.nilable(InvoiceCreateParams::ShippingDetails)) }
    def shipping_details; end
    sig {
      params(_shipping_details: T.nilable(InvoiceCreateParams::ShippingDetails)).returns(T.nilable(InvoiceCreateParams::ShippingDetails))
     }
    def shipping_details=(_shipping_details); end
    # Extra information about a charge for the customer's credit card statement. It must contain at least one letter. If not specified and this invoice is part of a subscription, the default `statement_descriptor` will be set to the first subscription item's product's `statement_descriptor`.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor=(_statement_descriptor); end
    # The ID of the subscription to invoice, if any. If set, the created invoice will only include pending invoice items for that subscription. The subscription's billing cycle and regular subscription events won't be affected.
    sig { returns(T.nilable(String)) }
    def subscription; end
    sig { params(_subscription: T.nilable(String)).returns(T.nilable(String)) }
    def subscription=(_subscription); end
    # If specified, the funds from the invoice will be transferred to the destination and the ID of the resulting transfer will be found on the invoice's charge.
    sig { returns(T.nilable(InvoiceCreateParams::TransferData)) }
    def transfer_data; end
    sig {
      params(_transfer_data: T.nilable(InvoiceCreateParams::TransferData)).returns(T.nilable(InvoiceCreateParams::TransferData))
     }
    def transfer_data=(_transfer_data); end
    sig {
      params(account_tax_ids: T.nilable(T.any(String, T::Array[String])), application_fee_amount: T.nilable(Integer), auto_advance: T.nilable(T::Boolean), automatic_tax: T.nilable(InvoiceCreateParams::AutomaticTax), automatically_finalizes_at: T.nilable(Integer), collection_method: T.nilable(String), currency: T.nilable(String), custom_fields: T.nilable(T.any(String, T::Array[InvoiceCreateParams::CustomField])), customer: T.nilable(String), customer_account: T.nilable(String), days_until_due: T.nilable(Integer), default_payment_method: T.nilable(String), default_source: T.nilable(String), default_tax_rates: T.nilable(T::Array[String]), description: T.nilable(String), discounts: T.nilable(T.any(String, T::Array[InvoiceCreateParams::Discount])), due_date: T.nilable(Integer), effective_at: T.nilable(Integer), expand: T.nilable(T::Array[String]), footer: T.nilable(String), from_invoice: T.nilable(InvoiceCreateParams::FromInvoice), issuer: T.nilable(InvoiceCreateParams::Issuer), metadata: T.nilable(T.any(String, T::Hash[String, String])), number: T.nilable(String), on_behalf_of: T.nilable(String), payment_settings: T.nilable(InvoiceCreateParams::PaymentSettings), pending_invoice_items_behavior: T.nilable(String), rendering: T.nilable(InvoiceCreateParams::Rendering), shipping_cost: T.nilable(InvoiceCreateParams::ShippingCost), shipping_details: T.nilable(InvoiceCreateParams::ShippingDetails), statement_descriptor: T.nilable(String), subscription: T.nilable(String), transfer_data: T.nilable(InvoiceCreateParams::TransferData)).void
     }
    def initialize(
      account_tax_ids: nil,
      application_fee_amount: nil,
      auto_advance: nil,
      automatic_tax: nil,
      automatically_finalizes_at: nil,
      collection_method: nil,
      currency: nil,
      custom_fields: nil,
      customer: nil,
      customer_account: nil,
      days_until_due: nil,
      default_payment_method: nil,
      default_source: nil,
      default_tax_rates: nil,
      description: nil,
      discounts: nil,
      due_date: nil,
      effective_at: nil,
      expand: nil,
      footer: nil,
      from_invoice: nil,
      issuer: nil,
      metadata: nil,
      number: nil,
      on_behalf_of: nil,
      payment_settings: nil,
      pending_invoice_items_behavior: nil,
      rendering: nil,
      shipping_cost: nil,
      shipping_details: nil,
      statement_descriptor: nil,
      subscription: nil,
      transfer_data: nil
    ); end
  end
end