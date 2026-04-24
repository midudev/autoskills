# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A SetupIntent guides you through the process of setting up and saving a customer's payment credentials for future payments.
  # For example, you can use a SetupIntent to set up and save your customer's card without immediately collecting a payment.
  # Later, you can use [PaymentIntents](https://api.stripe.com#payment_intents) to drive the payment flow.
  #
  # Create a SetupIntent when you're ready to collect your customer's payment credentials.
  # Don't maintain long-lived, unconfirmed SetupIntents because they might not be valid.
  # The SetupIntent transitions through multiple [statuses](https://docs.stripe.com/payments/intents#intent-statuses) as it guides
  # you through the setup process.
  #
  # Successful SetupIntents result in payment credentials that are optimized for future payments.
  # For example, cardholders in [certain regions](https://stripe.com/guides/strong-customer-authentication) might need to be run through
  # [Strong Customer Authentication](https://docs.stripe.com/strong-customer-authentication) during payment method collection
  # to streamline later [off-session payments](https://docs.stripe.com/payments/setup-intents).
  # If you use the SetupIntent with a [Customer](https://api.stripe.com#setup_intent_object-customer),
  # it automatically attaches the resulting payment method to that Customer after successful setup.
  # We recommend using SetupIntents or [setup_future_usage](https://api.stripe.com#payment_intent_object-setup_future_usage) on
  # PaymentIntents to save payment methods to prevent saving invalid or unoptimized payment methods.
  #
  # By using SetupIntents, you can reduce friction for your customers, even as regulations change over time.
  #
  # Related guide: [Setup Intents API](https://docs.stripe.com/payments/setup-intents)
  class SetupIntent < APIResource
    class AutomaticPaymentMethods < ::Stripe::StripeObject
      # Controls whether this SetupIntent will accept redirect-based payment methods.
      #
      # Redirect-based payment methods may require your customer to be redirected to a payment method's app or site for authentication or additional steps. To [confirm](https://docs.stripe.com/api/setup_intents/confirm) this SetupIntent, you may be required to provide a `return_url` to redirect customers back to your site after they authenticate or complete the setup.
      sig { returns(T.nilable(String)) }
      def allow_redirects; end
      # Automatically calculates compatible payment methods
      sig { returns(T.nilable(T::Boolean)) }
      def enabled; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class LastSetupError < ::Stripe::StripeObject
      # For card errors resulting from a card issuer decline, a short string indicating [how to proceed with an error](https://docs.stripe.com/declines#retrying-issuer-declines) if they provide one.
      sig { returns(T.nilable(String)) }
      def advice_code; end
      # For card errors, the ID of the failed charge.
      sig { returns(T.nilable(String)) }
      def charge; end
      # For some errors that could be handled programmatically, a short string indicating the [error code](https://docs.stripe.com/error-codes) reported.
      sig { returns(T.nilable(String)) }
      def code; end
      # For card errors resulting from a card issuer decline, a short string indicating the [card issuer's reason for the decline](https://docs.stripe.com/declines#issuer-declines) if they provide one.
      sig { returns(T.nilable(String)) }
      def decline_code; end
      # A URL to more information about the [error code](https://docs.stripe.com/error-codes) reported.
      sig { returns(T.nilable(String)) }
      def doc_url; end
      # A human-readable message providing more details about the error. For card errors, these messages can be shown to your users.
      sig { returns(T.nilable(String)) }
      def message; end
      # For card errors resulting from a card issuer decline, a 2 digit code which indicates the advice given to merchant by the card network on how to proceed with an error.
      sig { returns(T.nilable(String)) }
      def network_advice_code; end
      # For payments declined by the network, an alphanumeric code which indicates the reason the payment failed.
      sig { returns(T.nilable(String)) }
      def network_decline_code; end
      # If the error is parameter-specific, the parameter related to the error. For example, you can use this to display a message near the correct form field.
      sig { returns(T.nilable(String)) }
      def param; end
      # A PaymentIntent guides you through the process of collecting a payment from your customer.
      # We recommend that you create exactly one PaymentIntent for each order or
      # customer session in your system. You can reference the PaymentIntent later to
      # see the history of payment attempts for a particular session.
      #
      # A PaymentIntent transitions through
      # [multiple statuses](/payments/paymentintents/lifecycle)
      # throughout its lifetime as it interfaces with Stripe.js to perform
      # authentication flows and ultimately creates at most one successful charge.
      #
      # Related guide: [Payment Intents API](https://docs.stripe.com/payments/payment-intents)
      sig { returns(T.nilable(::Stripe::PaymentIntent)) }
      def payment_intent; end
      # PaymentMethod objects represent your customer's payment instruments.
      # You can use them with [PaymentIntents](https://docs.stripe.com/payments/payment-intents) to collect payments or save them to
      # Customer objects to store instrument details for future payments.
      #
      # Related guides: [Payment Methods](https://docs.stripe.com/payments/payment-methods) and [More Payment Scenarios](https://docs.stripe.com/payments/more-payment-scenarios).
      sig { returns(T.nilable(::Stripe::PaymentMethod)) }
      def payment_method; end
      # If the error is specific to the type of payment method, the payment method type that had a problem. This field is only populated for invoice-related errors.
      sig { returns(T.nilable(String)) }
      def payment_method_type; end
      # A URL to the request log entry in your dashboard.
      sig { returns(T.nilable(String)) }
      def request_log_url; end
      # A SetupIntent guides you through the process of setting up and saving a customer's payment credentials for future payments.
      # For example, you can use a SetupIntent to set up and save your customer's card without immediately collecting a payment.
      # Later, you can use [PaymentIntents](https://api.stripe.com#payment_intents) to drive the payment flow.
      #
      # Create a SetupIntent when you're ready to collect your customer's payment credentials.
      # Don't maintain long-lived, unconfirmed SetupIntents because they might not be valid.
      # The SetupIntent transitions through multiple [statuses](https://docs.stripe.com/payments/intents#intent-statuses) as it guides
      # you through the setup process.
      #
      # Successful SetupIntents result in payment credentials that are optimized for future payments.
      # For example, cardholders in [certain regions](https://stripe.com/guides/strong-customer-authentication) might need to be run through
      # [Strong Customer Authentication](https://docs.stripe.com/strong-customer-authentication) during payment method collection
      # to streamline later [off-session payments](https://docs.stripe.com/payments/setup-intents).
      # If you use the SetupIntent with a [Customer](https://api.stripe.com#setup_intent_object-customer),
      # it automatically attaches the resulting payment method to that Customer after successful setup.
      # We recommend using SetupIntents or [setup_future_usage](https://api.stripe.com#payment_intent_object-setup_future_usage) on
      # PaymentIntents to save payment methods to prevent saving invalid or unoptimized payment methods.
      #
      # By using SetupIntents, you can reduce friction for your customers, even as regulations change over time.
      #
      # Related guide: [Setup Intents API](https://docs.stripe.com/payments/setup-intents)
      sig { returns(T.nilable(::Stripe::SetupIntent)) }
      def setup_intent; end
      # Attribute for field source
      sig {
        returns(T.nilable(T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source)))
       }
      def source; end
      # The type of error returned. One of `api_error`, `card_error`, `idempotency_error`, or `invalid_request_error`
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class NextAction < ::Stripe::StripeObject
      class CashappHandleRedirectOrDisplayQrCode < ::Stripe::StripeObject
        class QrCode < ::Stripe::StripeObject
          # The date (unix timestamp) when the QR code expires.
          sig { returns(Integer) }
          def expires_at; end
          # The image_url_png string used to render QR code
          sig { returns(String) }
          def image_url_png; end
          # The image_url_svg string used to render QR code
          sig { returns(String) }
          def image_url_svg; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The URL to the hosted Cash App Pay instructions page, which allows customers to view the QR code, and supports QR code refreshing on expiration.
        sig { returns(String) }
        def hosted_instructions_url; end
        # The url for mobile redirect based auth
        sig { returns(String) }
        def mobile_auth_url; end
        # Attribute for field qr_code
        sig { returns(QrCode) }
        def qr_code; end
        def self.inner_class_types
          @inner_class_types = {qr_code: QrCode}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RedirectToUrl < ::Stripe::StripeObject
        # If the customer does not exit their browser while authenticating, they will be redirected to this specified URL after completion.
        sig { returns(T.nilable(String)) }
        def return_url; end
        # The URL you must redirect your customer to in order to authenticate.
        sig { returns(T.nilable(String)) }
        def url; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class VerifyWithMicrodeposits < ::Stripe::StripeObject
        # The timestamp when the microdeposits are expected to land.
        sig { returns(Integer) }
        def arrival_date; end
        # The URL for the hosted verification page, which allows customers to verify their bank account.
        sig { returns(String) }
        def hosted_verification_url; end
        # The type of the microdeposit sent to the customer. Used to distinguish between different verification methods.
        sig { returns(T.nilable(String)) }
        def microdeposit_type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field cashapp_handle_redirect_or_display_qr_code
      sig { returns(T.nilable(CashappHandleRedirectOrDisplayQrCode)) }
      def cashapp_handle_redirect_or_display_qr_code; end
      # Attribute for field redirect_to_url
      sig { returns(T.nilable(RedirectToUrl)) }
      def redirect_to_url; end
      # Type of the next action to perform. Refer to the other child attributes under `next_action` for available values. Examples include: `redirect_to_url`, `use_stripe_sdk`, `alipay_handle_redirect`, `oxxo_display_details`, or `verify_with_microdeposits`.
      sig { returns(String) }
      def type; end
      # When confirming a SetupIntent with Stripe.js, Stripe.js depends on the contents of this dictionary to invoke authentication flows. The shape of the contents is subject to change and is only intended to be used by Stripe.js.
      sig { returns(T.nilable(T::Hash[String, T.untyped])) }
      def use_stripe_sdk; end
      # Attribute for field verify_with_microdeposits
      sig { returns(T.nilable(VerifyWithMicrodeposits)) }
      def verify_with_microdeposits; end
      def self.inner_class_types
        @inner_class_types = {
          cashapp_handle_redirect_or_display_qr_code: CashappHandleRedirectOrDisplayQrCode,
          redirect_to_url: RedirectToUrl,
          verify_with_microdeposits: VerifyWithMicrodeposits,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaymentMethodConfigurationDetails < ::Stripe::StripeObject
      # ID of the payment method configuration used.
      sig { returns(String) }
      def id; end
      # ID of the parent payment method configuration used.
      sig { returns(T.nilable(String)) }
      def parent; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaymentMethodOptions < ::Stripe::StripeObject
      class AcssDebit < ::Stripe::StripeObject
        class MandateOptions < ::Stripe::StripeObject
          # A URL for custom mandate text
          sig { returns(T.nilable(String)) }
          def custom_mandate_url; end
          # List of Stripe products where this mandate can be selected automatically.
          sig { returns(T.nilable(T::Array[String])) }
          def default_for; end
          # Description of the interval. Only required if the 'payment_schedule' parameter is 'interval' or 'combined'.
          sig { returns(T.nilable(String)) }
          def interval_description; end
          # Payment schedule for the mandate.
          sig { returns(T.nilable(String)) }
          def payment_schedule; end
          # Transaction type of the mandate.
          sig { returns(T.nilable(String)) }
          def transaction_type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Currency supported by the bank account
        sig { returns(T.nilable(String)) }
        def currency; end
        # Attribute for field mandate_options
        sig { returns(T.nilable(MandateOptions)) }
        def mandate_options; end
        # Bank account verification method.
        sig { returns(T.nilable(String)) }
        def verification_method; end
        def self.inner_class_types
          @inner_class_types = {mandate_options: MandateOptions}
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
      class BacsDebit < ::Stripe::StripeObject
        class MandateOptions < ::Stripe::StripeObject
          # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'DDIC' or 'STRIPE'.
          sig { returns(T.nilable(String)) }
          def reference_prefix; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field mandate_options
        sig { returns(T.nilable(MandateOptions)) }
        def mandate_options; end
        def self.inner_class_types
          @inner_class_types = {mandate_options: MandateOptions}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Card < ::Stripe::StripeObject
        class MandateOptions < ::Stripe::StripeObject
          # Amount to be charged for future payments.
          sig { returns(Integer) }
          def amount; end
          # One of `fixed` or `maximum`. If `fixed`, the `amount` param refers to the exact amount to be charged in future payments. If `maximum`, the amount charged can be up to the value passed for the `amount` param.
          sig { returns(String) }
          def amount_type; end
          # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
          sig { returns(String) }
          def currency; end
          # A description of the mandate or subscription that is meant to be displayed to the customer.
          sig { returns(T.nilable(String)) }
          def description; end
          # End date of the mandate or subscription. If not provided, the mandate will be active until canceled. If provided, end date should be after start date.
          sig { returns(T.nilable(Integer)) }
          def end_date; end
          # Specifies payment frequency. One of `day`, `week`, `month`, `year`, or `sporadic`.
          sig { returns(String) }
          def interval; end
          # The number of intervals between payments. For example, `interval=month` and `interval_count=3` indicates one payment every three months. Maximum of one year interval allowed (1 year, 12 months, or 52 weeks). This parameter is optional when `interval=sporadic`.
          sig { returns(T.nilable(Integer)) }
          def interval_count; end
          # Unique identifier for the mandate or subscription.
          sig { returns(String) }
          def reference; end
          # Start date of the mandate or subscription. Start date should not be lesser than yesterday.
          sig { returns(Integer) }
          def start_date; end
          # Specifies the type of mandates supported. Possible values are `india`.
          sig { returns(T.nilable(T::Array[String])) }
          def supported_types; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Configuration options for setting up an eMandate for cards issued in India.
        sig { returns(T.nilable(MandateOptions)) }
        def mandate_options; end
        # Selected network to process this SetupIntent on. Depends on the available networks of the card attached to the setup intent. Can be only set confirm-time.
        sig { returns(T.nilable(String)) }
        def network; end
        # We strongly recommend that you rely on our SCA Engine to automatically prompt your customers for authentication based on risk level and [other requirements](https://docs.stripe.com/strong-customer-authentication). However, if you wish to request 3D Secure based on logic from your own fraud engine, provide this option. If not provided, this value defaults to `automatic`. Read our guide on [manually requesting 3D Secure](https://docs.stripe.com/payments/3d-secure/authentication-flow#manual-three-ds) for more information on how this configuration interacts with Radar and our SCA Engine.
        sig { returns(T.nilable(String)) }
        def request_three_d_secure; end
        def self.inner_class_types
          @inner_class_types = {mandate_options: MandateOptions}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class CardPresent < ::Stripe::StripeObject
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Klarna < ::Stripe::StripeObject
        # The currency of the setup intent. Three letter ISO currency code.
        sig { returns(T.nilable(String)) }
        def currency; end
        # Preferred locale of the Klarna checkout page that the customer is redirected to.
        sig { returns(T.nilable(String)) }
        def preferred_locale; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Link < ::Stripe::StripeObject
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
      class Paypal < ::Stripe::StripeObject
        # The PayPal Billing Agreement ID (BAID). This is an ID generated by PayPal which represents the mandate between the merchant and the customer.
        sig { returns(T.nilable(String)) }
        def billing_agreement_id; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Payto < ::Stripe::StripeObject
        class MandateOptions < ::Stripe::StripeObject
          # Amount that will be collected. It is required when `amount_type` is `fixed`.
          sig { returns(T.nilable(Integer)) }
          def amount; end
          # The type of amount that will be collected. The amount charged must be exact or up to the value of `amount` param for `fixed` or `maximum` type respectively. Defaults to `maximum`.
          sig { returns(T.nilable(String)) }
          def amount_type; end
          # Date, in YYYY-MM-DD format, after which payments will not be collected. Defaults to no end date.
          sig { returns(T.nilable(String)) }
          def end_date; end
          # The periodicity at which payments will be collected. Defaults to `adhoc`.
          sig { returns(T.nilable(String)) }
          def payment_schedule; end
          # The number of payments that will be made during a payment period. Defaults to 1 except for when `payment_schedule` is `adhoc`. In that case, it defaults to no limit.
          sig { returns(T.nilable(Integer)) }
          def payments_per_period; end
          # The purpose for which payments are made. Has a default value based on your merchant category code.
          sig { returns(T.nilable(String)) }
          def purpose; end
          # Date, in YYYY-MM-DD format, from which payments will be collected. Defaults to confirmation time.
          sig { returns(T.nilable(String)) }
          def start_date; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field mandate_options
        sig { returns(T.nilable(MandateOptions)) }
        def mandate_options; end
        def self.inner_class_types
          @inner_class_types = {mandate_options: MandateOptions}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SepaDebit < ::Stripe::StripeObject
        class MandateOptions < ::Stripe::StripeObject
          # Prefix used to generate the Mandate reference. Must be at most 12 characters long. Must consist of only uppercase letters, numbers, spaces, or the following special characters: '/', '_', '-', '&', '.'. Cannot begin with 'STRIPE'.
          sig { returns(T.nilable(String)) }
          def reference_prefix; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field mandate_options
        sig { returns(T.nilable(MandateOptions)) }
        def mandate_options; end
        def self.inner_class_types
          @inner_class_types = {mandate_options: MandateOptions}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class UsBankAccount < ::Stripe::StripeObject
        class FinancialConnections < ::Stripe::StripeObject
          class Filters < ::Stripe::StripeObject
            # The account subcategories to use to filter for possible accounts to link. Valid subcategories are `checking` and `savings`.
            sig { returns(T.nilable(T::Array[String])) }
            def account_subcategories; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field filters
          sig { returns(T.nilable(Filters)) }
          def filters; end
          # The list of permissions to request. The `payment_method` permission must be included.
          sig { returns(T.nilable(T::Array[String])) }
          def permissions; end
          # Data features requested to be retrieved upon account creation.
          sig { returns(T.nilable(T::Array[String])) }
          def prefetch; end
          # For webview integrations only. Upon completing OAuth login in the native browser, the user will be redirected to this URL to return to your app.
          sig { returns(T.nilable(String)) }
          def return_url; end
          def self.inner_class_types
            @inner_class_types = {filters: Filters}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class MandateOptions < ::Stripe::StripeObject
          # Mandate collection method
          sig { returns(T.nilable(String)) }
          def collection_method; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field financial_connections
        sig { returns(T.nilable(FinancialConnections)) }
        def financial_connections; end
        # Attribute for field mandate_options
        sig { returns(T.nilable(MandateOptions)) }
        def mandate_options; end
        # Bank account verification method.
        sig { returns(T.nilable(String)) }
        def verification_method; end
        def self.inner_class_types
          @inner_class_types = {
            financial_connections: FinancialConnections,
            mandate_options: MandateOptions,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field acss_debit
      sig { returns(T.nilable(AcssDebit)) }
      def acss_debit; end
      # Attribute for field amazon_pay
      sig { returns(T.nilable(AmazonPay)) }
      def amazon_pay; end
      # Attribute for field bacs_debit
      sig { returns(T.nilable(BacsDebit)) }
      def bacs_debit; end
      # Attribute for field card
      sig { returns(T.nilable(Card)) }
      def card; end
      # Attribute for field card_present
      sig { returns(T.nilable(CardPresent)) }
      def card_present; end
      # Attribute for field klarna
      sig { returns(T.nilable(Klarna)) }
      def klarna; end
      # Attribute for field link
      sig { returns(T.nilable(Link)) }
      def link; end
      # Attribute for field paypal
      sig { returns(T.nilable(Paypal)) }
      def paypal; end
      # Attribute for field payto
      sig { returns(T.nilable(Payto)) }
      def payto; end
      # Attribute for field sepa_debit
      sig { returns(T.nilable(SepaDebit)) }
      def sepa_debit; end
      # Attribute for field us_bank_account
      sig { returns(T.nilable(UsBankAccount)) }
      def us_bank_account; end
      def self.inner_class_types
        @inner_class_types = {
          acss_debit: AcssDebit,
          amazon_pay: AmazonPay,
          bacs_debit: BacsDebit,
          card: Card,
          card_present: CardPresent,
          klarna: Klarna,
          link: Link,
          paypal: Paypal,
          payto: Payto,
          sepa_debit: SepaDebit,
          us_bank_account: UsBankAccount,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # ID of the Connect application that created the SetupIntent.
    sig { returns(T.nilable(T.any(String, ::Stripe::Application))) }
    def application; end
    # If present, the SetupIntent's payment method will be attached to the in-context Stripe Account.
    #
    # It can only be used for this Stripe Account’s own money movement flows like InboundTransfer and OutboundTransfers. It cannot be set to true when setting up a PaymentMethod for a Customer, and defaults to false when attaching a PaymentMethod to a Customer.
    sig { returns(T.nilable(T::Boolean)) }
    def attach_to_self; end
    # Settings for dynamic payment methods compatible with this Setup Intent
    sig { returns(T.nilable(AutomaticPaymentMethods)) }
    def automatic_payment_methods; end
    # Reason for cancellation of this SetupIntent, one of `abandoned`, `requested_by_customer`, or `duplicate`.
    sig { returns(T.nilable(String)) }
    def cancellation_reason; end
    # The client secret of this SetupIntent. Used for client-side retrieval using a publishable key.
    #
    # The client secret can be used to complete payment setup from your frontend. It should not be stored, logged, or exposed to anyone other than the customer. Make sure that you have TLS enabled on any page that includes the client secret.
    sig { returns(T.nilable(String)) }
    def client_secret; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # ID of the Customer this SetupIntent belongs to, if one exists.
    #
    # If present, the SetupIntent's payment method will be attached to the Customer on successful setup. Payment methods attached to other Customers cannot be used with this SetupIntent.
    sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
    def customer; end
    # ID of the Account this SetupIntent belongs to, if one exists.
    #
    # If present, the SetupIntent's payment method will be attached to the Account on successful setup. Payment methods attached to other Accounts cannot be used with this SetupIntent.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # Payment method types that are excluded from this SetupIntent.
    sig { returns(T.nilable(T::Array[String])) }
    def excluded_payment_method_types; end
    # Indicates the directions of money movement for which this payment method is intended to be used.
    #
    # Include `inbound` if you intend to use the payment method as the origin to pull funds from. Include `outbound` if you intend to use the payment method as the destination to send funds to. You can include both if you intend to use the payment method for both purposes.
    sig { returns(T.nilable(T::Array[String])) }
    def flow_directions; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The error encountered in the previous SetupIntent confirmation.
    sig { returns(T.nilable(LastSetupError)) }
    def last_setup_error; end
    # The most recent SetupAttempt for this SetupIntent.
    sig { returns(T.nilable(T.any(String, ::Stripe::SetupAttempt))) }
    def latest_attempt; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # ID of the multi use Mandate generated by the SetupIntent.
    sig { returns(T.nilable(T.any(String, ::Stripe::Mandate))) }
    def mandate; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # If present, this property tells you what actions you need to take in order for your customer to continue payment setup.
    sig { returns(T.nilable(NextAction)) }
    def next_action; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The account (if any) for which the setup is intended.
    sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
    def on_behalf_of; end
    # ID of the payment method used with this SetupIntent. If the payment method is `card_present` and isn't a digital wallet, then the [generated_card](https://docs.stripe.com/api/setup_attempts/object#setup_attempt_object-payment_method_details-card_present-generated_card) associated with the `latest_attempt` is attached to the Customer instead.
    sig { returns(T.nilable(T.any(String, ::Stripe::PaymentMethod))) }
    def payment_method; end
    # Information about the [payment method configuration](https://docs.stripe.com/api/payment_method_configurations) used for this Setup Intent.
    sig { returns(T.nilable(PaymentMethodConfigurationDetails)) }
    def payment_method_configuration_details; end
    # Payment method-specific configuration for this SetupIntent.
    sig { returns(T.nilable(PaymentMethodOptions)) }
    def payment_method_options; end
    # The list of payment method types (e.g. card) that this SetupIntent is allowed to set up. A list of valid payment method types can be found [here](https://docs.stripe.com/api/payment_methods/object#payment_method_object-type).
    sig { returns(T::Array[String]) }
    def payment_method_types; end
    # ID of the single_use Mandate generated by the SetupIntent.
    sig { returns(T.nilable(T.any(String, ::Stripe::Mandate))) }
    def single_use_mandate; end
    # [Status](https://docs.stripe.com/payments/intents#intent-statuses) of this SetupIntent, one of `requires_payment_method`, `requires_confirmation`, `requires_action`, `processing`, `canceled`, or `succeeded`.
    sig { returns(String) }
    def status; end
    # Indicates how the payment method is intended to be used in the future.
    #
    # Use `on_session` if you intend to only reuse the payment method when the customer is in your checkout flow. Use `off_session` if your customer may or may not be in your checkout flow. If not provided, this value defaults to `off_session`.
    sig { returns(String) }
    def usage; end
    # You can cancel a SetupIntent object when it's in one of these statuses: requires_payment_method, requires_confirmation, or requires_action.
    #
    # After you cancel it, setup is abandoned and any operations on the SetupIntent fail with an error. You can't cancel the SetupIntent for a Checkout Session. [Expire the Checkout Session](https://docs.stripe.com/docs/api/checkout/sessions/expire) instead.
    sig {
      params(params: T.any(::Stripe::SetupIntentCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def cancel(params = {}, opts = {}); end

    # You can cancel a SetupIntent object when it's in one of these statuses: requires_payment_method, requires_confirmation, or requires_action.
    #
    # After you cancel it, setup is abandoned and any operations on the SetupIntent fail with an error. You can't cancel the SetupIntent for a Checkout Session. [Expire the Checkout Session](https://docs.stripe.com/docs/api/checkout/sessions/expire) instead.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def self.cancel(intent, params = {}, opts = {}); end

    # Confirm that your customer intends to set up the current or
    # provided payment method. For example, you would confirm a SetupIntent
    # when a customer hits the “Save” button on a payment method management
    # page on your website.
    #
    # If the selected payment method does not require any additional
    # steps from the customer, the SetupIntent will transition to the
    # succeeded status.
    #
    # Otherwise, it will transition to the requires_action status and
    # suggest additional actions via next_action. If setup fails,
    # the SetupIntent will transition to the
    # requires_payment_method status or the canceled status if the
    # confirmation limit is reached.
    sig {
      params(params: T.any(::Stripe::SetupIntentConfirmParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def confirm(params = {}, opts = {}); end

    # Confirm that your customer intends to set up the current or
    # provided payment method. For example, you would confirm a SetupIntent
    # when a customer hits the “Save” button on a payment method management
    # page on your website.
    #
    # If the selected payment method does not require any additional
    # steps from the customer, the SetupIntent will transition to the
    # succeeded status.
    #
    # Otherwise, it will transition to the requires_action status and
    # suggest additional actions via next_action. If setup fails,
    # the SetupIntent will transition to the
    # requires_payment_method status or the canceled status if the
    # confirmation limit is reached.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentConfirmParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def self.confirm(intent, params = {}, opts = {}); end

    # Creates a SetupIntent object.
    #
    # After you create the SetupIntent, attach a payment method and [confirm](https://docs.stripe.com/docs/api/setup_intents/confirm)
    # it to collect any required permissions to charge the payment method later.
    sig {
      params(params: T.any(::Stripe::SetupIntentCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of SetupIntents.
    sig {
      params(params: T.any(::Stripe::SetupIntentListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates a SetupIntent object.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def self.update(intent, params = {}, opts = {}); end

    # Verifies microdeposits on a SetupIntent object.
    sig {
      params(params: T.any(::Stripe::SetupIntentVerifyMicrodepositsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def verify_microdeposits(params = {}, opts = {}); end

    # Verifies microdeposits on a SetupIntent object.
    sig {
      params(intent: String, params: T.any(::Stripe::SetupIntentVerifyMicrodepositsParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SetupIntent)
     }
    def self.verify_microdeposits(intent, params = {}, opts = {}); end
  end
end