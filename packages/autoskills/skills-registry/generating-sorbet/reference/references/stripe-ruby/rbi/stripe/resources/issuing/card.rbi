# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    # You can [create physical or virtual cards](https://docs.stripe.com/issuing) that are issued to cardholders.
    class Card < APIResource
      class LatestFraudWarning < ::Stripe::StripeObject
        # Timestamp of the most recent fraud warning.
        sig { returns(T.nilable(Integer)) }
        def started_at; end
        # The type of fraud warning that most recently took place on this card. This field updates with every new fraud warning, so the value changes over time. If populated, cancel and reissue the card.
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
        class AddressValidation < ::Stripe::StripeObject
          class NormalizedAddress < ::Stripe::StripeObject
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
          # The address validation capabilities to use.
          sig { returns(String) }
          def mode; end
          # The normalized shipping address.
          sig { returns(T.nilable(NormalizedAddress)) }
          def normalized_address; end
          # The validation result for the shipping address.
          sig { returns(T.nilable(String)) }
          def result; end
          def self.inner_class_types
            @inner_class_types = {normalized_address: NormalizedAddress}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Customs < ::Stripe::StripeObject
          # A registration number used for customs in Europe. See [https://www.gov.uk/eori](https://www.gov.uk/eori) for the UK and [https://ec.europa.eu/taxation_customs/business/customs-procedures-import-and-export/customs-procedures/economic-operators-registration-and-identification-number-eori_en](https://ec.europa.eu/taxation_customs/business/customs-procedures-import-and-export/customs-procedures/economic-operators-registration-and-identification-number-eori_en) for the EU.
          sig { returns(T.nilable(String)) }
          def eori_number; end
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
        # Address validation details for the shipment.
        sig { returns(T.nilable(AddressValidation)) }
        def address_validation; end
        # The delivery company that shipped a card.
        sig { returns(T.nilable(String)) }
        def carrier; end
        # Additional information that may be required for clearing customs.
        sig { returns(T.nilable(Customs)) }
        def customs; end
        # A unix timestamp representing a best estimate of when the card will be delivered.
        sig { returns(T.nilable(Integer)) }
        def eta; end
        # Recipient name.
        sig { returns(String) }
        def name; end
        # The phone number of the receiver of the shipment. Our courier partners will use this number to contact you in the event of card delivery issues. For individual shipments to the EU/UK, if this field is empty, we will provide them with the phone number provided when the cardholder was initially created.
        sig { returns(T.nilable(String)) }
        def phone_number; end
        # Whether a signature is required for card delivery. This feature is only supported for US users. Standard shipping service does not support signature on delivery. The default value for standard shipping service is false and for express and priority services is true.
        sig { returns(T.nilable(T::Boolean)) }
        def require_signature; end
        # Shipment service, such as `standard` or `express`.
        sig { returns(String) }
        def service; end
        # The delivery status of the card.
        sig { returns(T.nilable(String)) }
        def status; end
        # A tracking number for a card shipment.
        sig { returns(T.nilable(String)) }
        def tracking_number; end
        # A link to the shipping carrier's site where you can view detailed information about a card shipment.
        sig { returns(T.nilable(String)) }
        def tracking_url; end
        # Packaging options.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {
            address: Address,
            address_validation: AddressValidation,
            customs: Customs,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class SpendingControls < ::Stripe::StripeObject
        class SpendingLimit < ::Stripe::StripeObject
          # Maximum amount allowed to spend per interval. This amount is in the card's currency and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
          sig { returns(Integer) }
          def amount; end
          # Array of strings containing [categories](https://docs.stripe.com/api#issuing_authorization_object-merchant_data-category) this limit applies to. Omitting this field will apply the limit to all categories.
          sig { returns(T.nilable(T::Array[String])) }
          def categories; end
          # Interval (or event) to which the amount applies.
          sig { returns(String) }
          def interval; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Array of strings containing [categories](https://docs.stripe.com/api#issuing_authorization_object-merchant_data-category) of authorizations to allow. All other categories will be blocked. Cannot be set with `blocked_categories`.
        sig { returns(T.nilable(T::Array[String])) }
        def allowed_categories; end
        # Array of strings containing representing countries from which authorizations will be allowed. Authorizations from merchants in all other countries will be declined. Country codes should be ISO 3166 alpha-2 country codes (e.g. `US`). Cannot be set with `blocked_merchant_countries`. Provide an empty value to unset this control.
        sig { returns(T.nilable(T::Array[String])) }
        def allowed_merchant_countries; end
        # Array of strings containing [categories](https://docs.stripe.com/api#issuing_authorization_object-merchant_data-category) of authorizations to decline. All other categories will be allowed. Cannot be set with `allowed_categories`.
        sig { returns(T.nilable(T::Array[String])) }
        def blocked_categories; end
        # Array of strings containing representing countries from which authorizations will be declined. Country codes should be ISO 3166 alpha-2 country codes (e.g. `US`). Cannot be set with `allowed_merchant_countries`. Provide an empty value to unset this control.
        sig { returns(T.nilable(T::Array[String])) }
        def blocked_merchant_countries; end
        # Limit spending with amount-based rules that apply across any cards this card replaced (i.e., its `replacement_for` card and _that_ card's `replacement_for` card, up the chain).
        sig { returns(T.nilable(T::Array[SpendingLimit])) }
        def spending_limits; end
        # Currency of the amounts within `spending_limits`. Always the same as the currency of the card.
        sig { returns(T.nilable(String)) }
        def spending_limits_currency; end
        def self.inner_class_types
          @inner_class_types = {spending_limits: SpendingLimit}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Wallets < ::Stripe::StripeObject
        class ApplePay < ::Stripe::StripeObject
          # Apple Pay Eligibility
          sig { returns(T::Boolean) }
          def eligible; end
          # Reason the card is ineligible for Apple Pay
          sig { returns(T.nilable(String)) }
          def ineligible_reason; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class GooglePay < ::Stripe::StripeObject
          # Google Pay Eligibility
          sig { returns(T::Boolean) }
          def eligible; end
          # Reason the card is ineligible for Google Pay
          sig { returns(T.nilable(String)) }
          def ineligible_reason; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field apple_pay
        sig { returns(ApplePay) }
        def apple_pay; end
        # Attribute for field google_pay
        sig { returns(GooglePay) }
        def google_pay; end
        # Unique identifier for a card used with digital wallets
        sig { returns(T.nilable(String)) }
        def primary_account_identifier; end
        def self.inner_class_types
          @inner_class_types = {apple_pay: ApplePay, google_pay: GooglePay}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The brand of the card.
      sig { returns(String) }
      def brand; end
      # The reason why the card was canceled.
      sig { returns(T.nilable(String)) }
      def cancellation_reason; end
      # An Issuing `Cardholder` object represents an individual or business entity who is [issued](https://docs.stripe.com/issuing) cards.
      #
      # Related guide: [How to create a cardholder](https://docs.stripe.com/issuing/cards/virtual/issue-cards#create-cardholder)
      sig { returns(::Stripe::Issuing::Cardholder) }
      def cardholder; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Supported currencies are `usd` in the US, `eur` in the EU, and `gbp` in the UK.
      sig { returns(String) }
      def currency; end
      # The card's CVC. For security reasons, this is only available for virtual cards, and will be omitted unless you explicitly request it with [the `expand` parameter](https://docs.stripe.com/api/expanding_objects). Additionally, it's only available via the ["Retrieve a card" endpoint](https://docs.stripe.com/api/issuing/cards/retrieve), not via "List all cards" or any other endpoint.
      sig { returns(T.nilable(String)) }
      def cvc; end
      # The expiration month of the card.
      sig { returns(Integer) }
      def exp_month; end
      # The expiration year of the card.
      sig { returns(Integer) }
      def exp_year; end
      # The financial account this card is attached to.
      sig { returns(T.nilable(String)) }
      def financial_account; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # The last 4 digits of the card number.
      sig { returns(String) }
      def last4; end
      # Stripe’s assessment of whether this card’s details have been compromised. If this property isn't null, cancel and reissue the card to prevent fraudulent activity risk.
      sig { returns(T.nilable(LatestFraudWarning)) }
      def latest_fraud_warning; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # The full unredacted card number. For security reasons, this is only available for virtual cards, and will be omitted unless you explicitly request it with [the `expand` parameter](https://docs.stripe.com/api/expanding_objects). Additionally, it's only available via the ["Retrieve a card" endpoint](https://docs.stripe.com/api/issuing/cards/retrieve), not via "List all cards" or any other endpoint.
      sig { returns(T.nilable(String)) }
      def number; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The personalization design object belonging to this card.
      sig { returns(T.nilable(T.any(String, ::Stripe::Issuing::PersonalizationDesign))) }
      def personalization_design; end
      # The latest card that replaces this card, if any.
      sig { returns(T.nilable(T.any(String, ::Stripe::Issuing::Card))) }
      def replaced_by; end
      # The card this card replaces, if any.
      sig { returns(T.nilable(T.any(String, ::Stripe::Issuing::Card))) }
      def replacement_for; end
      # The reason why the previous card needed to be replaced.
      sig { returns(T.nilable(String)) }
      def replacement_reason; end
      # Text separate from cardholder name, printed on the card.
      sig { returns(T.nilable(String)) }
      def second_line; end
      # Where and how the card will be shipped.
      sig { returns(T.nilable(Shipping)) }
      def shipping; end
      # Attribute for field spending_controls
      sig { returns(SpendingControls) }
      def spending_controls; end
      # Whether authorizations can be approved on this card. May be blocked from activating cards depending on past-due Cardholder requirements. Defaults to `inactive`.
      sig { returns(String) }
      def status; end
      # The type of the card.
      sig { returns(String) }
      def type; end
      # Information relating to digital wallets (like Apple Pay and Google Pay).
      sig { returns(T.nilable(Wallets)) }
      def wallets; end
      # Creates an Issuing Card object.
      sig {
        params(params: T.any(::Stripe::Issuing::CardCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of Issuing Card objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::CardListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates the specified Issuing Card object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
      sig {
        params(card: String, params: T.any(::Stripe::Issuing::CardUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
       }
      def self.update(card, params = {}, opts = {}); end
    end
  end
end