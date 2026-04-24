# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    # An Issuing `Cardholder` object represents an individual or business entity who is [issued](https://docs.stripe.com/issuing) cards.
    #
    # Related guide: [How to create a cardholder](https://docs.stripe.com/issuing/cards/virtual/issue-cards#create-cardholder)
    class Cardholder < APIResource
      class Billing < ::Stripe::StripeObject
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
        def self.inner_class_types
          @inner_class_types = {address: Address}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Company < ::Stripe::StripeObject
        # Whether the company's business ID number was provided.
        sig { returns(T::Boolean) }
        def tax_id_provided; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Individual < ::Stripe::StripeObject
        class CardIssuing < ::Stripe::StripeObject
          class UserTermsAcceptance < ::Stripe::StripeObject
            # The Unix timestamp marking when the cardholder accepted the Authorized User Terms.
            sig { returns(T.nilable(Integer)) }
            def date; end
            # The IP address from which the cardholder accepted the Authorized User Terms.
            sig { returns(T.nilable(String)) }
            def ip; end
            # The user agent of the browser from which the cardholder accepted the Authorized User Terms.
            sig { returns(T.nilable(String)) }
            def user_agent; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Information about cardholder acceptance of Celtic [Authorized User Terms](https://stripe.com/docs/issuing/cards#accept-authorized-user-terms). Required for cards backed by a Celtic program.
          sig { returns(T.nilable(UserTermsAcceptance)) }
          def user_terms_acceptance; end
          def self.inner_class_types
            @inner_class_types = {user_terms_acceptance: UserTermsAcceptance}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
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
        class Verification < ::Stripe::StripeObject
          class Document < ::Stripe::StripeObject
            # The back of a document returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`.
            sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
            def back; end
            # The front of a document returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`.
            sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
            def front; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # An identifying document, either a passport or local ID card.
          sig { returns(T.nilable(Document)) }
          def document; end
          def self.inner_class_types
            @inner_class_types = {document: Document}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Information related to the card_issuing program for this cardholder.
        sig { returns(T.nilable(CardIssuing)) }
        def card_issuing; end
        # The date of birth of this cardholder.
        sig { returns(T.nilable(Dob)) }
        def dob; end
        # The first name of this cardholder. Required before activating Cards. This field cannot contain any numbers, special characters (except periods, commas, hyphens, spaces and apostrophes) or non-latin letters.
        sig { returns(T.nilable(String)) }
        def first_name; end
        # The last name of this cardholder. Required before activating Cards. This field cannot contain any numbers, special characters (except periods, commas, hyphens, spaces and apostrophes) or non-latin letters.
        sig { returns(T.nilable(String)) }
        def last_name; end
        # Government-issued ID document for this cardholder.
        sig { returns(T.nilable(Verification)) }
        def verification; end
        def self.inner_class_types
          @inner_class_types = {card_issuing: CardIssuing, dob: Dob, verification: Verification}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Requirements < ::Stripe::StripeObject
        # If `disabled_reason` is present, all cards will decline authorizations with `cardholder_verification_required` reason.
        sig { returns(T.nilable(String)) }
        def disabled_reason; end
        # Array of fields that need to be collected in order to verify and re-enable the cardholder.
        sig { returns(T.nilable(T::Array[String])) }
        def past_due; end
        def self.inner_class_types
          @inner_class_types = {}
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
        # Limit spending with amount-based rules that apply across this cardholder's cards.
        sig { returns(T.nilable(T::Array[SpendingLimit])) }
        def spending_limits; end
        # Currency of the amounts within `spending_limits`.
        sig { returns(T.nilable(String)) }
        def spending_limits_currency; end
        def self.inner_class_types
          @inner_class_types = {spending_limits: SpendingLimit}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field billing
      sig { returns(Billing) }
      def billing; end
      # Additional information about a `company` cardholder.
      sig { returns(T.nilable(Company)) }
      def company; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # The cardholder's email address.
      sig { returns(T.nilable(String)) }
      def email; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Additional information about an `individual` cardholder.
      sig { returns(T.nilable(Individual)) }
      def individual; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # The cardholder's name. This will be printed on cards issued to them.
      sig { returns(String) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The cardholder's phone number. This is required for all cardholders who will be creating EU cards. See the [3D Secure documentation](https://docs.stripe.com/issuing/3d-secure#when-is-3d-secure-applied) for more details.
      sig { returns(T.nilable(String)) }
      def phone_number; end
      # The cardholder’s preferred locales (languages), ordered by preference. Locales can be `de`, `en`, `es`, `fr`, or `it`.
      #  This changes the language of the [3D Secure flow](https://docs.stripe.com/issuing/3d-secure) and one-time password messages sent to the cardholder.
      sig { returns(T.nilable(T::Array[String])) }
      def preferred_locales; end
      # Attribute for field requirements
      sig { returns(Requirements) }
      def requirements; end
      # Rules that control spending across this cardholder's cards. Refer to our [documentation](https://docs.stripe.com/issuing/controls/spending-controls) for more details.
      sig { returns(T.nilable(SpendingControls)) }
      def spending_controls; end
      # Specifies whether to permit authorizations on this cardholder's cards.
      sig { returns(String) }
      def status; end
      # One of `individual` or `company`. See [Choose a cardholder type](https://docs.stripe.com/issuing/other/choose-cardholder) for more details.
      sig { returns(String) }
      def type; end
      # Creates a new Issuing Cardholder object that can be issued cards.
      sig {
        params(params: T.any(::Stripe::Issuing::CardholderCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Cardholder)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of Issuing Cardholder objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::CardholderListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates the specified Issuing Cardholder object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
      sig {
        params(cardholder: String, params: T.any(::Stripe::Issuing::CardholderUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Cardholder)
       }
      def self.update(cardholder, params = {}, opts = {}); end
    end
  end
end