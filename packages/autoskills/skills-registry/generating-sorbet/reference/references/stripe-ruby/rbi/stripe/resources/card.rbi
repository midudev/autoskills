# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # You can store multiple cards on a customer in order to charge the customer
  # later. You can also store multiple debit cards on a recipient in order to
  # transfer to those cards later.
  #
  # Related guide: [Card payments with Sources](https://docs.stripe.com/sources/cards)
  class Card < APIResource
    class Networks < ::Stripe::StripeObject
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
    # Attribute for field account
    sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
    def account; end
    # City/District/Suburb/Town/Village.
    sig { returns(T.nilable(String)) }
    def address_city; end
    # Billing address country, if provided when creating card.
    sig { returns(T.nilable(String)) }
    def address_country; end
    # Address line 1 (Street address/PO Box/Company name).
    sig { returns(T.nilable(String)) }
    def address_line1; end
    # If `address_line1` was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    sig { returns(T.nilable(String)) }
    def address_line1_check; end
    # Address line 2 (Apartment/Suite/Unit/Building).
    sig { returns(T.nilable(String)) }
    def address_line2; end
    # State/County/Province/Region.
    sig { returns(T.nilable(String)) }
    def address_state; end
    # ZIP or postal code.
    sig { returns(T.nilable(String)) }
    def address_zip; end
    # If `address_zip` was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`.
    sig { returns(T.nilable(String)) }
    def address_zip_check; end
    # This field indicates whether this payment method can be shown again to its customer in a checkout flow. Stripe products such as Checkout and Elements use this field to determine whether a payment method can be shown as a saved payment method in a checkout flow. The field defaults to “unspecified”.
    sig { returns(T.nilable(String)) }
    def allow_redisplay; end
    # A set of available payout methods for this card. Only values from this set should be passed as the `method` when creating a payout.
    sig { returns(T.nilable(T::Array[String])) }
    def available_payout_methods; end
    # Card brand. Can be `American Express`, `Cartes Bancaires`, `Diners Club`, `Discover`, `Eftpos Australia`, `Girocard`, `JCB`, `MasterCard`, `UnionPay`, `Visa`, or `Unknown`.
    sig { returns(String) }
    def brand; end
    # Two-letter ISO code representing the country of the card. You could use this attribute to get a sense of the international breakdown of cards you've collected.
    sig { returns(T.nilable(String)) }
    def country; end
    # Three-letter [ISO code for currency](https://www.iso.org/iso-4217-currency-codes.html) in lowercase. Must be a [supported currency](https://docs.stripe.com/currencies). Only applicable on accounts (not customers or recipients). The card can be used as a transfer destination for funds in this currency. This property is only available when returned as an [External Account](/api/external_account_cards/object) where [controller.is_controller](/api/accounts/object#account_object-controller-is_controller) is `true`.
    sig { returns(T.nilable(String)) }
    def currency; end
    # The customer that this card belongs to. This attribute will not be in the card object if the card belongs to an account or recipient instead.
    sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
    def customer; end
    # If a CVC was provided, results of the check: `pass`, `fail`, `unavailable`, or `unchecked`. A result of unchecked indicates that CVC was provided but hasn't been checked yet. Checks are typically performed when attaching a card to a Customer object, or when creating a charge. For more details, see [Check if a card is valid without a charge](https://support.stripe.com/questions/check-if-a-card-is-valid-without-a-charge).
    sig { returns(T.nilable(String)) }
    def cvc_check; end
    # Whether this card is the default external account for its currency. This property is only available for accounts where [controller.requirement_collection](/api/accounts/object#account_object-controller-requirement_collection) is `application`, which includes Custom accounts.
    sig { returns(T.nilable(T::Boolean)) }
    def default_for_currency; end
    # A high-level description of the type of cards issued in this range. (For internal use only and not typically available in standard API requests.)
    sig { returns(T.nilable(String)) }
    def description; end
    # (For tokenized numbers only.) The last four digits of the device account number.
    sig { returns(T.nilable(String)) }
    def dynamic_last4; end
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
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Issuer identification number of the card. (For internal use only and not typically available in standard API requests.)
    sig { returns(T.nilable(String)) }
    def iin; end
    # The name of the card's issuing bank. (For internal use only and not typically available in standard API requests.)
    sig { returns(T.nilable(String)) }
    def issuer; end
    # The last four digits of the card.
    sig { returns(String) }
    def last4; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # Cardholder name.
    sig { returns(T.nilable(String)) }
    def name; end
    # Attribute for field networks
    sig { returns(T.nilable(Networks)) }
    def networks; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Status of a card based on the card issuer.
    sig { returns(T.nilable(String)) }
    def regulated_status; end
    # For external accounts that are cards, possible values are `new` and `errored`. If a payout fails, the status is set to `errored` and [scheduled payouts](https://stripe.com/docs/payouts#payout-schedule) are stopped until account details are updated.
    sig { returns(T.nilable(String)) }
    def status; end
    # If the card number is tokenized, this is the method that was used. Can be `android_pay` (includes Google Pay), `apple_pay`, `masterpass`, `visa_checkout`, or null.
    sig { returns(T.nilable(String)) }
    def tokenization_method; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
  end
end