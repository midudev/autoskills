# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # `Source` objects allow you to accept a variety of payment methods. They
  # represent a customer's payment instrument, and can be used with the Stripe API
  # just like a `Card` object: once chargeable, they can be charged, or can be
  # attached to customers.
  #
  # Stripe doesn't recommend using the deprecated [Sources API](https://docs.stripe.com/api/sources).
  # We recommend that you adopt the [PaymentMethods API](https://docs.stripe.com/api/payment_methods).
  # This newer API provides access to our latest features and payment method types.
  #
  # Related guides: [Sources API](https://docs.stripe.com/sources) and [Sources & Customers](https://docs.stripe.com/sources/customers).
  class Source < APIResource
    class AchCreditTransfer < ::Stripe::StripeObject
      # Attribute for field account_number
      sig { returns(T.nilable(String)) }
      def account_number; end
      # Attribute for field bank_name
      sig { returns(T.nilable(String)) }
      def bank_name; end
      # Attribute for field fingerprint
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Attribute for field refund_account_holder_name
      sig { returns(T.nilable(String)) }
      def refund_account_holder_name; end
      # Attribute for field refund_account_holder_type
      sig { returns(T.nilable(String)) }
      def refund_account_holder_type; end
      # Attribute for field refund_routing_number
      sig { returns(T.nilable(String)) }
      def refund_routing_number; end
      # Attribute for field routing_number
      sig { returns(T.nilable(String)) }
      def routing_number; end
      # Attribute for field swift_code
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
      # Attribute for field bank_name
      sig { returns(T.nilable(String)) }
      def bank_name; end
      # Attribute for field country
      sig { returns(T.nilable(String)) }
      def country; end
      # Attribute for field fingerprint
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Attribute for field last4
      sig { returns(T.nilable(String)) }
      def last4; end
      # Attribute for field routing_number
      sig { returns(T.nilable(String)) }
      def routing_number; end
      # Attribute for field type
      sig { returns(T.nilable(String)) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AcssDebit < ::Stripe::StripeObject
      # Attribute for field bank_address_city
      sig { returns(T.nilable(String)) }
      def bank_address_city; end
      # Attribute for field bank_address_line_1
      sig { returns(T.nilable(String)) }
      def bank_address_line_1; end
      # Attribute for field bank_address_line_2
      sig { returns(T.nilable(String)) }
      def bank_address_line_2; end
      # Attribute for field bank_address_postal_code
      sig { returns(T.nilable(String)) }
      def bank_address_postal_code; end
      # Attribute for field bank_name
      sig { returns(T.nilable(String)) }
      def bank_name; end
      # Attribute for field category
      sig { returns(T.nilable(String)) }
      def category; end
      # Attribute for field country
      sig { returns(T.nilable(String)) }
      def country; end
      # Attribute for field fingerprint
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Attribute for field last4
      sig { returns(T.nilable(String)) }
      def last4; end
      # Attribute for field routing_number
      sig { returns(T.nilable(String)) }
      def routing_number; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Alipay < ::Stripe::StripeObject
      # Attribute for field data_string
      sig { returns(T.nilable(String)) }
      def data_string; end
      # Attribute for field native_url
      sig { returns(T.nilable(String)) }
      def native_url; end
      # Attribute for field statement_descriptor
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AuBecsDebit < ::Stripe::StripeObject
      # Attribute for field bsb_number
      sig { returns(T.nilable(String)) }
      def bsb_number; end
      # Attribute for field fingerprint
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Attribute for field last4
      sig { returns(T.nilable(String)) }
      def last4; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Bancontact < ::Stripe::StripeObject
      # Attribute for field bank_code
      sig { returns(T.nilable(String)) }
      def bank_code; end
      # Attribute for field bank_name
      sig { returns(T.nilable(String)) }
      def bank_name; end
      # Attribute for field bic
      sig { returns(T.nilable(String)) }
      def bic; end
      # Attribute for field iban_last4
      sig { returns(T.nilable(String)) }
      def iban_last4; end
      # Attribute for field preferred_language
      sig { returns(T.nilable(String)) }
      def preferred_language; end
      # Attribute for field statement_descriptor
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Card < ::Stripe::StripeObject
      # Attribute for field address_line1_check
      sig { returns(T.nilable(String)) }
      def address_line1_check; end
      # Attribute for field address_zip_check
      sig { returns(T.nilable(String)) }
      def address_zip_check; end
      # Attribute for field brand
      sig { returns(T.nilable(String)) }
      def brand; end
      # Attribute for field country
      sig { returns(T.nilable(String)) }
      def country; end
      # Attribute for field cvc_check
      sig { returns(T.nilable(String)) }
      def cvc_check; end
      # Attribute for field description
      sig { returns(T.nilable(String)) }
      def description; end
      # Attribute for field dynamic_last4
      sig { returns(T.nilable(String)) }
      def dynamic_last4; end
      # Attribute for field exp_month
      sig { returns(T.nilable(Integer)) }
      def exp_month; end
      # Attribute for field exp_year
      sig { returns(T.nilable(Integer)) }
      def exp_year; end
      # Attribute for field fingerprint
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Attribute for field funding
      sig { returns(T.nilable(String)) }
      def funding; end
      # Attribute for field iin
      sig { returns(T.nilable(String)) }
      def iin; end
      # Attribute for field issuer
      sig { returns(T.nilable(String)) }
      def issuer; end
      # Attribute for field last4
      sig { returns(T.nilable(String)) }
      def last4; end
      # Attribute for field name
      sig { returns(T.nilable(String)) }
      def name; end
      # Attribute for field three_d_secure
      sig { returns(T.nilable(String)) }
      def three_d_secure; end
      # Attribute for field tokenization_method
      sig { returns(T.nilable(String)) }
      def tokenization_method; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CardPresent < ::Stripe::StripeObject
      # Attribute for field application_cryptogram
      sig { returns(T.nilable(String)) }
      def application_cryptogram; end
      # Attribute for field application_preferred_name
      sig { returns(T.nilable(String)) }
      def application_preferred_name; end
      # Attribute for field authorization_code
      sig { returns(T.nilable(String)) }
      def authorization_code; end
      # Attribute for field authorization_response_code
      sig { returns(T.nilable(String)) }
      def authorization_response_code; end
      # Attribute for field brand
      sig { returns(T.nilable(String)) }
      def brand; end
      # Attribute for field country
      sig { returns(T.nilable(String)) }
      def country; end
      # Attribute for field cvm_type
      sig { returns(T.nilable(String)) }
      def cvm_type; end
      # Attribute for field data_type
      sig { returns(T.nilable(String)) }
      def data_type; end
      # Attribute for field dedicated_file_name
      sig { returns(T.nilable(String)) }
      def dedicated_file_name; end
      # Attribute for field description
      sig { returns(T.nilable(String)) }
      def description; end
      # Attribute for field emv_auth_data
      sig { returns(T.nilable(String)) }
      def emv_auth_data; end
      # Attribute for field evidence_customer_signature
      sig { returns(T.nilable(String)) }
      def evidence_customer_signature; end
      # Attribute for field evidence_transaction_certificate
      sig { returns(T.nilable(String)) }
      def evidence_transaction_certificate; end
      # Attribute for field exp_month
      sig { returns(T.nilable(Integer)) }
      def exp_month; end
      # Attribute for field exp_year
      sig { returns(T.nilable(Integer)) }
      def exp_year; end
      # Attribute for field fingerprint
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Attribute for field funding
      sig { returns(T.nilable(String)) }
      def funding; end
      # Attribute for field iin
      sig { returns(T.nilable(String)) }
      def iin; end
      # Attribute for field issuer
      sig { returns(T.nilable(String)) }
      def issuer; end
      # Attribute for field last4
      sig { returns(T.nilable(String)) }
      def last4; end
      # Attribute for field pos_device_id
      sig { returns(T.nilable(String)) }
      def pos_device_id; end
      # Attribute for field pos_entry_mode
      sig { returns(T.nilable(String)) }
      def pos_entry_mode; end
      # Attribute for field read_method
      sig { returns(T.nilable(String)) }
      def read_method; end
      # Attribute for field reader
      sig { returns(T.nilable(String)) }
      def reader; end
      # Attribute for field terminal_verification_results
      sig { returns(T.nilable(String)) }
      def terminal_verification_results; end
      # Attribute for field transaction_status_information
      sig { returns(T.nilable(String)) }
      def transaction_status_information; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class CodeVerification < ::Stripe::StripeObject
      # The number of attempts remaining to authenticate the source object with a verification code.
      sig { returns(Integer) }
      def attempts_remaining; end
      # The status of the code verification, either `pending` (awaiting verification, `attempts_remaining` should be greater than 0), `succeeded` (successful verification) or `failed` (failed verification, cannot be verified anymore as `attempts_remaining` should be 0).
      sig { returns(String) }
      def status; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Eps < ::Stripe::StripeObject
      # Attribute for field reference
      sig { returns(T.nilable(String)) }
      def reference; end
      # Attribute for field statement_descriptor
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Giropay < ::Stripe::StripeObject
      # Attribute for field bank_code
      sig { returns(T.nilable(String)) }
      def bank_code; end
      # Attribute for field bank_name
      sig { returns(T.nilable(String)) }
      def bank_name; end
      # Attribute for field bic
      sig { returns(T.nilable(String)) }
      def bic; end
      # Attribute for field statement_descriptor
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Ideal < ::Stripe::StripeObject
      # Attribute for field bank
      sig { returns(T.nilable(String)) }
      def bank; end
      # Attribute for field bic
      sig { returns(T.nilable(String)) }
      def bic; end
      # Attribute for field iban_last4
      sig { returns(T.nilable(String)) }
      def iban_last4; end
      # Attribute for field statement_descriptor
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Klarna < ::Stripe::StripeObject
      # Attribute for field background_image_url
      sig { returns(T.nilable(String)) }
      def background_image_url; end
      # Attribute for field client_token
      sig { returns(T.nilable(String)) }
      def client_token; end
      # Attribute for field first_name
      sig { returns(T.nilable(String)) }
      def first_name; end
      # Attribute for field last_name
      sig { returns(T.nilable(String)) }
      def last_name; end
      # Attribute for field locale
      sig { returns(T.nilable(String)) }
      def locale; end
      # Attribute for field logo_url
      sig { returns(T.nilable(String)) }
      def logo_url; end
      # Attribute for field page_title
      sig { returns(T.nilable(String)) }
      def page_title; end
      # Attribute for field pay_later_asset_urls_descriptive
      sig { returns(T.nilable(String)) }
      def pay_later_asset_urls_descriptive; end
      # Attribute for field pay_later_asset_urls_standard
      sig { returns(T.nilable(String)) }
      def pay_later_asset_urls_standard; end
      # Attribute for field pay_later_name
      sig { returns(T.nilable(String)) }
      def pay_later_name; end
      # Attribute for field pay_later_redirect_url
      sig { returns(T.nilable(String)) }
      def pay_later_redirect_url; end
      # Attribute for field pay_now_asset_urls_descriptive
      sig { returns(T.nilable(String)) }
      def pay_now_asset_urls_descriptive; end
      # Attribute for field pay_now_asset_urls_standard
      sig { returns(T.nilable(String)) }
      def pay_now_asset_urls_standard; end
      # Attribute for field pay_now_name
      sig { returns(T.nilable(String)) }
      def pay_now_name; end
      # Attribute for field pay_now_redirect_url
      sig { returns(T.nilable(String)) }
      def pay_now_redirect_url; end
      # Attribute for field pay_over_time_asset_urls_descriptive
      sig { returns(T.nilable(String)) }
      def pay_over_time_asset_urls_descriptive; end
      # Attribute for field pay_over_time_asset_urls_standard
      sig { returns(T.nilable(String)) }
      def pay_over_time_asset_urls_standard; end
      # Attribute for field pay_over_time_name
      sig { returns(T.nilable(String)) }
      def pay_over_time_name; end
      # Attribute for field pay_over_time_redirect_url
      sig { returns(T.nilable(String)) }
      def pay_over_time_redirect_url; end
      # Attribute for field payment_method_categories
      sig { returns(T.nilable(String)) }
      def payment_method_categories; end
      # Attribute for field purchase_country
      sig { returns(T.nilable(String)) }
      def purchase_country; end
      # Attribute for field purchase_type
      sig { returns(T.nilable(String)) }
      def purchase_type; end
      # Attribute for field redirect_url
      sig { returns(T.nilable(String)) }
      def redirect_url; end
      # Attribute for field shipping_delay
      sig { returns(T.nilable(Integer)) }
      def shipping_delay; end
      # Attribute for field shipping_first_name
      sig { returns(T.nilable(String)) }
      def shipping_first_name; end
      # Attribute for field shipping_last_name
      sig { returns(T.nilable(String)) }
      def shipping_last_name; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Multibanco < ::Stripe::StripeObject
      # Attribute for field entity
      sig { returns(T.nilable(String)) }
      def entity; end
      # Attribute for field reference
      sig { returns(T.nilable(String)) }
      def reference; end
      # Attribute for field refund_account_holder_address_city
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_city; end
      # Attribute for field refund_account_holder_address_country
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_country; end
      # Attribute for field refund_account_holder_address_line1
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_line1; end
      # Attribute for field refund_account_holder_address_line2
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_line2; end
      # Attribute for field refund_account_holder_address_postal_code
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_postal_code; end
      # Attribute for field refund_account_holder_address_state
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_state; end
      # Attribute for field refund_account_holder_name
      sig { returns(T.nilable(String)) }
      def refund_account_holder_name; end
      # Attribute for field refund_iban
      sig { returns(T.nilable(String)) }
      def refund_iban; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Owner < ::Stripe::StripeObject
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
      class VerifiedAddress < ::Stripe::StripeObject
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
      # Owner's address.
      sig { returns(T.nilable(Address)) }
      def address; end
      # Owner's email address.
      sig { returns(T.nilable(String)) }
      def email; end
      # Owner's full name.
      sig { returns(T.nilable(String)) }
      def name; end
      # Owner's phone number (including extension).
      sig { returns(T.nilable(String)) }
      def phone; end
      # Verified owner's address. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
      sig { returns(T.nilable(VerifiedAddress)) }
      def verified_address; end
      # Verified owner's email address. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
      sig { returns(T.nilable(String)) }
      def verified_email; end
      # Verified owner's full name. Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
      sig { returns(T.nilable(String)) }
      def verified_name; end
      # Verified owner's phone number (including extension). Verified values are verified or provided by the payment method directly (and if supported) at the time of authorization or settlement. They cannot be set or mutated.
      sig { returns(T.nilable(String)) }
      def verified_phone; end
      def self.inner_class_types
        @inner_class_types = {address: Address, verified_address: VerifiedAddress}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class P24 < ::Stripe::StripeObject
      # Attribute for field reference
      sig { returns(T.nilable(String)) }
      def reference; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Receiver < ::Stripe::StripeObject
      # The address of the receiver source. This is the value that should be communicated to the customer to send their funds to.
      sig { returns(T.nilable(String)) }
      def address; end
      # The total amount that was moved to your balance. This is almost always equal to the amount charged. In rare cases when customers deposit excess funds and we are unable to refund those, those funds get moved to your balance and show up in amount_charged as well. The amount charged is expressed in the source's currency.
      sig { returns(Integer) }
      def amount_charged; end
      # The total amount received by the receiver source. `amount_received = amount_returned + amount_charged` should be true for consumed sources unless customers deposit excess funds. The amount received is expressed in the source's currency.
      sig { returns(Integer) }
      def amount_received; end
      # The total amount that was returned to the customer. The amount returned is expressed in the source's currency.
      sig { returns(Integer) }
      def amount_returned; end
      # Type of refund attribute method, one of `email`, `manual`, or `none`.
      sig { returns(String) }
      def refund_attributes_method; end
      # Type of refund attribute status, one of `missing`, `requested`, or `available`.
      sig { returns(String) }
      def refund_attributes_status; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Redirect < ::Stripe::StripeObject
      # The failure reason for the redirect, either `user_abort` (the customer aborted or dropped out of the redirect flow), `declined` (the authentication failed or the transaction was declined), or `processing_error` (the redirect failed due to a technical error). Present only if the redirect status is `failed`.
      sig { returns(T.nilable(String)) }
      def failure_reason; end
      # The URL you provide to redirect the customer to after they authenticated their payment.
      sig { returns(String) }
      def return_url; end
      # The status of the redirect, either `pending` (ready to be used by your customer to authenticate the transaction), `succeeded` (successful authentication, cannot be reused) or `not_required` (redirect should not be used) or `failed` (failed authentication, cannot be reused).
      sig { returns(String) }
      def status; end
      # The URL provided to you to redirect a customer to as part of a `redirect` authentication flow.
      sig { returns(String) }
      def url; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class SepaCreditTransfer < ::Stripe::StripeObject
      # Attribute for field bank_name
      sig { returns(T.nilable(String)) }
      def bank_name; end
      # Attribute for field bic
      sig { returns(T.nilable(String)) }
      def bic; end
      # Attribute for field iban
      sig { returns(T.nilable(String)) }
      def iban; end
      # Attribute for field refund_account_holder_address_city
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_city; end
      # Attribute for field refund_account_holder_address_country
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_country; end
      # Attribute for field refund_account_holder_address_line1
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_line1; end
      # Attribute for field refund_account_holder_address_line2
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_line2; end
      # Attribute for field refund_account_holder_address_postal_code
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_postal_code; end
      # Attribute for field refund_account_holder_address_state
      sig { returns(T.nilable(String)) }
      def refund_account_holder_address_state; end
      # Attribute for field refund_account_holder_name
      sig { returns(T.nilable(String)) }
      def refund_account_holder_name; end
      # Attribute for field refund_iban
      sig { returns(T.nilable(String)) }
      def refund_iban; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class SepaDebit < ::Stripe::StripeObject
      # Attribute for field bank_code
      sig { returns(T.nilable(String)) }
      def bank_code; end
      # Attribute for field branch_code
      sig { returns(T.nilable(String)) }
      def branch_code; end
      # Attribute for field country
      sig { returns(T.nilable(String)) }
      def country; end
      # Attribute for field fingerprint
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Attribute for field last4
      sig { returns(T.nilable(String)) }
      def last4; end
      # Attribute for field mandate_reference
      sig { returns(T.nilable(String)) }
      def mandate_reference; end
      # Attribute for field mandate_url
      sig { returns(T.nilable(String)) }
      def mandate_url; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Sofort < ::Stripe::StripeObject
      # Attribute for field bank_code
      sig { returns(T.nilable(String)) }
      def bank_code; end
      # Attribute for field bank_name
      sig { returns(T.nilable(String)) }
      def bank_name; end
      # Attribute for field bic
      sig { returns(T.nilable(String)) }
      def bic; end
      # Attribute for field country
      sig { returns(T.nilable(String)) }
      def country; end
      # Attribute for field iban_last4
      sig { returns(T.nilable(String)) }
      def iban_last4; end
      # Attribute for field preferred_language
      sig { returns(T.nilable(String)) }
      def preferred_language; end
      # Attribute for field statement_descriptor
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class SourceOrder < ::Stripe::StripeObject
      class Item < ::Stripe::StripeObject
        # The amount (price) for this order item.
        sig { returns(T.nilable(Integer)) }
        def amount; end
        # This currency of this order item. Required when `amount` is present.
        sig { returns(T.nilable(String)) }
        def currency; end
        # Human-readable description for this order item.
        sig { returns(T.nilable(String)) }
        def description; end
        # The ID of the associated object for this line item. Expandable if not null (e.g., expandable to a SKU).
        sig { returns(T.nilable(String)) }
        def parent; end
        # The quantity of this order item. When type is `sku`, this is the number of instances of the SKU to be ordered.
        sig { returns(T.nilable(Integer)) }
        def quantity; end
        # The type of this order item. Must be `sku`, `tax`, or `shipping`.
        sig { returns(T.nilable(String)) }
        def type; end
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
      # A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the total amount for the order.
      sig { returns(Integer) }
      def amount; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # The email address of the customer placing the order.
      sig { returns(T.nilable(String)) }
      def email; end
      # List of items constituting the order.
      sig { returns(T.nilable(T::Array[Item])) }
      def items; end
      # Attribute for field shipping
      sig { returns(T.nilable(Shipping)) }
      def shipping; end
      def self.inner_class_types
        @inner_class_types = {items: Item, shipping: Shipping}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ThreeDSecure < ::Stripe::StripeObject
      # Attribute for field address_line1_check
      sig { returns(T.nilable(String)) }
      def address_line1_check; end
      # Attribute for field address_zip_check
      sig { returns(T.nilable(String)) }
      def address_zip_check; end
      # Attribute for field authenticated
      sig { returns(T.nilable(T::Boolean)) }
      def authenticated; end
      # Attribute for field brand
      sig { returns(T.nilable(String)) }
      def brand; end
      # Attribute for field card
      sig { returns(T.nilable(String)) }
      def card; end
      # Attribute for field country
      sig { returns(T.nilable(String)) }
      def country; end
      # Attribute for field customer
      sig { returns(T.nilable(String)) }
      def customer; end
      # Attribute for field cvc_check
      sig { returns(T.nilable(String)) }
      def cvc_check; end
      # Attribute for field description
      sig { returns(T.nilable(String)) }
      def description; end
      # Attribute for field dynamic_last4
      sig { returns(T.nilable(String)) }
      def dynamic_last4; end
      # Attribute for field exp_month
      sig { returns(T.nilable(Integer)) }
      def exp_month; end
      # Attribute for field exp_year
      sig { returns(T.nilable(Integer)) }
      def exp_year; end
      # Attribute for field fingerprint
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Attribute for field funding
      sig { returns(T.nilable(String)) }
      def funding; end
      # Attribute for field iin
      sig { returns(T.nilable(String)) }
      def iin; end
      # Attribute for field issuer
      sig { returns(T.nilable(String)) }
      def issuer; end
      # Attribute for field last4
      sig { returns(T.nilable(String)) }
      def last4; end
      # Attribute for field name
      sig { returns(T.nilable(String)) }
      def name; end
      # Attribute for field three_d_secure
      sig { returns(T.nilable(String)) }
      def three_d_secure; end
      # Attribute for field tokenization_method
      sig { returns(T.nilable(String)) }
      def tokenization_method; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Wechat < ::Stripe::StripeObject
      # Attribute for field prepay_id
      sig { returns(T.nilable(String)) }
      def prepay_id; end
      # Attribute for field qr_code_url
      sig { returns(T.nilable(String)) }
      def qr_code_url; end
      # Attribute for field statement_descriptor
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
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
    # Attribute for field alipay
    sig { returns(T.nilable(Alipay)) }
    def alipay; end
    # This field indicates whether this payment method can be shown again to its customer in a checkout flow. Stripe products such as Checkout and Elements use this field to determine whether a payment method can be shown as a saved payment method in a checkout flow. The field defaults to “unspecified”.
    sig { returns(T.nilable(String)) }
    def allow_redisplay; end
    # A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the total amount associated with the source. This is the amount for which the source will be chargeable once ready. Required for `single_use` sources.
    sig { returns(T.nilable(Integer)) }
    def amount; end
    # Attribute for field au_becs_debit
    sig { returns(T.nilable(AuBecsDebit)) }
    def au_becs_debit; end
    # Attribute for field bancontact
    sig { returns(T.nilable(Bancontact)) }
    def bancontact; end
    # Attribute for field card
    sig { returns(T.nilable(Card)) }
    def card; end
    # Attribute for field card_present
    sig { returns(T.nilable(CardPresent)) }
    def card_present; end
    # The client secret of the source. Used for client-side retrieval using a publishable key.
    sig { returns(String) }
    def client_secret; end
    # Attribute for field code_verification
    sig { returns(T.nilable(CodeVerification)) }
    def code_verification; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) associated with the source. This is the currency for which the source will be chargeable once ready. Required for `single_use` sources.
    sig { returns(T.nilable(String)) }
    def currency; end
    # The ID of the customer to which this source is attached. This will not be present when the source has not been attached to a customer.
    sig { returns(T.nilable(String)) }
    def customer; end
    # Attribute for field eps
    sig { returns(T.nilable(Eps)) }
    def eps; end
    # The authentication `flow` of the source. `flow` is one of `redirect`, `receiver`, `code_verification`, `none`.
    sig { returns(String) }
    def flow; end
    # Attribute for field giropay
    sig { returns(T.nilable(Giropay)) }
    def giropay; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Attribute for field ideal
    sig { returns(T.nilable(Ideal)) }
    def ideal; end
    # Attribute for field klarna
    sig { returns(T.nilable(Klarna)) }
    def klarna; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # Attribute for field multibanco
    sig { returns(T.nilable(Multibanco)) }
    def multibanco; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Information about the owner of the payment instrument that may be used or required by particular source types.
    sig { returns(T.nilable(Owner)) }
    def owner; end
    # Attribute for field p24
    sig { returns(T.nilable(P24)) }
    def p24; end
    # Attribute for field receiver
    sig { returns(T.nilable(Receiver)) }
    def receiver; end
    # Attribute for field redirect
    sig { returns(T.nilable(Redirect)) }
    def redirect; end
    # Attribute for field sepa_credit_transfer
    sig { returns(T.nilable(SepaCreditTransfer)) }
    def sepa_credit_transfer; end
    # Attribute for field sepa_debit
    sig { returns(T.nilable(SepaDebit)) }
    def sepa_debit; end
    # Attribute for field sofort
    sig { returns(T.nilable(Sofort)) }
    def sofort; end
    # Attribute for field source_order
    sig { returns(T.nilable(SourceOrder)) }
    def source_order; end
    # Extra information about a source. This will appear on your customer's statement every time you charge the source.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    # The status of the source, one of `canceled`, `chargeable`, `consumed`, `failed`, or `pending`. Only `chargeable` sources can be used to create a charge.
    sig { returns(String) }
    def status; end
    # Attribute for field three_d_secure
    sig { returns(T.nilable(ThreeDSecure)) }
    def three_d_secure; end
    # The `type` of the source. The `type` is a payment method, one of `ach_credit_transfer`, `ach_debit`, `alipay`, `bancontact`, `card`, `card_present`, `eps`, `giropay`, `ideal`, `multibanco`, `klarna`, `p24`, `sepa_debit`, `sofort`, `three_d_secure`, or `wechat`. An additional hash is included on the source with a name matching this value. It contains additional information specific to the [payment method](https://docs.stripe.com/sources) used.
    sig { returns(String) }
    def type; end
    # Either `reusable` or `single_use`. Whether this source should be reusable or not. Some source types may or may not be reusable by construction, while others may leave the option at creation. If an incompatible value is passed, an error will be returned.
    sig { returns(T.nilable(String)) }
    def usage; end
    # Attribute for field wechat
    sig { returns(T.nilable(Wechat)) }
    def wechat; end
    # Creates a new source object.
    sig {
      params(params: T.any(::Stripe::SourceCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Source)
     }
    def self.create(params = {}, opts = {}); end

    # Updates the specified source by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    #
    # This request accepts the metadata and owner as arguments. It is also possible to update type specific information for selected payment methods. Please refer to our [payment method guides](https://docs.stripe.com/docs/sources) for more detail.
    sig {
      params(source: String, params: T.any(::Stripe::SourceUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Source)
     }
    def self.update(source, params = {}, opts = {}); end

    # Verify a given source.
    sig {
      params(params: T.any(::Stripe::SourceVerifyParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Source)
     }
    def verify(params = {}, opts = {}); end

    # Verify a given source.
    sig {
      params(source: String, params: T.any(::Stripe::SourceVerifyParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Source)
     }
    def self.verify(source, params = {}, opts = {}); end
  end
end