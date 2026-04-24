# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # ConfirmationTokens help transport client side data collected by Stripe JS over
  # to your server for confirming a PaymentIntent or SetupIntent. If the confirmation
  # is successful, values present on the ConfirmationToken are written onto the Intent.
  #
  # To learn more about how to use ConfirmationToken, visit the related guides:
  # - [Finalize payments on the server](https://docs.stripe.com/payments/finalize-payments-on-the-server)
  # - [Build two-step confirmation](https://docs.stripe.com/payments/build-a-two-step-confirmation).
  class ConfirmationToken < APIResource
    class MandateData < ::Stripe::StripeObject
      class CustomerAcceptance < ::Stripe::StripeObject
        class Online < ::Stripe::StripeObject
          # The IP address from which the Mandate was accepted by the customer.
          sig { returns(T.nilable(String)) }
          def ip_address; end
          # The user agent of the browser from which the Mandate was accepted by the customer.
          sig { returns(T.nilable(String)) }
          def user_agent; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # If this is a Mandate accepted online, this hash contains details about the online acceptance.
        sig { returns(T.nilable(Online)) }
        def online; end
        # The type of customer acceptance information included with the Mandate.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {online: Online}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # This hash contains details about the customer acceptance of the Mandate.
      sig { returns(CustomerAcceptance) }
      def customer_acceptance; end
      def self.inner_class_types
        @inner_class_types = {customer_acceptance: CustomerAcceptance}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaymentMethodOptions < ::Stripe::StripeObject
      class Card < ::Stripe::StripeObject
        class Installments < ::Stripe::StripeObject
          class Plan < ::Stripe::StripeObject
            # For `fixed_count` installment plans, this is the number of installment payments your customer will make to their credit card.
            sig { returns(T.nilable(Integer)) }
            def count; end
            # For `fixed_count` installment plans, this is the interval between installment payments your customer will make to their credit card.
            # One of `month`.
            sig { returns(T.nilable(String)) }
            def interval; end
            # Type of installment plan, one of `fixed_count`, `bonus`, or `revolving`.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field plan
          sig { returns(T.nilable(Plan)) }
          def plan; end
          def self.inner_class_types
            @inner_class_types = {plan: Plan}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The `cvc_update` Token collected from the Payment Element.
        sig { returns(T.nilable(String)) }
        def cvc_token; end
        # Installment configuration for payments.
        sig { returns(T.nilable(Installments)) }
        def installments; end
        def self.inner_class_types
          @inner_class_types = {installments: Installments}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # This hash contains the card payment method options.
      sig { returns(T.nilable(Card)) }
      def card; end
      def self.inner_class_types
        @inner_class_types = {card: Card}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaymentMethodPreview < ::Stripe::StripeObject
      class AcssDebit < ::Stripe::StripeObject
        # Name of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Institution number of the bank account.
        sig { returns(T.nilable(String)) }
        def institution_number; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # Transit number of the bank account.
        sig { returns(T.nilable(String)) }
        def transit_number; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Affirm < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AfterpayClearpay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Alipay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Alma < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AmazonPay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AuBecsDebit < ::Stripe::StripeObject
        # Six-digit number identifying bank and branch associated with this bank account.
        sig { returns(T.nilable(String)) }
        def bsb_number; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class BacsDebit < ::Stripe::StripeObject
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # Sort code of the bank account. (e.g., `10-20-30`)
        sig { returns(T.nilable(String)) }
        def sort_code; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Bancontact < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Billie < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class BillingDetails < ::Stripe::StripeObject
        class Address < ::Stripe::StripeObject
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
        # Billing address.
        sig { returns(T.nilable(Address)) }
        def address; end
        # Email address.
        sig { returns(T.nilable(String)) }
        def email; end
        # Full name.
        sig { returns(T.nilable(String)) }
        def name; end
        # Billing phone number (including extension).
        sig { returns(T.nilable(String)) }
        def phone; end
        # Taxpayer identification number. Used only for transactions between LATAM buyers and non-LATAM sellers.
        sig { returns(T.nilable(String)) }
        def tax_id; end
        def self.inner_class_types
          @inner_class_types = {address: Address}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Blik < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Boleto < ::Stripe::StripeObject
        # Uniquely identifies the customer tax id (CNPJ or CPF)
        sig { returns(String) }
        def tax_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Card < ::Stripe::StripeObject
        class Checks < ::Stripe::StripeObject
          # If a address line1 was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
          sig { returns(T.nilable(String)) }
          def address_line1_check; end
          # If a address postal code was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
          sig { returns(T.nilable(String)) }
          def address_postal_code_check; end
          # If a CVC was provided, results of the check, one of `pass`, `fail`, `unavailable`, or `unchecked`.
          sig { returns(T.nilable(String)) }
          def cvc_check; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class GeneratedFrom < ::Stripe::StripeObject
          class PaymentMethodDetails < ::Stripe::StripeObject
            class CardPresent < ::Stripe::StripeObject
              class Offline < ::Stripe::StripeObject
                # Time at which the payment was collected while offline
                sig { returns(T.nilable(Integer)) }
                def stored_at; end
                # The method used to process this payment method offline. Only deferred is allowed.
                sig { returns(T.nilable(String)) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Receipt < ::Stripe::StripeObject
                # The type of account being debited or credited
                sig { returns(T.nilable(String)) }
                def account_type; end
                # The Application Cryptogram, a unique value generated by the card to authenticate the transaction with issuers.
                sig { returns(T.nilable(String)) }
                def application_cryptogram; end
                # The Application Identifier (AID) on the card used to determine which networks are eligible to process the transaction. Referenced from EMV tag 9F12, data encoded on the card's chip.
                sig { returns(T.nilable(String)) }
                def application_preferred_name; end
                # Identifier for this transaction.
                sig { returns(T.nilable(String)) }
                def authorization_code; end
                # EMV tag 8A. A code returned by the card issuer.
                sig { returns(T.nilable(String)) }
                def authorization_response_code; end
                # Describes the method used by the cardholder to verify ownership of the card. One of the following: `approval`, `failure`, `none`, `offline_pin`, `offline_pin_and_signature`, `online_pin`, or `signature`.
                sig { returns(T.nilable(String)) }
                def cardholder_verification_method; end
                # Similar to the application_preferred_name, identifying the applications (AIDs) available on the card. Referenced from EMV tag 84.
                sig { returns(T.nilable(String)) }
                def dedicated_file_name; end
                # A 5-byte string that records the checks and validations that occur between the card and the terminal. These checks determine how the terminal processes the transaction and what risk tolerance is acceptable. Referenced from EMV Tag 95.
                sig { returns(T.nilable(String)) }
                def terminal_verification_results; end
                # An indication of which steps were completed during the card read process. Referenced from EMV Tag 9B.
                sig { returns(T.nilable(String)) }
                def transaction_status_information; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              class Wallet < ::Stripe::StripeObject
                # The type of mobile wallet, one of `apple_pay`, `google_pay`, `samsung_pay`, or `unknown`.
                sig { returns(String) }
                def type; end
                def self.inner_class_types
                  @inner_class_types = {}
                end
                def self.field_remappings
                  @field_remappings = {}
                end
              end
              # The authorized amount
              sig { returns(T.nilable(Integer)) }
              def amount_authorized; end
              # Card brand. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa` or `unknown`.
              sig { returns(T.nilable(String)) }
              def brand; end
              # The [product code](https://stripe.com/docs/card-product-codes) that identifies the specific program or product associated with a card.
              sig { returns(T.nilable(String)) }
              def brand_product; end
              # When using manual capture, a future timestamp after which the charge will be automatically refunded if uncaptured.
              sig { returns(T.nilable(Integer)) }
              def capture_before; end
              # The cardholder name as read from the card, in [ISO 7813](https://en.wikipedia.org/wiki/ISO/IEC_7813) format. May include alphanumeric characters, special characters and first/last name separator (`/`). In some cases, the cardholder name may not be available depending on how the issuer has configured the card. Cardholder name is typically not available on swipe or contactless payments, such as those made with Apple Pay and Google Pay.
              sig { returns(T.nilable(String)) }
              def cardholder_name; end
              # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
              sig { returns(T.nilable(String)) }
              def country; end
              # A high-level description of the type of cards issued in this range. (For internal use only and not typically available in standard API requests.)
              sig { returns(T.nilable(String)) }
              def description; end
              # Authorization response cryptogram.
              sig { returns(T.nilable(String)) }
              def emv_auth_data; end
              # Two-digit number representing the card's expiration month.
              sig { returns(Integer) }
              def exp_month; end
              # Four-digit number representing the card's expiration year.
              sig { returns(Integer) }
              def exp_year; end
              # Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
              #
              # *As of May 1, 2021, card fingerprint in India for Connect changed to allow two fingerprints for the same card---one for India and one for the rest of the world.*
              sig { returns(T.nilable(String)) }
              def fingerprint; end
              # Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
              sig { returns(T.nilable(String)) }
              def funding; end
              # ID of a card PaymentMethod generated from the card_present PaymentMethod that may be attached to a Customer for future transactions. Only present if it was possible to generate a card PaymentMethod.
              sig { returns(T.nilable(String)) }
              def generated_card; end
              # Issuer identification number of the card. (For internal use only and not typically available in standard API requests.)
              sig { returns(T.nilable(String)) }
              def iin; end
              # Whether this [PaymentIntent](https://docs.stripe.com/api/payment_intents) is eligible for incremental authorizations. Request support using [request_incremental_authorization_support](https://docs.stripe.com/api/payment_intents/create#create_payment_intent-payment_method_options-card_present-request_incremental_authorization_support).
              sig { returns(T::Boolean) }
              def incremental_authorization_supported; end
              # The name of the card's issuing bank. (For internal use only and not typically available in standard API requests.)
              sig { returns(T.nilable(String)) }
              def issuer; end
              # The last four digits of the card.
              sig { returns(T.nilable(String)) }
              def last4; end
              # Identifies which network this charge was processed on. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `interac`, `jcb`, `link`, `mastercard`, `unionpay`, `visa`, or `unknown`.
              sig { returns(T.nilable(String)) }
              def network; end
              # This is used by the financial networks to identify a transaction. Visa calls this the Transaction ID, Mastercard calls this the Trace ID, and American Express calls this the Acquirer Reference Data. This value will be present if it is returned by the financial network in the authorization response, and null otherwise.
              sig { returns(T.nilable(String)) }
              def network_transaction_id; end
              # Details about payments collected offline.
              sig { returns(T.nilable(Offline)) }
              def offline; end
              # Defines whether the authorized amount can be over-captured or not
              sig { returns(T::Boolean) }
              def overcapture_supported; end
              # The languages that the issuing bank recommends using for localizing any customer-facing text, as read from the card. Referenced from EMV tag 5F2D, data encoded on the card's chip.
              sig { returns(T.nilable(T::Array[String])) }
              def preferred_locales; end
              # How card details were read in this transaction.
              sig { returns(T.nilable(String)) }
              def read_method; end
              # A collection of fields required to be displayed on receipts. Only required for EMV transactions.
              sig { returns(T.nilable(Receipt)) }
              def receipt; end
              # Attribute for field wallet
              sig { returns(T.nilable(Wallet)) }
              def wallet; end
              def self.inner_class_types
                @inner_class_types = {offline: Offline, receipt: Receipt, wallet: Wallet}
              end
              def self.field_remappings
                @field_remappings = {}
              end
            end
            # Attribute for field card_present
            sig { returns(T.nilable(CardPresent)) }
            def card_present; end
            # The type of payment method transaction-specific details from the transaction that generated this `card` payment method. Always `card_present`.
            sig { returns(String) }
            def type; end
            def self.inner_class_types
              @inner_class_types = {card_present: CardPresent}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The charge that created this object.
          sig { returns(T.nilable(String)) }
          def charge; end
          # Transaction-specific details of the payment method used in the payment.
          sig { returns(T.nilable(PaymentMethodDetails)) }
          def payment_method_details; end
          # The ID of the SetupAttempt that generated this PaymentMethod, if any.
          sig { returns(T.nilable(T.any(String, ::Stripe::SetupAttempt))) }
          def setup_attempt; end
          def self.inner_class_types
            @inner_class_types = {payment_method_details: PaymentMethodDetails}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Networks < ::Stripe::StripeObject
          # All networks available for selection via [payment_method_options.card.network](/api/payment_intents/confirm#confirm_payment_intent-payment_method_options-card-network).
          sig { returns(T::Array[String]) }
          def available; end
          # The preferred network for co-branded cards. Can be `cartes_bancaires`, `mastercard`, `visa` or `invalid_preference` if requested network is not valid for the card.
          sig { returns(T.nilable(String)) }
          def preferred; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ThreeDSecureUsage < ::Stripe::StripeObject
          # Whether 3D Secure is supported on this card.
          sig { returns(T::Boolean) }
          def supported; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Wallet < ::Stripe::StripeObject
          class AmexExpressCheckout < ::Stripe::StripeObject
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class ApplePay < ::Stripe::StripeObject
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class GooglePay < ::Stripe::StripeObject
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Link < ::Stripe::StripeObject
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class Masterpass < ::Stripe::StripeObject
            class BillingAddress < ::Stripe::StripeObject
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
            class ShippingAddress < ::Stripe::StripeObject
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
            # Owner's verified billing address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
            sig { returns(T.nilable(BillingAddress)) }
            def billing_address; end
            # Owner's verified email. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
            sig { returns(T.nilable(String)) }
            def email; end
            # Owner's verified full name. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
            sig { returns(T.nilable(String)) }
            def name; end
            # Owner's verified shipping address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
            sig { returns(T.nilable(ShippingAddress)) }
            def shipping_address; end
            def self.inner_class_types
              @inner_class_types = {
                billing_address: BillingAddress,
                shipping_address: ShippingAddress,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class SamsungPay < ::Stripe::StripeObject
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          class VisaCheckout < ::Stripe::StripeObject
            class BillingAddress < ::Stripe::StripeObject
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
            class ShippingAddress < ::Stripe::StripeObject
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
            # Owner's verified billing address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
            sig { returns(T.nilable(BillingAddress)) }
            def billing_address; end
            # Owner's verified email. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
            sig { returns(T.nilable(String)) }
            def email; end
            # Owner's verified full name. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
            sig { returns(T.nilable(String)) }
            def name; end
            # Owner's verified shipping address. Values are verified or provided by the wallet directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
            sig { returns(T.nilable(ShippingAddress)) }
            def shipping_address; end
            def self.inner_class_types
              @inner_class_types = {
                billing_address: BillingAddress,
                shipping_address: ShippingAddress,
              }
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field amex_express_checkout
          sig { returns(T.nilable(AmexExpressCheckout)) }
          def amex_express_checkout; end
          # Attribute for field apple_pay
          sig { returns(T.nilable(ApplePay)) }
          def apple_pay; end
          # (For tokenized numbers only.) The last four digits of the device account number.
          sig { returns(T.nilable(String)) }
          def dynamic_last4; end
          # Attribute for field google_pay
          sig { returns(T.nilable(GooglePay)) }
          def google_pay; end
          # Attribute for field link
          sig { returns(T.nilable(Link)) }
          def link; end
          # Attribute for field masterpass
          sig { returns(T.nilable(Masterpass)) }
          def masterpass; end
          # Attribute for field samsung_pay
          sig { returns(T.nilable(SamsungPay)) }
          def samsung_pay; end
          # The type of the card wallet, one of `amex_express_checkout`, `apple_pay`, `google_pay`, `masterpass`, `samsung_pay`, `visa_checkout`, or `link`. An additional hash is included on the Wallet subhash with a name matching this value. It contains additional information specific to the card wallet type.
          sig { returns(String) }
          def type; end
          # Attribute for field visa_checkout
          sig { returns(T.nilable(VisaCheckout)) }
          def visa_checkout; end
          def self.inner_class_types
            @inner_class_types = {
              amex_express_checkout: AmexExpressCheckout,
              apple_pay: ApplePay,
              google_pay: GooglePay,
              link: Link,
              masterpass: Masterpass,
              samsung_pay: SamsungPay,
              visa_checkout: VisaCheckout,
            }
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Card brand. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa` or `unknown`.
        sig { returns(String) }
        def brand; end
        # Checks on Card address and CVC if provided.
        sig { returns(T.nilable(Checks)) }
        def checks; end
        # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
        sig { returns(T.nilable(String)) }
        def country; end
        # A high-level description of the type of cards issued in this range. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def description; end
        # The brand to use when displaying the card, this accounts for customer's brand choice on dual-branded cards. Can be `american_express`, `cartes_bancaires`, `diners_club`, `discover`, `eftpos_australia`, `interac`, `jcb`, `mastercard`, `union_pay`, `visa`, or `other` and may contain more values in the future.
        sig { returns(T.nilable(String)) }
        def display_brand; end
        # Two-digit number representing the card's expiration month.
        sig { returns(Integer) }
        def exp_month; end
        # Four-digit number representing the card's expiration year.
        sig { returns(Integer) }
        def exp_year; end
        # Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
        #
        # *As of May 1, 2021, card fingerprint in India for Connect changed to allow two fingerprints for the same card---one for India and one for the rest of the world.*
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
        sig { returns(String) }
        def funding; end
        # Details of the original PaymentMethod that created this object.
        sig { returns(T.nilable(GeneratedFrom)) }
        def generated_from; end
        # Issuer identification number of the card. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def iin; end
        # The name of the card's issuing bank. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def issuer; end
        # The last four digits of the card.
        sig { returns(String) }
        def last4; end
        # Contains information about card networks that can be used to process the payment.
        sig { returns(T.nilable(Networks)) }
        def networks; end
        # Status of a card based on the card issuer.
        sig { returns(T.nilable(String)) }
        def regulated_status; end
        # Contains details on how this Card may be used for 3D Secure authentication.
        sig { returns(T.nilable(ThreeDSecureUsage)) }
        def three_d_secure_usage; end
        # If this Card is part of a card wallet, this contains the details of the card wallet.
        sig { returns(T.nilable(Wallet)) }
        def wallet; end
        def self.inner_class_types
          @inner_class_types = {
            checks: Checks,
            generated_from: GeneratedFrom,
            networks: Networks,
            three_d_secure_usage: ThreeDSecureUsage,
            wallet: Wallet,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class CardPresent < ::Stripe::StripeObject
        class Networks < ::Stripe::StripeObject
          # All networks available for selection via [payment_method_options.card.network](/api/payment_intents/confirm#confirm_payment_intent-payment_method_options-card-network).
          sig { returns(T::Array[String]) }
          def available; end
          # The preferred network for the card.
          sig { returns(T.nilable(String)) }
          def preferred; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Offline < ::Stripe::StripeObject
          # Time at which the payment was collected while offline
          sig { returns(T.nilable(Integer)) }
          def stored_at; end
          # The method used to process this payment method offline. Only deferred is allowed.
          sig { returns(T.nilable(String)) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Wallet < ::Stripe::StripeObject
          # The type of mobile wallet, one of `apple_pay`, `google_pay`, `samsung_pay`, or `unknown`.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Card brand. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa` or `unknown`.
        sig { returns(T.nilable(String)) }
        def brand; end
        # The [product code](https://stripe.com/docs/card-product-codes) that identifies the specific program or product associated with a card.
        sig { returns(T.nilable(String)) }
        def brand_product; end
        # The cardholder name as read from the card, in [ISO 7813](https://en.wikipedia.org/wiki/ISO/IEC_7813) format. May include alphanumeric characters, special characters and first/last name separator (`/`). In some cases, the cardholder name may not be available depending on how the issuer has configured the card. Cardholder name is typically not available on swipe or contactless payments, such as those made with Apple Pay and Google Pay.
        sig { returns(T.nilable(String)) }
        def cardholder_name; end
        # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
        sig { returns(T.nilable(String)) }
        def country; end
        # A high-level description of the type of cards issued in this range. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def description; end
        # Two-digit number representing the card's expiration month.
        sig { returns(Integer) }
        def exp_month; end
        # Four-digit number representing the card's expiration year.
        sig { returns(Integer) }
        def exp_year; end
        # Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
        #
        # *As of May 1, 2021, card fingerprint in India for Connect changed to allow two fingerprints for the same card---one for India and one for the rest of the world.*
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
        sig { returns(T.nilable(String)) }
        def funding; end
        # Issuer identification number of the card. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def iin; end
        # The name of the card's issuing bank. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def issuer; end
        # The last four digits of the card.
        sig { returns(T.nilable(String)) }
        def last4; end
        # Contains information about card networks that can be used to process the payment.
        sig { returns(T.nilable(Networks)) }
        def networks; end
        # Details about payment methods collected offline.
        sig { returns(T.nilable(Offline)) }
        def offline; end
        # The languages that the issuing bank recommends using for localizing any customer-facing text, as read from the card. Referenced from EMV tag 5F2D, data encoded on the card's chip.
        sig { returns(T.nilable(T::Array[String])) }
        def preferred_locales; end
        # How card details were read in this transaction.
        sig { returns(T.nilable(String)) }
        def read_method; end
        # Attribute for field wallet
        sig { returns(T.nilable(Wallet)) }
        def wallet; end
        def self.inner_class_types
          @inner_class_types = {networks: Networks, offline: Offline, wallet: Wallet}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Cashapp < ::Stripe::StripeObject
        # A unique and immutable identifier assigned by Cash App to every buyer.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # A public identifier for buyers using Cash App.
        sig { returns(T.nilable(String)) }
        def cashtag; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Crypto < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class CustomerBalance < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Eps < ::Stripe::StripeObject
        # The customer's bank. Should be one of `arzte_und_apotheker_bank`, `austrian_anadi_bank_ag`, `bank_austria`, `bankhaus_carl_spangler`, `bankhaus_schelhammer_und_schattera_ag`, `bawag_psk_ag`, `bks_bank_ag`, `brull_kallmus_bank_ag`, `btv_vier_lander_bank`, `capital_bank_grawe_gruppe_ag`, `deutsche_bank_ag`, `dolomitenbank`, `easybank_ag`, `erste_bank_und_sparkassen`, `hypo_alpeadriabank_international_ag`, `hypo_noe_lb_fur_niederosterreich_u_wien`, `hypo_oberosterreich_salzburg_steiermark`, `hypo_tirol_bank_ag`, `hypo_vorarlberg_bank_ag`, `hypo_bank_burgenland_aktiengesellschaft`, `marchfelder_bank`, `oberbank_ag`, `raiffeisen_bankengruppe_osterreich`, `schoellerbank_ag`, `sparda_bank_wien`, `volksbank_gruppe`, `volkskreditbank_ag`, or `vr_bank_braunau`.
        sig { returns(T.nilable(String)) }
        def bank; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Fpx < ::Stripe::StripeObject
        # Account holder type, if provided. Can be one of `individual` or `company`.
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        # The customer's bank, if provided. Can be one of `affin_bank`, `agrobank`, `alliance_bank`, `ambank`, `bank_islam`, `bank_muamalat`, `bank_rakyat`, `bsn`, `cimb`, `hong_leong_bank`, `hsbc`, `kfh`, `maybank2u`, `ocbc`, `public_bank`, `rhb`, `standard_chartered`, `uob`, `deutsche_bank`, `maybank2e`, `pb_enterprise`, or `bank_of_china`.
        sig { returns(String) }
        def bank; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Giropay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Grabpay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Ideal < ::Stripe::StripeObject
        # The customer's bank, if provided. Can be one of `abn_amro`, `asn_bank`, `bunq`, `buut`, `finom`, `handelsbanken`, `ing`, `knab`, `mollie`, `moneyou`, `n26`, `nn`, `rabobank`, `regiobank`, `revolut`, `sns_bank`, `triodos_bank`, `van_lanschot`, or `yoursafe`.
        sig { returns(T.nilable(String)) }
        def bank; end
        # The Bank Identifier Code of the customer's bank, if the bank was provided.
        sig { returns(T.nilable(String)) }
        def bic; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class InteracPresent < ::Stripe::StripeObject
        class Networks < ::Stripe::StripeObject
          # All networks available for selection via [payment_method_options.card.network](/api/payment_intents/confirm#confirm_payment_intent-payment_method_options-card-network).
          sig { returns(T::Array[String]) }
          def available; end
          # The preferred network for the card.
          sig { returns(T.nilable(String)) }
          def preferred; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Card brand. Can be `interac`, `mastercard` or `visa`.
        sig { returns(T.nilable(String)) }
        def brand; end
        # The cardholder name as read from the card, in [ISO 7813](https://en.wikipedia.org/wiki/ISO/IEC_7813) format. May include alphanumeric characters, special characters and first/last name separator (`/`). In some cases, the cardholder name may not be available depending on how the issuer has configured the card. Cardholder name is typically not available on swipe or contactless payments, such as those made with Apple Pay and Google Pay.
        sig { returns(T.nilable(String)) }
        def cardholder_name; end
        # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
        sig { returns(T.nilable(String)) }
        def country; end
        # A high-level description of the type of cards issued in this range. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def description; end
        # Two-digit number representing the card's expiration month.
        sig { returns(Integer) }
        def exp_month; end
        # Four-digit number representing the card's expiration year.
        sig { returns(Integer) }
        def exp_year; end
        # Uniquely identifies this particular card number. You can use this attribute to check whether two customers who’ve signed up with you are using the same card number, for example. For payment methods that tokenize card information (Apple Pay, Google Pay), the tokenized number might be provided instead of the underlying card number.
        #
        # *As of May 1, 2021, card fingerprint in India for Connect changed to allow two fingerprints for the same card---one for India and one for the rest of the world.*
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
        sig { returns(T.nilable(String)) }
        def funding; end
        # Issuer identification number of the card. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def iin; end
        # The name of the card's issuing bank. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def issuer; end
        # The last four digits of the card.
        sig { returns(T.nilable(String)) }
        def last4; end
        # Contains information about card networks that can be used to process the payment.
        sig { returns(T.nilable(Networks)) }
        def networks; end
        # The languages that the issuing bank recommends using for localizing any customer-facing text, as read from the card. Referenced from EMV tag 5F2D, data encoded on the card's chip.
        sig { returns(T.nilable(T::Array[String])) }
        def preferred_locales; end
        # How card details were read in this transaction.
        sig { returns(T.nilable(String)) }
        def read_method; end
        def self.inner_class_types
          @inner_class_types = {networks: Networks}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class KakaoPay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Klarna < ::Stripe::StripeObject
        class Dob < ::Stripe::StripeObject
          # The day of birth, between 1 and 31.
          sig { returns(T.nilable(Integer)) }
          def day; end
          # The month of birth, between 1 and 12.
          sig { returns(T.nilable(Integer)) }
          def month; end
          # The four-digit year of birth.
          sig { returns(T.nilable(Integer)) }
          def year; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The customer's date of birth, if provided.
        sig { returns(T.nilable(Dob)) }
        def dob; end
        def self.inner_class_types
          @inner_class_types = {dob: Dob}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Konbini < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class KrCard < ::Stripe::StripeObject
        # The local credit or debit card brand.
        sig { returns(T.nilable(String)) }
        def brand; end
        # The last four digits of the card. This may not be present for American Express cards.
        sig { returns(T.nilable(String)) }
        def last4; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Link < ::Stripe::StripeObject
        # Account owner's email address.
        sig { returns(T.nilable(String)) }
        def email; end
        # [Deprecated] This is a legacy parameter that no longer has any function.
        sig { returns(T.nilable(String)) }
        def persistent_token; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class MbWay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Mobilepay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Multibanco < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class NaverPay < ::Stripe::StripeObject
        # Uniquely identifies this particular Naver Pay account. You can use this attribute to check whether two Naver Pay accounts are the same.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # Whether to fund this transaction with Naver Pay points or a card.
        sig { returns(String) }
        def funding; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class NzBankAccount < ::Stripe::StripeObject
        # The name on the bank account. Only present if the account holder name is different from the name of the authorized signatory collected in the PaymentMethod’s billing details.
        sig { returns(T.nilable(String)) }
        def account_holder_name; end
        # The numeric code for the bank account's bank.
        sig { returns(String) }
        def bank_code; end
        # The name of the bank.
        sig { returns(String) }
        def bank_name; end
        # The numeric code for the bank account's bank branch.
        sig { returns(String) }
        def branch_code; end
        # Last four digits of the bank account number.
        sig { returns(String) }
        def last4; end
        # The suffix of the bank account number.
        sig { returns(T.nilable(String)) }
        def suffix; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Oxxo < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class P24 < ::Stripe::StripeObject
        # The customer's bank, if provided.
        sig { returns(T.nilable(String)) }
        def bank; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PayByBank < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Payco < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Paynow < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Paypal < ::Stripe::StripeObject
        # Two-letter ISO code representing the buyer's country. Values are provided by PayPal directly (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        sig { returns(T.nilable(String)) }
        def country; end
        # Owner's email. Values are provided by PayPal directly
        # (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        sig { returns(T.nilable(String)) }
        def payer_email; end
        # PayPal account PayerID. This identifier uniquely identifies the PayPal customer.
        sig { returns(T.nilable(String)) }
        def payer_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Payto < ::Stripe::StripeObject
        # Bank-State-Branch number of the bank account.
        sig { returns(T.nilable(String)) }
        def bsb_number; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # The PayID alias for the bank account.
        sig { returns(T.nilable(String)) }
        def pay_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Pix < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Promptpay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RevolutPay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SamsungPay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Satispay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SepaDebit < ::Stripe::StripeObject
        class GeneratedFrom < ::Stripe::StripeObject
          # The ID of the Charge that generated this PaymentMethod, if any.
          sig { returns(T.nilable(T.any(String, ::Stripe::Charge))) }
          def charge; end
          # The ID of the SetupAttempt that generated this PaymentMethod, if any.
          sig { returns(T.nilable(T.any(String, ::Stripe::SetupAttempt))) }
          def setup_attempt; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Bank code of bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_code; end
        # Branch code of bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def branch_code; end
        # Two-letter ISO code representing the country the bank account is located in.
        sig { returns(T.nilable(String)) }
        def country; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Information about the object that generated this PaymentMethod.
        sig { returns(T.nilable(GeneratedFrom)) }
        def generated_from; end
        # Last four characters of the IBAN.
        sig { returns(T.nilable(String)) }
        def last4; end
        def self.inner_class_types
          @inner_class_types = {generated_from: GeneratedFrom}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Sofort < ::Stripe::StripeObject
        # Two-letter ISO code representing the country the bank account is located in.
        sig { returns(T.nilable(String)) }
        def country; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Swish < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Twint < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class UsBankAccount < ::Stripe::StripeObject
        class Networks < ::Stripe::StripeObject
          # The preferred network.
          sig { returns(T.nilable(String)) }
          def preferred; end
          # All supported networks.
          sig { returns(T::Array[String]) }
          def supported; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class StatusDetails < ::Stripe::StripeObject
          class Blocked < ::Stripe::StripeObject
            # The ACH network code that resulted in this block.
            sig { returns(T.nilable(String)) }
            def network_code; end
            # The reason why this PaymentMethod's fingerprint has been blocked
            sig { returns(T.nilable(String)) }
            def reason; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field blocked
          sig { returns(T.nilable(Blocked)) }
          def blocked; end
          def self.inner_class_types
            @inner_class_types = {blocked: Blocked}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Account holder type: individual or company.
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        # Account type: checkings or savings. Defaults to checking if omitted.
        sig { returns(T.nilable(String)) }
        def account_type; end
        # The name of the bank.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # The ID of the Financial Connections Account used to create the payment method.
        sig { returns(T.nilable(String)) }
        def financial_connections_account; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # Contains information about US bank account networks that can be used.
        sig { returns(T.nilable(Networks)) }
        def networks; end
        # Routing number of the bank account.
        sig { returns(T.nilable(String)) }
        def routing_number; end
        # Contains information about the future reusability of this PaymentMethod.
        sig { returns(T.nilable(StatusDetails)) }
        def status_details; end
        def self.inner_class_types
          @inner_class_types = {networks: Networks, status_details: StatusDetails}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class WechatPay < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Zip < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field acss_debit
      sig { returns(T.nilable(AcssDebit)) }
      def acss_debit; end
      # Attribute for field affirm
      sig { returns(T.nilable(Affirm)) }
      def affirm; end
      # Attribute for field afterpay_clearpay
      sig { returns(T.nilable(AfterpayClearpay)) }
      def afterpay_clearpay; end
      # Attribute for field alipay
      sig { returns(T.nilable(Alipay)) }
      def alipay; end
      # This field indicates whether this payment method can be shown again to its customer in a checkout flow. Stripe products such as Checkout and Elements use this field to determine whether a payment method can be shown as a saved payment method in a checkout flow. The field defaults to “unspecified”.
      sig { returns(T.nilable(String)) }
      def allow_redisplay; end
      # Attribute for field alma
      sig { returns(T.nilable(Alma)) }
      def alma; end
      # Attribute for field amazon_pay
      sig { returns(T.nilable(AmazonPay)) }
      def amazon_pay; end
      # Attribute for field au_becs_debit
      sig { returns(T.nilable(AuBecsDebit)) }
      def au_becs_debit; end
      # Attribute for field bacs_debit
      sig { returns(T.nilable(BacsDebit)) }
      def bacs_debit; end
      # Attribute for field bancontact
      sig { returns(T.nilable(Bancontact)) }
      def bancontact; end
      # Attribute for field billie
      sig { returns(T.nilable(Billie)) }
      def billie; end
      # Attribute for field billing_details
      sig { returns(BillingDetails) }
      def billing_details; end
      # Attribute for field blik
      sig { returns(T.nilable(Blik)) }
      def blik; end
      # Attribute for field boleto
      sig { returns(T.nilable(Boleto)) }
      def boleto; end
      # Attribute for field card
      sig { returns(T.nilable(Card)) }
      def card; end
      # Attribute for field card_present
      sig { returns(T.nilable(CardPresent)) }
      def card_present; end
      # Attribute for field cashapp
      sig { returns(T.nilable(Cashapp)) }
      def cashapp; end
      # Attribute for field crypto
      sig { returns(T.nilable(Crypto)) }
      def crypto; end
      # The ID of the Customer to which this PaymentMethod is saved. This will not be set when the PaymentMethod has not been saved to a Customer.
      sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
      def customer; end
      # Attribute for field customer_account
      sig { returns(T.nilable(String)) }
      def customer_account; end
      # Attribute for field customer_balance
      sig { returns(T.nilable(CustomerBalance)) }
      def customer_balance; end
      # Attribute for field eps
      sig { returns(T.nilable(Eps)) }
      def eps; end
      # Attribute for field fpx
      sig { returns(T.nilable(Fpx)) }
      def fpx; end
      # Attribute for field giropay
      sig { returns(T.nilable(Giropay)) }
      def giropay; end
      # Attribute for field grabpay
      sig { returns(T.nilable(Grabpay)) }
      def grabpay; end
      # Attribute for field ideal
      sig { returns(T.nilable(Ideal)) }
      def ideal; end
      # Attribute for field interac_present
      sig { returns(T.nilable(InteracPresent)) }
      def interac_present; end
      # Attribute for field kakao_pay
      sig { returns(T.nilable(KakaoPay)) }
      def kakao_pay; end
      # Attribute for field klarna
      sig { returns(T.nilable(Klarna)) }
      def klarna; end
      # Attribute for field konbini
      sig { returns(T.nilable(Konbini)) }
      def konbini; end
      # Attribute for field kr_card
      sig { returns(T.nilable(KrCard)) }
      def kr_card; end
      # Attribute for field link
      sig { returns(T.nilable(Link)) }
      def link; end
      # Attribute for field mb_way
      sig { returns(T.nilable(MbWay)) }
      def mb_way; end
      # Attribute for field mobilepay
      sig { returns(T.nilable(Mobilepay)) }
      def mobilepay; end
      # Attribute for field multibanco
      sig { returns(T.nilable(Multibanco)) }
      def multibanco; end
      # Attribute for field naver_pay
      sig { returns(T.nilable(NaverPay)) }
      def naver_pay; end
      # Attribute for field nz_bank_account
      sig { returns(T.nilable(NzBankAccount)) }
      def nz_bank_account; end
      # Attribute for field oxxo
      sig { returns(T.nilable(Oxxo)) }
      def oxxo; end
      # Attribute for field p24
      sig { returns(T.nilable(P24)) }
      def p24; end
      # Attribute for field pay_by_bank
      sig { returns(T.nilable(PayByBank)) }
      def pay_by_bank; end
      # Attribute for field payco
      sig { returns(T.nilable(Payco)) }
      def payco; end
      # Attribute for field paynow
      sig { returns(T.nilable(Paynow)) }
      def paynow; end
      # Attribute for field paypal
      sig { returns(T.nilable(Paypal)) }
      def paypal; end
      # Attribute for field payto
      sig { returns(T.nilable(Payto)) }
      def payto; end
      # Attribute for field pix
      sig { returns(T.nilable(Pix)) }
      def pix; end
      # Attribute for field promptpay
      sig { returns(T.nilable(Promptpay)) }
      def promptpay; end
      # Attribute for field revolut_pay
      sig { returns(T.nilable(RevolutPay)) }
      def revolut_pay; end
      # Attribute for field samsung_pay
      sig { returns(T.nilable(SamsungPay)) }
      def samsung_pay; end
      # Attribute for field satispay
      sig { returns(T.nilable(Satispay)) }
      def satispay; end
      # Attribute for field sepa_debit
      sig { returns(T.nilable(SepaDebit)) }
      def sepa_debit; end
      # Attribute for field sofort
      sig { returns(T.nilable(Sofort)) }
      def sofort; end
      # Attribute for field swish
      sig { returns(T.nilable(Swish)) }
      def swish; end
      # Attribute for field twint
      sig { returns(T.nilable(Twint)) }
      def twint; end
      # The type of the PaymentMethod. An additional hash is included on the PaymentMethod with a name matching this value. It contains additional information specific to the PaymentMethod type.
      sig { returns(String) }
      def type; end
      # Attribute for field us_bank_account
      sig { returns(T.nilable(UsBankAccount)) }
      def us_bank_account; end
      # Attribute for field wechat_pay
      sig { returns(T.nilable(WechatPay)) }
      def wechat_pay; end
      # Attribute for field zip
      sig { returns(T.nilable(Zip)) }
      def zip; end
      def self.inner_class_types
        @inner_class_types = {
          acss_debit: AcssDebit,
          affirm: Affirm,
          afterpay_clearpay: AfterpayClearpay,
          alipay: Alipay,
          alma: Alma,
          amazon_pay: AmazonPay,
          au_becs_debit: AuBecsDebit,
          bacs_debit: BacsDebit,
          bancontact: Bancontact,
          billie: Billie,
          billing_details: BillingDetails,
          blik: Blik,
          boleto: Boleto,
          card: Card,
          card_present: CardPresent,
          cashapp: Cashapp,
          crypto: Crypto,
          customer_balance: CustomerBalance,
          eps: Eps,
          fpx: Fpx,
          giropay: Giropay,
          grabpay: Grabpay,
          ideal: Ideal,
          interac_present: InteracPresent,
          kakao_pay: KakaoPay,
          klarna: Klarna,
          konbini: Konbini,
          kr_card: KrCard,
          link: Link,
          mb_way: MbWay,
          mobilepay: Mobilepay,
          multibanco: Multibanco,
          naver_pay: NaverPay,
          nz_bank_account: NzBankAccount,
          oxxo: Oxxo,
          p24: P24,
          pay_by_bank: PayByBank,
          payco: Payco,
          paynow: Paynow,
          paypal: Paypal,
          payto: Payto,
          pix: Pix,
          promptpay: Promptpay,
          revolut_pay: RevolutPay,
          samsung_pay: SamsungPay,
          satispay: Satispay,
          sepa_debit: SepaDebit,
          sofort: Sofort,
          swish: Swish,
          twint: Twint,
          us_bank_account: UsBankAccount,
          wechat_pay: WechatPay,
          zip: Zip,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Shipping < ::Stripe::StripeObject
      class Address < ::Stripe::StripeObject
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
      # Attribute for field address
      sig { returns(Address) }
      def address; end
      # Recipient name.
      sig { returns(String) }
      def name; end
      # Recipient phone (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      def self.inner_class_types
        @inner_class_types = {address: Address}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Time at which this ConfirmationToken expires and can no longer be used to confirm a PaymentIntent or SetupIntent.
    sig { returns(T.nilable(Integer)) }
    def expires_at; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Data used for generating a Mandate.
    sig { returns(T.nilable(MandateData)) }
    def mandate_data; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # ID of the PaymentIntent that this ConfirmationToken was used to confirm, or null if this ConfirmationToken has not yet been used.
    sig { returns(T.nilable(String)) }
    def payment_intent; end
    # Payment-method-specific configuration for this ConfirmationToken.
    sig { returns(T.nilable(PaymentMethodOptions)) }
    def payment_method_options; end
    # Payment details collected by the Payment Element, used to create a PaymentMethod when a PaymentIntent or SetupIntent is confirmed with this ConfirmationToken.
    sig { returns(T.nilable(PaymentMethodPreview)) }
    def payment_method_preview; end
    # Return URL used to confirm the Intent.
    sig { returns(T.nilable(String)) }
    def return_url; end
    # Indicates that you intend to make future payments with this ConfirmationToken's payment method.
    #
    # The presence of this property will [attach the payment method](https://docs.stripe.com/payments/save-during-payment) to the PaymentIntent's Customer, if present, after the PaymentIntent is confirmed and any required actions from the user are complete.
    sig { returns(T.nilable(String)) }
    def setup_future_usage; end
    # ID of the SetupIntent that this ConfirmationToken was used to confirm, or null if this ConfirmationToken has not yet been used.
    sig { returns(T.nilable(String)) }
    def setup_intent; end
    # Shipping information collected on this ConfirmationToken.
    sig { returns(T.nilable(Shipping)) }
    def shipping; end
    # Indicates whether the Stripe SDK is used to handle confirmation flow. Defaults to `true` on ConfirmationToken.
    sig { returns(T::Boolean) }
    def use_stripe_sdk; end
  end
end