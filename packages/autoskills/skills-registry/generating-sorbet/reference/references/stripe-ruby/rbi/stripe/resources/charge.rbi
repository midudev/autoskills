# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # The `Charge` object represents a single attempt to move money into your Stripe account.
  # PaymentIntent confirmation is the most common way to create Charges, but [Account Debits](https://docs.stripe.com/connect/account-debits) may also create Charges.
  # Some legacy payment flows create Charges directly, which is not recommended for new integrations.
  class Charge < APIResource
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
    class FraudDetails < ::Stripe::StripeObject
      # Assessments from Stripe. If set, the value is `fraudulent`.
      sig { returns(T.nilable(String)) }
      def stripe_report; end
      # Assessments reported by you. If set, possible values of are `safe` and `fraudulent`.
      sig { returns(T.nilable(String)) }
      def user_report; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Level3 < ::Stripe::StripeObject
      class LineItem < ::Stripe::StripeObject
        # Attribute for field discount_amount
        sig { returns(T.nilable(Integer)) }
        def discount_amount; end
        # Attribute for field product_code
        sig { returns(String) }
        def product_code; end
        # Attribute for field product_description
        sig { returns(String) }
        def product_description; end
        # Attribute for field quantity
        sig { returns(T.nilable(Integer)) }
        def quantity; end
        # Attribute for field tax_amount
        sig { returns(T.nilable(Integer)) }
        def tax_amount; end
        # Attribute for field unit_cost
        sig { returns(T.nilable(Integer)) }
        def unit_cost; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field customer_reference
      sig { returns(T.nilable(String)) }
      def customer_reference; end
      # Attribute for field line_items
      sig { returns(T::Array[LineItem]) }
      def line_items; end
      # Attribute for field merchant_reference
      sig { returns(String) }
      def merchant_reference; end
      # Attribute for field shipping_address_zip
      sig { returns(T.nilable(String)) }
      def shipping_address_zip; end
      # Attribute for field shipping_amount
      sig { returns(T.nilable(Integer)) }
      def shipping_amount; end
      # Attribute for field shipping_from_zip
      sig { returns(T.nilable(String)) }
      def shipping_from_zip; end
      def self.inner_class_types
        @inner_class_types = {line_items: LineItem}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Outcome < ::Stripe::StripeObject
      class Rule < ::Stripe::StripeObject
        # The action taken on the payment.
        sig { returns(String) }
        def action; end
        # Unique identifier for the object.
        sig { returns(String) }
        def id; end
        # The predicate to evaluate the payment against.
        sig { returns(String) }
        def predicate; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # An enumerated value providing a more detailed explanation on [how to proceed with an error](https://docs.stripe.com/declines#retrying-issuer-declines).
      sig { returns(T.nilable(String)) }
      def advice_code; end
      # For charges declined by the network, a 2 digit code which indicates the advice returned by the network on how to proceed with an error.
      sig { returns(T.nilable(String)) }
      def network_advice_code; end
      # For charges declined by the network, an alphanumeric code which indicates the reason the charge failed.
      sig { returns(T.nilable(String)) }
      def network_decline_code; end
      # Possible values are `approved_by_network`, `declined_by_network`, `not_sent_to_network`, and `reversed_after_approval`. The value `reversed_after_approval` indicates the payment was [blocked by Stripe](https://docs.stripe.com/declines#blocked-payments) after bank authorization, and may temporarily appear as "pending" on a cardholder's statement.
      sig { returns(T.nilable(String)) }
      def network_status; end
      # An enumerated value providing a more detailed explanation of the outcome's `type`. Charges blocked by Radar's default block rule have the value `highest_risk_level`. Charges placed in review by Radar's default review rule have the value `elevated_risk_level`. Charges blocked because the payment is unlikely to be authorized have the value `low_probability_of_authorization`. Charges authorized, blocked, or placed in review by custom rules have the value `rule`. See [understanding declines](https://docs.stripe.com/declines) for more details.
      sig { returns(T.nilable(String)) }
      def reason; end
      # Stripe Radar's evaluation of the riskiness of the payment. Possible values for evaluated payments are `normal`, `elevated`, `highest`. For non-card payments, and card-based payments predating the public assignment of risk levels, this field will have the value `not_assessed`. In the event of an error in the evaluation, this field will have the value `unknown`. This field is only available with Radar.
      sig { returns(T.nilable(String)) }
      def risk_level; end
      # Stripe Radar's evaluation of the riskiness of the payment. Possible values for evaluated payments are between 0 and 100. For non-card payments, card-based payments predating the public assignment of risk scores, or in the event of an error during evaluation, this field will not be present. This field is only available with Radar for Fraud Teams.
      sig { returns(T.nilable(Integer)) }
      def risk_score; end
      # The ID of the Radar rule that matched the payment, if applicable.
      sig { returns(T.nilable(T.any(String, Rule))) }
      def rule; end
      # A human-readable description of the outcome type and reason, designed for you (the recipient of the payment), not your customer.
      sig { returns(T.nilable(String)) }
      def seller_message; end
      # Possible values are `authorized`, `manual_review`, `issuer_declined`, `blocked`, and `invalid`. See [understanding declines](https://docs.stripe.com/declines) and [Radar reviews](https://docs.stripe.com/radar/reviews) for details.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {rule: Rule}
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
        class ExtendedAuthorization < ::Stripe::StripeObject
          # Indicates whether or not the capture window is extended beyond the standard authorization.
          sig { returns(String) }
          def status; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class IncrementalAuthorization < ::Stripe::StripeObject
          # Indicates whether or not the incremental authorization feature is supported.
          sig { returns(String) }
          def status; end
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
          # Installment plan selected for the payment.
          sig { returns(T.nilable(Plan)) }
          def plan; end
          def self.inner_class_types
            @inner_class_types = {plan: Plan}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Multicapture < ::Stripe::StripeObject
          # Indicates whether or not multiple captures are supported.
          sig { returns(String) }
          def status; end
          def self.inner_class_types
            @inner_class_types = {}
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
        class Overcapture < ::Stripe::StripeObject
          # The maximum amount that can be captured.
          sig { returns(Integer) }
          def maximum_amount_capturable; end
          # Indicates whether or not the authorized amount can be over-captured.
          sig { returns(String) }
          def status; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class ThreeDSecure < ::Stripe::StripeObject
          # For authenticated transactions: how the customer was authenticated by
          # the issuing bank.
          sig { returns(T.nilable(String)) }
          def authentication_flow; end
          # The Electronic Commerce Indicator (ECI). A protocol-level field
          # indicating what degree of authentication was performed.
          sig { returns(T.nilable(String)) }
          def electronic_commerce_indicator; end
          # The exemption requested via 3DS and accepted by the issuer at authentication time.
          sig { returns(T.nilable(String)) }
          def exemption_indicator; end
          # Whether Stripe requested the value of `exemption_indicator` in the transaction. This will depend on
          # the outcome of Stripe's internal risk assessment.
          sig { returns(T.nilable(T::Boolean)) }
          def exemption_indicator_applied; end
          # Indicates the outcome of 3D Secure authentication.
          sig { returns(T.nilable(String)) }
          def result; end
          # Additional information about why 3D Secure succeeded or failed based
          # on the `result`.
          sig { returns(T.nilable(String)) }
          def result_reason; end
          # The 3D Secure 1 XID or 3D Secure 2 Directory Server Transaction ID
          # (dsTransId) for this payment.
          sig { returns(T.nilable(String)) }
          def transaction_id; end
          # The version of 3D Secure that was used.
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
        # The authorized amount.
        sig { returns(T.nilable(Integer)) }
        def amount_authorized; end
        # Authorization code on the charge.
        sig { returns(T.nilable(String)) }
        def authorization_code; end
        # Card brand. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `jcb`, `link`, `mastercard`, `unionpay`, `visa` or `unknown`.
        sig { returns(T.nilable(String)) }
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
        # A high-level description of the type of cards issued in this range. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def description; end
        # Two-digit number representing the card's expiration month.
        sig { returns(Integer) }
        def exp_month; end
        # Four-digit number representing the card's expiration year.
        sig { returns(Integer) }
        def exp_year; end
        # Attribute for field extended_authorization
        sig { returns(T.nilable(ExtendedAuthorization)) }
        def extended_authorization; end
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
        # Attribute for field incremental_authorization
        sig { returns(T.nilable(IncrementalAuthorization)) }
        def incremental_authorization; end
        # Installment details for this payment.
        #
        # For more information, see the [installments integration guide](https://docs.stripe.com/payments/installments).
        sig { returns(T.nilable(Installments)) }
        def installments; end
        # The name of the card's issuing bank. (For internal use only and not typically available in standard API requests.)
        sig { returns(T.nilable(String)) }
        def issuer; end
        # The last four digits of the card.
        sig { returns(T.nilable(String)) }
        def last4; end
        # ID of the mandate used to make this payment or created by it.
        sig { returns(T.nilable(String)) }
        def mandate; end
        # True if this payment was marked as MOTO and out of scope for SCA.
        sig { returns(T.nilable(T::Boolean)) }
        def moto; end
        # Attribute for field multicapture
        sig { returns(T.nilable(Multicapture)) }
        def multicapture; end
        # Identifies which network this charge was processed on. Can be `amex`, `cartes_bancaires`, `diners`, `discover`, `eftpos_au`, `interac`, `jcb`, `link`, `mastercard`, `unionpay`, `visa`, or `unknown`.
        sig { returns(T.nilable(String)) }
        def network; end
        # If this card has network token credentials, this contains the details of the network token credentials.
        sig { returns(T.nilable(NetworkToken)) }
        def network_token; end
        # This is used by the financial networks to identify a transaction. Visa calls this the Transaction ID, Mastercard calls this the Trace ID, and American Express calls this the Acquirer Reference Data. This value will be present if it is returned by the financial network in the authorization response, and null otherwise.
        sig { returns(T.nilable(String)) }
        def network_transaction_id; end
        # Attribute for field overcapture
        sig { returns(T.nilable(Overcapture)) }
        def overcapture; end
        # Status of a card based on the card issuer.
        sig { returns(T.nilable(String)) }
        def regulated_status; end
        # Populated if this transaction used 3D Secure authentication.
        sig { returns(T.nilable(ThreeDSecure)) }
        def three_d_secure; end
        # If this Card is part of a card wallet, this contains the details of the card wallet.
        sig { returns(T.nilable(Wallet)) }
        def wallet; end
        def self.inner_class_types
          @inner_class_types = {
            checks: Checks,
            extended_authorization: ExtendedAuthorization,
            incremental_authorization: IncrementalAuthorization,
            installments: Installments,
            multicapture: Multicapture,
            network_token: NetworkToken,
            overcapture: Overcapture,
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
        # Account holder type: individual or company.
        sig { returns(T.nilable(String)) }
        def account_holder_type; end
        # Account type: checkings or savings. Defaults to checking if omitted.
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
        # Reference number to locate ACH payments with customer's bank.
        sig { returns(T.nilable(String)) }
        def payment_reference; end
        # Routing number of the bank account.
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
    class PresentmentDetails < ::Stripe::StripeObject
      # Amount intended to be collected by this payment, denominated in `presentment_currency`.
      sig { returns(Integer) }
      def presentment_amount; end
      # Currency presented to the customer during payment.
      sig { returns(String) }
      def presentment_currency; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class RadarOptions < ::Stripe::StripeObject
      # A [Radar Session](https://docs.stripe.com/radar/radar-session) is a snapshot of the browser metadata and device details that help Radar make more accurate predictions on your payments.
      sig { returns(T.nilable(String)) }
      def session; end
      def self.inner_class_types
        @inner_class_types = {}
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
      sig { returns(T.nilable(Address)) }
      def address; end
      # The delivery service that shipped a physical product, such as Fedex, UPS, USPS, etc.
      sig { returns(T.nilable(String)) }
      def carrier; end
      # Recipient name.
      sig { returns(T.nilable(String)) }
      def name; end
      # Recipient phone (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      # The tracking number for a physical product, obtained from the delivery service. If multiple tracking numbers were generated for this purchase, please separate them with commas.
      sig { returns(T.nilable(String)) }
      def tracking_number; end
      def self.inner_class_types
        @inner_class_types = {address: Address}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TransferData < ::Stripe::StripeObject
      # The amount transferred to the destination account, if specified. By default, the entire charge amount is transferred to the destination account.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      # ID of an existing, connected Stripe account to transfer funds to if `transfer_data` was specified in the charge request.
      sig { returns(T.any(String, ::Stripe::Account)) }
      def destination; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Amount intended to be collected by this payment. A positive integer representing how much to charge in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) (e.g., 100 cents to charge $1.00 or 100 to charge ¥100, a zero-decimal currency). The minimum amount is $0.50 US or [equivalent in charge currency](https://docs.stripe.com/currencies#minimum-and-maximum-charge-amounts). The amount value supports up to eight digits (e.g., a value of 99999999 for a USD charge of $999,999.99).
    sig { returns(Integer) }
    def amount; end
    # Amount in cents (or local equivalent) captured (can be less than the amount attribute on the charge if a partial capture was made).
    sig { returns(Integer) }
    def amount_captured; end
    # Amount in cents (or local equivalent) refunded (can be less than the amount attribute on the charge if a partial refund was issued).
    sig { returns(Integer) }
    def amount_refunded; end
    # ID of the Connect application that created the charge.
    sig { returns(T.nilable(T.any(String, ::Stripe::Application))) }
    def application; end
    # The application fee (if any) for the charge. [See the Connect documentation](https://docs.stripe.com/connect/direct-charges#collect-fees) for details.
    sig { returns(T.nilable(T.any(String, ::Stripe::ApplicationFee))) }
    def application_fee; end
    # The amount of the application fee (if any) requested for the charge. [See the Connect documentation](https://docs.stripe.com/connect/direct-charges#collect-fees) for details.
    sig { returns(T.nilable(Integer)) }
    def application_fee_amount; end
    # Authorization code on the charge.
    sig { returns(T.nilable(String)) }
    def authorization_code; end
    # ID of the balance transaction that describes the impact of this charge on your account balance (not including refunds or disputes).
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def balance_transaction; end
    # Attribute for field billing_details
    sig { returns(BillingDetails) }
    def billing_details; end
    # The full statement descriptor that is passed to card networks, and that is displayed on your customers' credit card and bank statements. Allows you to see what the statement descriptor looks like after the static and dynamic portions are combined. This value only exists for card payments.
    sig { returns(T.nilable(String)) }
    def calculated_statement_descriptor; end
    # If the charge was created without capturing, this Boolean represents whether it is still uncaptured or has since been captured.
    sig { returns(T::Boolean) }
    def captured; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # ID of the customer this charge is for if one exists.
    sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
    def customer; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # Whether the charge has been disputed.
    sig { returns(T::Boolean) }
    def disputed; end
    # ID of the balance transaction that describes the reversal of the balance on your account due to payment failure.
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def failure_balance_transaction; end
    # Error code explaining reason for charge failure if available (see [the errors section](https://docs.stripe.com/error-codes) for a list of codes).
    sig { returns(T.nilable(String)) }
    def failure_code; end
    # Message to user further explaining reason for charge failure if available.
    sig { returns(T.nilable(String)) }
    def failure_message; end
    # Information on fraud assessments for the charge.
    sig { returns(T.nilable(FraudDetails)) }
    def fraud_details; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Attribute for field level3
    sig { returns(T.nilable(Level3)) }
    def level3; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The account (if any) the charge was made on behalf of without triggering an automatic transfer. See the [Connect documentation](https://docs.stripe.com/connect/separate-charges-and-transfers) for details.
    sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
    def on_behalf_of; end
    # Details about whether the payment was accepted, and why. See [understanding declines](https://docs.stripe.com/declines) for details.
    sig { returns(T.nilable(Outcome)) }
    def outcome; end
    # `true` if the charge succeeded, or was successfully authorized for later capture.
    sig { returns(T::Boolean) }
    def paid; end
    # ID of the PaymentIntent associated with this charge, if one exists.
    sig { returns(T.nilable(T.any(String, ::Stripe::PaymentIntent))) }
    def payment_intent; end
    # ID of the payment method used in this charge.
    sig { returns(T.nilable(String)) }
    def payment_method; end
    # Details about the payment method at the time of the transaction.
    sig { returns(T.nilable(PaymentMethodDetails)) }
    def payment_method_details; end
    # Attribute for field presentment_details
    sig { returns(T.nilable(PresentmentDetails)) }
    def presentment_details; end
    # Options to configure Radar. See [Radar Session](https://docs.stripe.com/radar/radar-session) for more information.
    sig { returns(T.nilable(RadarOptions)) }
    def radar_options; end
    # This is the email address that the receipt for this charge was sent to.
    sig { returns(T.nilable(String)) }
    def receipt_email; end
    # This is the transaction number that appears on email receipts sent for this charge. This attribute will be `null` until a receipt has been sent.
    sig { returns(T.nilable(String)) }
    def receipt_number; end
    # This is the URL to view the receipt for this charge. The receipt is kept up-to-date to the latest state of the charge, including any refunds. If the charge is for an Invoice, the receipt will be stylized as an Invoice receipt.
    sig { returns(T.nilable(String)) }
    def receipt_url; end
    # Whether the charge has been fully refunded. If the charge is only partially refunded, this attribute will still be false.
    sig { returns(T::Boolean) }
    def refunded; end
    # A list of refunds that have been applied to the charge.
    sig { returns(T.nilable(::Stripe::ListObject)) }
    def refunds; end
    # ID of the review associated with this charge if one exists.
    sig { returns(T.nilable(T.any(String, ::Stripe::Review))) }
    def review; end
    # Shipping information for the charge.
    sig { returns(T.nilable(Shipping)) }
    def shipping; end
    # This is a legacy field that will be removed in the future. It contains the Source, Card, or BankAccount object used for the charge. For details about the payment method used for this charge, refer to `payment_method` or `payment_method_details` instead.
    sig {
      returns(T.nilable(T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source)))
     }
    def source; end
    # The transfer ID which created this charge. Only present if the charge came from another Stripe account. [See the Connect documentation](https://docs.stripe.com/connect/destination-charges) for details.
    sig { returns(T.nilable(T.any(String, ::Stripe::Transfer))) }
    def source_transfer; end
    # For a non-card charge, text that appears on the customer's statement as the statement descriptor. This value overrides the account's default statement descriptor. For information about requirements, including the 22-character limit, see [the Statement Descriptor docs](https://docs.stripe.com/get-started/account/statement-descriptors).
    #
    # For a card charge, this value is ignored unless you don't specify a `statement_descriptor_suffix`, in which case this value is used as the suffix.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    # Provides information about a card charge. Concatenated to the account's [statement descriptor prefix](https://docs.stripe.com/get-started/account/statement-descriptors#static) to form the complete statement descriptor that appears on the customer's statement. If the account has no prefix value, the suffix is concatenated to the account's statement descriptor.
    sig { returns(T.nilable(String)) }
    def statement_descriptor_suffix; end
    # The status of the payment is either `succeeded`, `pending`, or `failed`.
    sig { returns(String) }
    def status; end
    # ID of the transfer to the `destination` account (only applicable if the charge was created using the `destination` parameter).
    sig { returns(T.nilable(T.any(String, ::Stripe::Transfer))) }
    def transfer; end
    # An optional dictionary including the account to automatically transfer to as part of a destination charge. [See the Connect documentation](https://docs.stripe.com/connect/destination-charges) for details.
    sig { returns(T.nilable(TransferData)) }
    def transfer_data; end
    # A string that identifies this transaction as part of a group. See the [Connect documentation](https://docs.stripe.com/connect/separate-charges-and-transfers#transfer-options) for details.
    sig { returns(T.nilable(String)) }
    def transfer_group; end
    # Capture the payment of an existing, uncaptured charge that was created with the capture option set to false.
    #
    # Uncaptured payments expire a set number of days after they are created ([7 by default](https://docs.stripe.com/docs/charges/placing-a-hold)), after which they are marked as refunded and capture attempts will fail.
    #
    # Don't use this method to capture a PaymentIntent-initiated charge. Use [Capture a PaymentIntent](https://docs.stripe.com/docs/api/payment_intents/capture).
    sig {
      params(params: T.any(::Stripe::ChargeCaptureParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Charge)
     }
    def capture(params = {}, opts = {}); end

    # Capture the payment of an existing, uncaptured charge that was created with the capture option set to false.
    #
    # Uncaptured payments expire a set number of days after they are created ([7 by default](https://docs.stripe.com/docs/charges/placing-a-hold)), after which they are marked as refunded and capture attempts will fail.
    #
    # Don't use this method to capture a PaymentIntent-initiated charge. Use [Capture a PaymentIntent](https://docs.stripe.com/docs/api/payment_intents/capture).
    sig {
      params(charge: String, params: T.any(::Stripe::ChargeCaptureParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Charge)
     }
    def self.capture(charge, params = {}, opts = {}); end

    # This method is no longer recommended—use the [Payment Intents API](https://docs.stripe.com/docs/api/payment_intents)
    # to initiate a new payment instead. Confirmation of the PaymentIntent creates the Charge
    # object used to request payment.
    sig {
      params(params: T.any(::Stripe::ChargeCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Charge)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of charges you've previously created. The charges are returned in sorted order, with the most recent charges appearing first.
    sig {
      params(params: T.any(::Stripe::ChargeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::ChargeSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search(params = {}, opts = {}); end

    sig {
      params(params: T.any(::Stripe::ChargeSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped, blk: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def self.search_auto_paging_each(params = {}, opts = {}, &blk); end

    # Updates the specified charge by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    sig {
      params(charge: String, params: T.any(::Stripe::ChargeUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Charge)
     }
    def self.update(charge, params = {}, opts = {}); end
  end
end