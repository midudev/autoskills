# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A Payment Record is a resource that allows you to represent payments that occur on- or off-Stripe.
  # For example, you can create a Payment Record to model a payment made on a different payment processor,
  # in order to mark an Invoice as paid and a Subscription as active. Payment Records consist of one or
  # more Payment Attempt Records, which represent individual attempts made on a payment network.
  class PaymentRecord < APIResource
    class Amount < ::Stripe::StripeObject
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AmountAuthorized < ::Stripe::StripeObject
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AmountCanceled < ::Stripe::StripeObject
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AmountFailed < ::Stripe::StripeObject
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AmountGuaranteed < ::Stripe::StripeObject
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AmountRefunded < ::Stripe::StripeObject
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AmountRequested < ::Stripe::StripeObject
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CustomerDetails < ::Stripe::StripeObject
      # ID of the Stripe Customer associated with this payment.
      sig { returns(T.nilable(String)) }
      def customer; end
      # The customer's email address.
      sig { returns(T.nilable(String)) }
      def email; end
      # The customer's name.
      sig { returns(T.nilable(String)) }
      def name; end
      # The customer's phone number.
      sig { returns(T.nilable(String)) }
      def phone; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaymentMethodDetails < ::Stripe::StripeObject
      class AchCreditTransfer < ::Stripe::StripeObject
        # Account number to transfer funds to.
        sig { returns(T.nilable(String)) }
        def account_number; end
        # Name of the bank associated with the routing number.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Routing transit number for the bank account to transfer funds to.
        sig { returns(T.nilable(String)) }
        def routing_number; end
        # SWIFT code of the bank associated with the routing number.
        sig { returns(T.nilable(String)) }
        def swift_code; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AchDebit < ::Stripe::StripeObject
        # Type of entity that holds the account. This can be either `individual` or `company`.
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        # Name of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Two-letter ISO code representing the country the bank account is located in.
        sig { returns(T.nilable(String)) }
        def country; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # Routing transit number of the bank account.
        sig { returns(T.nilable(String)) }
        def routing_number; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AcssDebit < ::Stripe::StripeObject
        # Name of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Estimated date to debit the customer's bank account. A date string in YYYY-MM-DD format.
        sig { returns(T.nilable(String)) }
        def expected_debit_date; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Institution number of the bank account
        sig { returns(T.nilable(String)) }
        def institution_number; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # ID of the mandate used to make this payment.
        sig { returns(T.nilable(String)) }
        def mandate; end
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
        # ID of the [location](https://docs.stripe.com/api/terminal/locations) that this transaction's reader is assigned to.
        sig { returns(T.nilable(String)) }
        def location; end
        # ID of the [reader](https://docs.stripe.com/api/terminal/readers) this transaction was made on.
        sig { returns(T.nilable(String)) }
        def reader; end
        # The Affirm transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AfterpayClearpay < ::Stripe::StripeObject
        # The Afterpay order ID associated with this payment intent.
        sig { returns(T.nilable(String)) }
        def order_id; end
        # Order identifier shown to the merchant in Afterpay’s online portal.
        sig { returns(T.nilable(String)) }
        def reference; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Alipay < ::Stripe::StripeObject
        # Uniquely identifies this particular Alipay account. You can use this attribute to check whether two Alipay accounts are the same.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # Uniquely identifies this particular Alipay account. You can use this attribute to check whether two Alipay accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Transaction ID of this particular Alipay transaction.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Alma < ::Stripe::StripeObject
        class Installments < ::Stripe::StripeObject
          # The number of installments.
          sig { returns(Integer) }
          def count; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field installments
        sig { returns(T.nilable(Installments)) }
        def installments; end
        # The Alma transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {installments: Installments}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AmazonPay < ::Stripe::StripeObject
        class Funding < ::Stripe::StripeObject
          class Card < ::Stripe::StripeObject
            # Card brand. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa` or `unknown`.
            sig { returns(T.nilable(String)) }
            def brand; end
            # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
            sig { returns(T.nilable(String)) }
            def country; end
            # Two-digit number representing the card's expiration month.
            sig { returns(T.nilable(Integer)) }
            def exp_month; end
            # Four-digit number representing the card's expiration year.
            sig { returns(T.nilable(Integer)) }
            def exp_year; end
            # Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
            sig { returns(T.nilable(String)) }
            def funding; end
            # The last four digits of the card.
            sig { returns(T.nilable(String)) }
            def last4; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field card
          sig { returns(T.nilable(Card)) }
          def card; end
          # funding type of the underlying payment method.
          sig { returns(T.nilable(String)) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {card: Card}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field funding
        sig { returns(T.nilable(Funding)) }
        def funding; end
        # The Amazon Pay transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {funding: Funding}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AuBecsDebit < ::Stripe::StripeObject
        # Bank-State-Branch number of the bank account.
        sig { returns(T.nilable(String)) }
        def bsb_number; end
        # Estimated date to debit the customer's bank account. A date string in YYYY-MM-DD format.
        sig { returns(T.nilable(String)) }
        def expected_debit_date; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # ID of the mandate used to make this payment.
        sig { returns(T.nilable(String)) }
        def mandate; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class BacsDebit < ::Stripe::StripeObject
        # Estimated date to debit the customer's bank account. A date string in YYYY-MM-DD format.
        sig { returns(T.nilable(String)) }
        def expected_debit_date; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # ID of the mandate used to make this payment.
        sig { returns(T.nilable(String)) }
        def mandate; end
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
        # Bank code of bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_code; end
        # Name of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Bank Identifier Code of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bic; end
        # The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
        sig { returns(T.nilable(T.any(String, ::Stripe::PaymentMethod))) }
        def generated_sepa_debit; end
        # The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
        sig { returns(T.nilable(T.any(String, ::Stripe::Mandate))) }
        def generated_sepa_debit_mandate; end
        # Last four characters of the IBAN.
        sig { returns(T.nilable(String)) }
        def iban_last4; end
        # Preferred language of the Bancontact authorization page that the customer is redirected to.
        # Can be one of `en`, `de`, `fr`, or `nl`
        sig { returns(T.nilable(String)) }
        def preferred_language; end
        # Owner's verified full name. Values are verified or provided by Bancontact directly
        # (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        sig { returns(T.nilable(String)) }
        def verified_name; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Billie < ::Stripe::StripeObject
        # The Billie transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
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
        # A representation of a physical address.
        sig { returns(Address) }
        def address; end
        # The billing email associated with the method of payment.
        sig { returns(T.nilable(String)) }
        def email; end
        # The billing name associated with the method of payment.
        sig { returns(T.nilable(String)) }
        def name; end
        # The billing phone number associated with the method of payment.
        sig { returns(T.nilable(String)) }
        def phone; end
        def self.inner_class_types
          @inner_class_types = {address: Address}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Blik < ::Stripe::StripeObject
        # A unique and immutable identifier assigned by BLIK to every buyer.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Boleto < ::Stripe::StripeObject
        # The tax ID of the customer (CPF for individuals consumers or CNPJ for businesses consumers)
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
          # Attribute for field address_line1_check
          sig { returns(T.nilable(String)) }
          def address_line1_check; end
          # Attribute for field address_postal_code_check
          sig { returns(T.nilable(String)) }
          def address_postal_code_check; end
          # Attribute for field cvc_check
          sig { returns(T.nilable(String)) }
          def cvc_check; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Installments < ::Stripe::StripeObject
          class Plan < ::Stripe::StripeObject
            # For `fixed_count` installment plans, this is the number of installment payments your customer will make to their credit card.
            sig { returns(T.nilable(Integer)) }
            def count; end
            # For `fixed_count` installment plans, this is the interval between installment payments your customer will make to their credit card. One of `month`.
            sig { returns(T.nilable(String)) }
            def interval; end
            # Type of installment plan, one of `fixed_count`, `revolving`, or `bonus`.
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
        class NetworkToken < ::Stripe::StripeObject
          # Indicates if Stripe used a network token, either user provided or Stripe managed when processing the transaction.
          sig { returns(T::Boolean) }
          def used; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ThreeDSecure < ::Stripe::StripeObject
          # Attribute for field authentication_flow
          sig { returns(T.nilable(String)) }
          def authentication_flow; end
          # Attribute for field result
          sig { returns(T.nilable(String)) }
          def result; end
          # Attribute for field result_reason
          sig { returns(T.nilable(String)) }
          def result_reason; end
          # Attribute for field version
          sig { returns(T.nilable(String)) }
          def version; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Wallet < ::Stripe::StripeObject
          class ApplePay < ::Stripe::StripeObject
            # Type of the apple_pay transaction, one of `apple_pay` or `apple_pay_later`.
            sig { returns(String) }
            def type; end
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
          # Attribute for field apple_pay
          sig { returns(T.nilable(ApplePay)) }
          def apple_pay; end
          # (For tokenized numbers only.) The last four digits of the device account number.
          sig { returns(T.nilable(String)) }
          def dynamic_last4; end
          # Attribute for field google_pay
          sig { returns(T.nilable(GooglePay)) }
          def google_pay; end
          # The type of the card wallet, one of `apple_pay` or `google_pay`. An additional hash is included on the Wallet subhash with a name matching this value. It contains additional information specific to the card wallet type.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {apple_pay: ApplePay, google_pay: GooglePay}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The authorization code of the payment.
        sig { returns(T.nilable(String)) }
        def authorization_code; end
        # Card brand. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa` or `unknown`.
        sig { returns(String) }
        def brand; end
        # When using manual capture, a future timestamp at which the charge will be automatically refunded if uncaptured.
        sig { returns(T.nilable(Integer)) }
        def capture_before; end
        # Check results by Card networks on Card address and CVC at time of payment.
        sig { returns(T.nilable(Checks)) }
        def checks; end
        # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
        sig { returns(T.nilable(String)) }
        def country; end
        # A high-level description of the type of cards issued in this range.
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
        sig { returns(String) }
        def funding; end
        # Issuer identification number of the card.
        sig { returns(T.nilable(String)) }
        def iin; end
        # Installment details for this payment.
        sig { returns(T.nilable(Installments)) }
        def installments; end
        # The name of the card's issuing bank.
        sig { returns(T.nilable(String)) }
        def issuer; end
        # The last four digits of the card.
        sig { returns(String) }
        def last4; end
        # True if this payment was marked as MOTO and out of scope for SCA.
        sig { returns(T.nilable(T::Boolean)) }
        def moto; end
        # Identifies which network this charge was processed on. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `interac`, `jcb`, `link`, `mastercard`, `unionpay`, `visa`, or `unknown`.
        sig { returns(T.nilable(String)) }
        def network; end
        # Advice code from the card network for the failed payment.
        sig { returns(T.nilable(String)) }
        def network_advice_code; end
        # Decline code from the card network for the failed payment.
        sig { returns(T.nilable(String)) }
        def network_decline_code; end
        # If this card has network token credentials, this contains the details of the network token credentials.
        sig { returns(T.nilable(NetworkToken)) }
        def network_token; end
        # This is used by the financial networks to identify a transaction. Visa calls this the Transaction ID, Mastercard calls this the Trace ID, and American Express calls this the Acquirer Reference Data. This value will be present if it is returned by the financial network in the authorization response, and null otherwise.
        sig { returns(T.nilable(String)) }
        def network_transaction_id; end
        # The transaction type that was passed for an off-session, Merchant-Initiated transaction, one of `recurring` or `unscheduled`.
        sig { returns(T.nilable(String)) }
        def stored_credential_usage; end
        # Populated if this transaction used 3D Secure authentication.
        sig { returns(T.nilable(ThreeDSecure)) }
        def three_d_secure; end
        # If this Card is part of a card wallet, this contains the details of the card wallet.
        sig { returns(T.nilable(Wallet)) }
        def wallet; end
        def self.inner_class_types
          @inner_class_types = {
            checks: Checks,
            installments: Installments,
            network_token: NetworkToken,
            three_d_secure: ThreeDSecure,
            wallet: Wallet,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
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
      class Cashapp < ::Stripe::StripeObject
        # A unique and immutable identifier assigned by Cash App to every buyer.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # A public identifier for buyers using Cash App.
        sig { returns(T.nilable(String)) }
        def cashtag; end
        # A unique and immutable identifier of payments assigned by Cash App
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Crypto < ::Stripe::StripeObject
        # The wallet address of the customer.
        sig { returns(T.nilable(String)) }
        def buyer_address; end
        # The blockchain network that the transaction was sent on.
        sig { returns(T.nilable(String)) }
        def network; end
        # The token currency that the transaction was sent with.
        sig { returns(T.nilable(String)) }
        def token_currency; end
        # The blockchain transaction hash of the crypto payment.
        sig { returns(T.nilable(String)) }
        def transaction_hash; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Custom < ::Stripe::StripeObject
        # Display name for the custom (user-defined) payment method type used to make this payment.
        sig { returns(String) }
        def display_name; end
        # The custom payment method type associated with this payment.
        sig { returns(T.nilable(String)) }
        def type; end
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
        # Owner's verified full name. Values are verified or provided by EPS directly
        # (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        # EPS rarely provides this information so the attribute is usually empty.
        sig { returns(T.nilable(String)) }
        def verified_name; end
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
        # The customer's bank. Can be one of `affin_bank`, `agrobank`, `alliance_bank`, `ambank`, `bank_islam`, `bank_muamalat`, `bank_rakyat`, `bsn`, `cimb`, `hong_leong_bank`, `hsbc`, `kfh`, `maybank2u`, `ocbc`, `public_bank`, `rhb`, `standard_chartered`, `uob`, `deutsche_bank`, `maybank2e`, `pb_enterprise`, or `bank_of_china`.
        sig { returns(String) }
        def bank; end
        # Unique transaction id generated by FPX for every request from the merchant
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Giropay < ::Stripe::StripeObject
        # Bank code of bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_code; end
        # Name of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Bank Identifier Code of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bic; end
        # Owner's verified full name. Values are verified or provided by Giropay directly
        # (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        # Giropay rarely provides this information so the attribute is usually empty.
        sig { returns(T.nilable(String)) }
        def verified_name; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Grabpay < ::Stripe::StripeObject
        # Unique transaction id generated by GrabPay
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Ideal < ::Stripe::StripeObject
        # The customer's bank. Can be one of `abn_amro`, `asn_bank`, `bunq`, `buut`, `finom`, `handelsbanken`, `ing`, `knab`, `mollie`, `moneyou`, `n26`, `nn`, `rabobank`, `regiobank`, `revolut`, `sns_bank`, `triodos_bank`, `van_lanschot`, or `yoursafe`.
        sig { returns(T.nilable(String)) }
        def bank; end
        # The Bank Identifier Code of the customer's bank.
        sig { returns(T.nilable(String)) }
        def bic; end
        # The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
        sig { returns(T.nilable(T.any(String, ::Stripe::PaymentMethod))) }
        def generated_sepa_debit; end
        # The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
        sig { returns(T.nilable(T.any(String, ::Stripe::Mandate))) }
        def generated_sepa_debit_mandate; end
        # Last four characters of the IBAN.
        sig { returns(T.nilable(String)) }
        def iban_last4; end
        # Unique transaction ID generated by iDEAL.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        # Owner's verified full name. Values are verified or provided by iDEAL directly
        # (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        sig { returns(T.nilable(String)) }
        def verified_name; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class InteracPresent < ::Stripe::StripeObject
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
        # The languages that the issuing bank recommends using for localizing any customer-facing text, as read from the card. Referenced from EMV tag 5F2D, data encoded on the card's chip.
        sig { returns(T.nilable(T::Array[String])) }
        def preferred_locales; end
        # How card details were read in this transaction.
        sig { returns(T.nilable(String)) }
        def read_method; end
        # A collection of fields required to be displayed on receipts. Only required for EMV transactions.
        sig { returns(T.nilable(Receipt)) }
        def receipt; end
        def self.inner_class_types
          @inner_class_types = {receipt: Receipt}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class KakaoPay < ::Stripe::StripeObject
        # A unique identifier for the buyer as determined by the local payment processor.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # The Kakao Pay transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Klarna < ::Stripe::StripeObject
        class PayerDetails < ::Stripe::StripeObject
          class Address < ::Stripe::StripeObject
            # The payer address country
            sig { returns(T.nilable(String)) }
            def country; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The payer's address
          sig { returns(T.nilable(Address)) }
          def address; end
          def self.inner_class_types
            @inner_class_types = {address: Address}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The payer details for this transaction.
        sig { returns(T.nilable(PayerDetails)) }
        def payer_details; end
        # The Klarna payment method used for this transaction.
        # Can be one of `pay_later`, `pay_now`, `pay_with_financing`, or `pay_in_installments`
        sig { returns(T.nilable(String)) }
        def payment_method_category; end
        # Preferred language of the Klarna authorization page that the customer is redirected to.
        # Can be one of `de-AT`, `en-AT`, `nl-BE`, `fr-BE`, `en-BE`, `de-DE`, `en-DE`, `da-DK`, `en-DK`, `es-ES`, `en-ES`, `fi-FI`, `sv-FI`, `en-FI`, `en-GB`, `en-IE`, `it-IT`, `en-IT`, `nl-NL`, `en-NL`, `nb-NO`, `en-NO`, `sv-SE`, `en-SE`, `en-US`, `es-US`, `fr-FR`, `en-FR`, `cs-CZ`, `en-CZ`, `ro-RO`, `en-RO`, `el-GR`, `en-GR`, `en-AU`, `en-NZ`, `en-CA`, `fr-CA`, `pl-PL`, `en-PL`, `pt-PT`, `en-PT`, `de-CH`, `fr-CH`, `it-CH`, or `en-CH`
        sig { returns(T.nilable(String)) }
        def preferred_locale; end
        def self.inner_class_types
          @inner_class_types = {payer_details: PayerDetails}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Konbini < ::Stripe::StripeObject
        class Store < ::Stripe::StripeObject
          # The name of the convenience store chain where the payment was completed.
          sig { returns(T.nilable(String)) }
          def chain; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # If the payment succeeded, this contains the details of the convenience store where the payment was completed.
        sig { returns(T.nilable(Store)) }
        def store; end
        def self.inner_class_types
          @inner_class_types = {store: Store}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class KrCard < ::Stripe::StripeObject
        # The local credit or debit card brand.
        sig { returns(T.nilable(String)) }
        def brand; end
        # A unique identifier for the buyer as determined by the local payment processor.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # The last four digits of the card. This may not be present for American Express cards.
        sig { returns(T.nilable(String)) }
        def last4; end
        # The Korean Card transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Link < ::Stripe::StripeObject
        # Two-letter ISO code representing the funding source country beneath the Link payment.
        # You could use this attribute to get a sense of international fees.
        sig { returns(T.nilable(String)) }
        def country; end
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
        class Card < ::Stripe::StripeObject
          # Brand of the card used in the transaction
          sig { returns(T.nilable(String)) }
          def brand; end
          # Two-letter ISO code representing the country of the card
          sig { returns(T.nilable(String)) }
          def country; end
          # Two digit number representing the card's expiration month
          sig { returns(T.nilable(Integer)) }
          def exp_month; end
          # Two digit number representing the card's expiration year
          sig { returns(T.nilable(Integer)) }
          def exp_year; end
          # The last 4 digits of the card
          sig { returns(T.nilable(String)) }
          def last4; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Internal card details
        sig { returns(T.nilable(Card)) }
        def card; end
        def self.inner_class_types
          @inner_class_types = {card: Card}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Multibanco < ::Stripe::StripeObject
        # Entity number associated with this Multibanco payment.
        sig { returns(T.nilable(String)) }
        def entity; end
        # Reference number associated with this Multibanco payment.
        sig { returns(T.nilable(String)) }
        def reference; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class NaverPay < ::Stripe::StripeObject
        # A unique identifier for the buyer as determined by the local payment processor.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # The Naver Pay transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
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
        # Estimated date to debit the customer's bank account. A date string in YYYY-MM-DD format.
        sig { returns(T.nilable(String)) }
        def expected_debit_date; end
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
        # OXXO reference number
        sig { returns(T.nilable(String)) }
        def number; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class P24 < ::Stripe::StripeObject
        # The customer's bank. Can be one of `ing`, `citi_handlowy`, `tmobile_usbugi_bankowe`, `plus_bank`, `etransfer_pocztowy24`, `banki_spbdzielcze`, `bank_nowy_bfg_sa`, `getin_bank`, `velobank`, `blik`, `noble_pay`, `ideabank`, `envelobank`, `santander_przelew24`, `nest_przelew`, `mbank_mtransfer`, `inteligo`, `pbac_z_ipko`, `bnp_paribas`, `credit_agricole`, `toyota_bank`, `bank_pekao_sa`, `volkswagen_bank`, `bank_millennium`, `alior_bank`, or `boz`.
        sig { returns(T.nilable(String)) }
        def bank; end
        # Unique reference for this Przelewy24 payment.
        sig { returns(T.nilable(String)) }
        def reference; end
        # Owner's verified full name. Values are verified or provided by Przelewy24 directly
        # (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        # Przelewy24 rarely provides this information so the attribute is usually empty.
        sig { returns(T.nilable(String)) }
        def verified_name; end
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
        # A unique identifier for the buyer as determined by the local payment processor.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # The Payco transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Paynow < ::Stripe::StripeObject
        # ID of the [location](https://docs.stripe.com/api/terminal/locations) that this transaction's reader is assigned to.
        sig { returns(T.nilable(String)) }
        def location; end
        # ID of the [reader](https://docs.stripe.com/api/terminal/readers) this transaction was made on.
        sig { returns(T.nilable(String)) }
        def reader; end
        # Reference number associated with this PayNow payment
        sig { returns(T.nilable(String)) }
        def reference; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Paypal < ::Stripe::StripeObject
        class SellerProtection < ::Stripe::StripeObject
          # An array of conditions that are covered for the transaction, if applicable.
          sig { returns(T.nilable(T::Array[String])) }
          def dispute_categories; end
          # Indicates whether the transaction is eligible for PayPal's seller protection.
          sig { returns(String) }
          def status; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
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
        # Owner's full name. Values provided by PayPal directly
        # (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        sig { returns(T.nilable(String)) }
        def payer_name; end
        # The level of protection offered as defined by PayPal Seller Protection for Merchants, for this transaction.
        sig { returns(T.nilable(SellerProtection)) }
        def seller_protection; end
        # A unique ID generated by PayPal for this transaction.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {seller_protection: SellerProtection}
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
        # ID of the mandate used to make this payment.
        sig { returns(T.nilable(String)) }
        def mandate; end
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
        # Unique transaction id generated by BCB
        sig { returns(T.nilable(String)) }
        def bank_transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Promptpay < ::Stripe::StripeObject
        # Bill reference generated by PromptPay
        sig { returns(T.nilable(String)) }
        def reference; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RevolutPay < ::Stripe::StripeObject
        class Funding < ::Stripe::StripeObject
          class Card < ::Stripe::StripeObject
            # Card brand. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa` or `unknown`.
            sig { returns(T.nilable(String)) }
            def brand; end
            # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
            sig { returns(T.nilable(String)) }
            def country; end
            # Two-digit number representing the card's expiration month.
            sig { returns(T.nilable(Integer)) }
            def exp_month; end
            # Four-digit number representing the card's expiration year.
            sig { returns(T.nilable(Integer)) }
            def exp_year; end
            # Card funding type. Can be `credit`, `debit`, `prepaid`, or `unknown`.
            sig { returns(T.nilable(String)) }
            def funding; end
            # The last four digits of the card.
            sig { returns(T.nilable(String)) }
            def last4; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field card
          sig { returns(T.nilable(Card)) }
          def card; end
          # funding type of the underlying payment method.
          sig { returns(T.nilable(String)) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {card: Card}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field funding
        sig { returns(T.nilable(Funding)) }
        def funding; end
        # The Revolut Pay transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {funding: Funding}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SamsungPay < ::Stripe::StripeObject
        # A unique identifier for the buyer as determined by the local payment processor.
        sig { returns(T.nilable(String)) }
        def buyer_id; end
        # The Samsung Pay transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Satispay < ::Stripe::StripeObject
        # The Satispay transaction ID associated with this payment.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SepaCreditTransfer < ::Stripe::StripeObject
        # Name of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Bank Identifier Code of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bic; end
        # IBAN of the bank account to transfer funds to.
        sig { returns(T.nilable(String)) }
        def iban; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SepaDebit < ::Stripe::StripeObject
        # Bank code of bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_code; end
        # Branch code of bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def branch_code; end
        # Two-letter ISO code representing the country the bank account is located in.
        sig { returns(T.nilable(String)) }
        def country; end
        # Estimated date to debit the customer's bank account. A date string in YYYY-MM-DD format.
        sig { returns(T.nilable(String)) }
        def expected_debit_date; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Last four characters of the IBAN.
        sig { returns(T.nilable(String)) }
        def last4; end
        # Find the ID of the mandate used for this payment under the [payment_method_details.sepa_debit.mandate](https://docs.stripe.com/api/charges/object#charge_object-payment_method_details-sepa_debit-mandate) property on the Charge. Use this mandate ID to [retrieve the Mandate](https://docs.stripe.com/api/mandates/retrieve).
        sig { returns(T.nilable(String)) }
        def mandate; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Sofort < ::Stripe::StripeObject
        # Bank code of bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_code; end
        # Name of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Bank Identifier Code of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bic; end
        # Two-letter ISO code representing the country the bank account is located in.
        sig { returns(T.nilable(String)) }
        def country; end
        # The ID of the SEPA Direct Debit PaymentMethod which was generated by this Charge.
        sig { returns(T.nilable(T.any(String, ::Stripe::PaymentMethod))) }
        def generated_sepa_debit; end
        # The mandate for the SEPA Direct Debit PaymentMethod which was generated by this Charge.
        sig { returns(T.nilable(T.any(String, ::Stripe::Mandate))) }
        def generated_sepa_debit_mandate; end
        # Last four characters of the IBAN.
        sig { returns(T.nilable(String)) }
        def iban_last4; end
        # Preferred language of the SOFORT authorization page that the customer is redirected to.
        # Can be one of `de`, `en`, `es`, `fr`, `it`, `nl`, or `pl`
        sig { returns(T.nilable(String)) }
        def preferred_language; end
        # Owner's verified full name. Values are verified or provided by SOFORT directly
        # (if supported) at the time of authorization or settlement. They cannot be set or mutated.
        sig { returns(T.nilable(String)) }
        def verified_name; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StripeAccount < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Swish < ::Stripe::StripeObject
        # Uniquely identifies the payer's Swish account. You can use this attribute to check whether two Swish transactions were paid for by the same payer
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Payer bank reference number for the payment
        sig { returns(T.nilable(String)) }
        def payment_reference; end
        # The last four digits of the Swish account phone number
        sig { returns(T.nilable(String)) }
        def verified_phone_last4; end
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
        # The type of entity that holds the account. This can be either 'individual' or 'company'.
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        # The type of the bank account. This can be either 'checking' or 'savings'.
        sig { returns(T.nilable(String)) }
        def account_type; end
        # Name of the bank associated with the bank account.
        sig { returns(T.nilable(String)) }
        def bank_name; end
        # Estimated date to debit the customer's bank account. A date string in YYYY-MM-DD format.
        sig { returns(T.nilable(String)) }
        def expected_debit_date; end
        # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # Last four digits of the bank account number.
        sig { returns(T.nilable(String)) }
        def last4; end
        # ID of the mandate used to make this payment.
        sig { returns(T.nilable(T.any(String, ::Stripe::Mandate))) }
        def mandate; end
        # The ACH payment reference for this transaction.
        sig { returns(T.nilable(String)) }
        def payment_reference; end
        # The routing number for the bank account.
        sig { returns(T.nilable(String)) }
        def routing_number; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Wechat < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class WechatPay < ::Stripe::StripeObject
        # Uniquely identifies this particular WeChat Pay account. You can use this attribute to check whether two WeChat accounts are the same.
        sig { returns(T.nilable(String)) }
        def fingerprint; end
        # ID of the [location](https://docs.stripe.com/api/terminal/locations) that this transaction's reader is assigned to.
        sig { returns(T.nilable(String)) }
        def location; end
        # ID of the [reader](https://docs.stripe.com/api/terminal/readers) this transaction was made on.
        sig { returns(T.nilable(String)) }
        def reader; end
        # Transaction ID of this particular WeChat Pay transaction.
        sig { returns(T.nilable(String)) }
        def transaction_id; end
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
      # Attribute for field ach_credit_transfer
      sig { returns(T.nilable(AchCreditTransfer)) }
      def ach_credit_transfer; end
      # Attribute for field ach_debit
      sig { returns(T.nilable(AchDebit)) }
      def ach_debit; end
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
      # The billing details associated with the method of payment.
      sig { returns(T.nilable(BillingDetails)) }
      def billing_details; end
      # Attribute for field blik
      sig { returns(T.nilable(Blik)) }
      def blik; end
      # Attribute for field boleto
      sig { returns(T.nilable(Boleto)) }
      def boleto; end
      # Details of the card used for this payment attempt.
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
      # Custom Payment Methods represent Payment Method types not modeled directly in
      # the Stripe API. This resource consists of details about the custom payment method
      # used for this payment attempt.
      sig { returns(T.nilable(Custom)) }
      def custom; end
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
      # ID of the Stripe PaymentMethod used to make this payment.
      sig { returns(T.nilable(String)) }
      def payment_method; end
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
      # Attribute for field sepa_credit_transfer
      sig { returns(T.nilable(SepaCreditTransfer)) }
      def sepa_credit_transfer; end
      # Attribute for field sepa_debit
      sig { returns(T.nilable(SepaDebit)) }
      def sepa_debit; end
      # Attribute for field sofort
      sig { returns(T.nilable(Sofort)) }
      def sofort; end
      # Attribute for field stripe_account
      sig { returns(T.nilable(StripeAccount)) }
      def stripe_account; end
      # Attribute for field swish
      sig { returns(T.nilable(Swish)) }
      def swish; end
      # Attribute for field twint
      sig { returns(T.nilable(Twint)) }
      def twint; end
      # The type of transaction-specific details of the payment method used in the payment. See [PaymentMethod.type](https://docs.stripe.com/api/payment_methods/object#payment_method_object-type) for the full list of possible types.
      # An additional hash is included on `payment_method_details` with a name matching this value.
      # It contains information specific to the payment method.
      sig { returns(String) }
      def type; end
      # Attribute for field us_bank_account
      sig { returns(T.nilable(UsBankAccount)) }
      def us_bank_account; end
      # Attribute for field wechat
      sig { returns(T.nilable(Wechat)) }
      def wechat; end
      # Attribute for field wechat_pay
      sig { returns(T.nilable(WechatPay)) }
      def wechat_pay; end
      # Attribute for field zip
      sig { returns(T.nilable(Zip)) }
      def zip; end
      def self.inner_class_types
        @inner_class_types = {
          ach_credit_transfer: AchCreditTransfer,
          ach_debit: AchDebit,
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
          custom: Custom,
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
          sepa_credit_transfer: SepaCreditTransfer,
          sepa_debit: SepaDebit,
          sofort: Sofort,
          stripe_account: StripeAccount,
          swish: Swish,
          twint: Twint,
          us_bank_account: UsBankAccount,
          wechat: Wechat,
          wechat_pay: WechatPay,
          zip: Zip,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ProcessorDetails < ::Stripe::StripeObject
      class Custom < ::Stripe::StripeObject
        # An opaque string for manual reconciliation of this payment, for example a check number or a payment processor ID.
        sig { returns(T.nilable(String)) }
        def payment_reference; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Custom processors represent payment processors not modeled directly in
      # the Stripe API. This resource consists of details about the custom processor
      # used for this payment attempt.
      sig { returns(T.nilable(Custom)) }
      def custom; end
      # The processor used for this payment attempt.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {custom: Custom}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ShippingDetails < ::Stripe::StripeObject
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
      # A representation of a physical address.
      sig { returns(Address) }
      def address; end
      # The shipping recipient's name.
      sig { returns(T.nilable(String)) }
      def name; end
      # The shipping recipient's phone number.
      sig { returns(T.nilable(String)) }
      def phone; end
      def self.inner_class_types
        @inner_class_types = {address: Address}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # A representation of an amount of money, consisting of an amount and a currency.
    sig { returns(Amount) }
    def amount; end
    # A representation of an amount of money, consisting of an amount and a currency.
    sig { returns(AmountAuthorized) }
    def amount_authorized; end
    # A representation of an amount of money, consisting of an amount and a currency.
    sig { returns(AmountCanceled) }
    def amount_canceled; end
    # A representation of an amount of money, consisting of an amount and a currency.
    sig { returns(AmountFailed) }
    def amount_failed; end
    # A representation of an amount of money, consisting of an amount and a currency.
    sig { returns(AmountGuaranteed) }
    def amount_guaranteed; end
    # A representation of an amount of money, consisting of an amount and a currency.
    sig { returns(AmountRefunded) }
    def amount_refunded; end
    # A representation of an amount of money, consisting of an amount and a currency.
    sig { returns(AmountRequested) }
    def amount_requested; end
    # ID of the Connect application that created the PaymentRecord.
    sig { returns(T.nilable(String)) }
    def application; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Customer information for this payment.
    sig { returns(T.nilable(CustomerDetails)) }
    def customer_details; end
    # Indicates whether the customer was present in your checkout flow during this payment.
    sig { returns(T.nilable(String)) }
    def customer_presence; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # ID of the latest Payment Attempt Record attached to this Payment Record.
    sig { returns(T.nilable(String)) }
    def latest_payment_attempt_record; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Information about the Payment Method debited for this payment.
    sig { returns(T.nilable(PaymentMethodDetails)) }
    def payment_method_details; end
    # Processor information associated with this payment.
    sig { returns(ProcessorDetails) }
    def processor_details; end
    # Indicates who reported the payment.
    sig { returns(String) }
    def reported_by; end
    # Shipping information for this payment.
    sig { returns(T.nilable(ShippingDetails)) }
    def shipping_details; end
    # Report a new Payment Record. You may report a Payment Record as it is
    #  initialized and later report updates through the other report_* methods, or report Payment
    #  Records in a terminal state directly, through this method.
    sig {
      params(params: T.any(::Stripe::PaymentRecordReportPaymentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def self.report_payment(params = {}, opts = {}); end

    # Report a new payment attempt on the specified Payment Record. A new payment
    #  attempt can only be specified if all other payment attempts are canceled or failed.
    sig {
      params(params: T.any(::Stripe::PaymentRecordReportPaymentAttemptParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt(params = {}, opts = {}); end

    # Report a new payment attempt on the specified Payment Record. A new payment
    #  attempt can only be specified if all other payment attempts are canceled or failed.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def self.report_payment_attempt(id, params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was canceled.
    sig {
      params(params: T.any(::Stripe::PaymentRecordReportPaymentAttemptCanceledParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt_canceled(params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was canceled.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptCanceledParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def self.report_payment_attempt_canceled(id, params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  failed or errored.
    sig {
      params(params: T.any(::Stripe::PaymentRecordReportPaymentAttemptFailedParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt_failed(params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  failed or errored.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptFailedParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def self.report_payment_attempt_failed(id, params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was guaranteed.
    sig {
      params(params: T.any(::Stripe::PaymentRecordReportPaymentAttemptGuaranteedParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt_guaranteed(params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was guaranteed.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptGuaranteedParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def self.report_payment_attempt_guaranteed(id, params = {}, opts = {}); end

    # Report informational updates on the specified Payment Record.
    sig {
      params(params: T.any(::Stripe::PaymentRecordReportPaymentAttemptInformationalParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_payment_attempt_informational(params = {}, opts = {}); end

    # Report informational updates on the specified Payment Record.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportPaymentAttemptInformationalParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def self.report_payment_attempt_informational(id, params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was refunded.
    sig {
      params(params: T.any(::Stripe::PaymentRecordReportRefundParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def report_refund(params = {}, opts = {}); end

    # Report that the most recent payment attempt on the specified Payment Record
    #  was refunded.
    sig {
      params(id: String, params: T.any(::Stripe::PaymentRecordReportRefundParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentRecord)
     }
    def self.report_refund(id, params = {}, opts = {}); end
  end
end