# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class CardholderCreateParams < ::Stripe::RequestParams
      class Billing < ::Stripe::RequestParams
        class Address < ::Stripe::RequestParams
          # City, district, suburb, town, or village.
          sig { returns(String) }
          def city; end
          sig { params(_city: String).returns(String) }
          def city=(_city); end
          # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
          sig { returns(String) }
          def country; end
          sig { params(_country: String).returns(String) }
          def country=(_country); end
          # Address line 1, such as the street, PO Box, or company name.
          sig { returns(String) }
          def line1; end
          sig { params(_line1: String).returns(String) }
          def line1=(_line1); end
          # Address line 2, such as the apartment, suite, unit, or building.
          sig { returns(T.nilable(String)) }
          def line2; end
          sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
          def line2=(_line2); end
          # ZIP or postal code.
          sig { returns(String) }
          def postal_code; end
          sig { params(_postal_code: String).returns(String) }
          def postal_code=(_postal_code); end
          # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
          sig { returns(T.nilable(String)) }
          def state; end
          sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
          def state=(_state); end
          sig {
            params(city: String, country: String, line1: String, line2: T.nilable(String), postal_code: String, state: T.nilable(String)).void
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
        # The cardholder’s billing address.
        sig { returns(Issuing::CardholderCreateParams::Billing::Address) }
        def address; end
        sig {
          params(_address: Issuing::CardholderCreateParams::Billing::Address).returns(Issuing::CardholderCreateParams::Billing::Address)
         }
        def address=(_address); end
        sig { params(address: Issuing::CardholderCreateParams::Billing::Address).void }
        def initialize(address: nil); end
      end
      class Company < ::Stripe::RequestParams
        # The entity's business ID number.
        sig { returns(T.nilable(String)) }
        def tax_id; end
        sig { params(_tax_id: T.nilable(String)).returns(T.nilable(String)) }
        def tax_id=(_tax_id); end
        sig { params(tax_id: T.nilable(String)).void }
        def initialize(tax_id: nil); end
      end
      class Individual < ::Stripe::RequestParams
        class CardIssuing < ::Stripe::RequestParams
          class UserTermsAcceptance < ::Stripe::RequestParams
            # The Unix timestamp marking when the cardholder accepted the Authorized User Terms. Required for Celtic Spend Card users.
            sig { returns(T.nilable(Integer)) }
            def date; end
            sig { params(_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
            def date=(_date); end
            # The IP address from which the cardholder accepted the Authorized User Terms. Required for Celtic Spend Card users.
            sig { returns(T.nilable(String)) }
            def ip; end
            sig { params(_ip: T.nilable(String)).returns(T.nilable(String)) }
            def ip=(_ip); end
            # The user agent of the browser from which the cardholder accepted the Authorized User Terms.
            sig { returns(T.nilable(String)) }
            def user_agent; end
            sig { params(_user_agent: T.nilable(String)).returns(T.nilable(String)) }
            def user_agent=(_user_agent); end
            sig {
              params(date: T.nilable(Integer), ip: T.nilable(String), user_agent: T.nilable(String)).void
             }
            def initialize(date: nil, ip: nil, user_agent: nil); end
          end
          # Information about cardholder acceptance of Celtic [Authorized User Terms](https://stripe.com/docs/issuing/cards#accept-authorized-user-terms). Required for cards backed by a Celtic program.
          sig {
            returns(T.nilable(Issuing::CardholderCreateParams::Individual::CardIssuing::UserTermsAcceptance))
           }
          def user_terms_acceptance; end
          sig {
            params(_user_terms_acceptance: T.nilable(Issuing::CardholderCreateParams::Individual::CardIssuing::UserTermsAcceptance)).returns(T.nilable(Issuing::CardholderCreateParams::Individual::CardIssuing::UserTermsAcceptance))
           }
          def user_terms_acceptance=(_user_terms_acceptance); end
          sig {
            params(user_terms_acceptance: T.nilable(Issuing::CardholderCreateParams::Individual::CardIssuing::UserTermsAcceptance)).void
           }
          def initialize(user_terms_acceptance: nil); end
        end
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
        class Verification < ::Stripe::RequestParams
          class Document < ::Stripe::RequestParams
            # The back of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`.
            sig { returns(T.nilable(String)) }
            def back; end
            sig { params(_back: T.nilable(String)).returns(T.nilable(String)) }
            def back=(_back); end
            # The front of an ID returned by a [file upload](https://api.stripe.com#create_file) with a `purpose` value of `identity_document`.
            sig { returns(T.nilable(String)) }
            def front; end
            sig { params(_front: T.nilable(String)).returns(T.nilable(String)) }
            def front=(_front); end
            sig { params(back: T.nilable(String), front: T.nilable(String)).void }
            def initialize(back: nil, front: nil); end
          end
          # An identifying document, either a passport or local ID card.
          sig {
            returns(T.nilable(Issuing::CardholderCreateParams::Individual::Verification::Document))
           }
          def document; end
          sig {
            params(_document: T.nilable(Issuing::CardholderCreateParams::Individual::Verification::Document)).returns(T.nilable(Issuing::CardholderCreateParams::Individual::Verification::Document))
           }
          def document=(_document); end
          sig {
            params(document: T.nilable(Issuing::CardholderCreateParams::Individual::Verification::Document)).void
           }
          def initialize(document: nil); end
        end
        # Information related to the card_issuing program for this cardholder.
        sig { returns(T.nilable(Issuing::CardholderCreateParams::Individual::CardIssuing)) }
        def card_issuing; end
        sig {
          params(_card_issuing: T.nilable(Issuing::CardholderCreateParams::Individual::CardIssuing)).returns(T.nilable(Issuing::CardholderCreateParams::Individual::CardIssuing))
         }
        def card_issuing=(_card_issuing); end
        # The date of birth of this cardholder. Cardholders must be older than 13 years old.
        sig { returns(T.nilable(Issuing::CardholderCreateParams::Individual::Dob)) }
        def dob; end
        sig {
          params(_dob: T.nilable(Issuing::CardholderCreateParams::Individual::Dob)).returns(T.nilable(Issuing::CardholderCreateParams::Individual::Dob))
         }
        def dob=(_dob); end
        # The first name of this cardholder. Required before activating Cards. This field cannot contain any numbers, special characters (except periods, commas, hyphens, spaces and apostrophes) or non-latin letters.
        sig { returns(T.nilable(String)) }
        def first_name; end
        sig { params(_first_name: T.nilable(String)).returns(T.nilable(String)) }
        def first_name=(_first_name); end
        # The last name of this cardholder. Required before activating Cards. This field cannot contain any numbers, special characters (except periods, commas, hyphens, spaces and apostrophes) or non-latin letters.
        sig { returns(T.nilable(String)) }
        def last_name; end
        sig { params(_last_name: T.nilable(String)).returns(T.nilable(String)) }
        def last_name=(_last_name); end
        # Government-issued ID document for this cardholder.
        sig { returns(T.nilable(Issuing::CardholderCreateParams::Individual::Verification)) }
        def verification; end
        sig {
          params(_verification: T.nilable(Issuing::CardholderCreateParams::Individual::Verification)).returns(T.nilable(Issuing::CardholderCreateParams::Individual::Verification))
         }
        def verification=(_verification); end
        sig {
          params(card_issuing: T.nilable(Issuing::CardholderCreateParams::Individual::CardIssuing), dob: T.nilable(Issuing::CardholderCreateParams::Individual::Dob), first_name: T.nilable(String), last_name: T.nilable(String), verification: T.nilable(Issuing::CardholderCreateParams::Individual::Verification)).void
         }
        def initialize(
          card_issuing: nil,
          dob: nil,
          first_name: nil,
          last_name: nil,
          verification: nil
        ); end
      end
      class SpendingControls < ::Stripe::RequestParams
        class SpendingLimit < ::Stripe::RequestParams
          # Maximum amount allowed to spend per interval.
          sig { returns(Integer) }
          def amount; end
          sig { params(_amount: Integer).returns(Integer) }
          def amount=(_amount); end
          # Array of strings containing [categories](https://docs.stripe.com/api#issuing_authorization_object-merchant_data-category) this limit applies to. Omitting this field will apply the limit to all categories.
          sig { returns(T.nilable(T::Array[String])) }
          def categories; end
          sig {
            params(_categories: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def categories=(_categories); end
          # Interval (or event) to which the amount applies.
          sig { returns(String) }
          def interval; end
          sig { params(_interval: String).returns(String) }
          def interval=(_interval); end
          sig {
            params(amount: Integer, categories: T.nilable(T::Array[String]), interval: String).void
           }
          def initialize(amount: nil, categories: nil, interval: nil); end
        end
        # Array of strings containing [categories](https://docs.stripe.com/api#issuing_authorization_object-merchant_data-category) of authorizations to allow. All other categories will be blocked. Cannot be set with `blocked_categories`.
        sig { returns(T.nilable(T::Array[String])) }
        def allowed_categories; end
        sig {
          params(_allowed_categories: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def allowed_categories=(_allowed_categories); end
        # Array of strings containing representing countries from which authorizations will be allowed. Authorizations from merchants in all other countries will be declined. Country codes should be ISO 3166 alpha-2 country codes (e.g. `US`). Cannot be set with `blocked_merchant_countries`. Provide an empty value to unset this control.
        sig { returns(T.nilable(T::Array[String])) }
        def allowed_merchant_countries; end
        sig {
          params(_allowed_merchant_countries: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def allowed_merchant_countries=(_allowed_merchant_countries); end
        # Array of strings containing [categories](https://docs.stripe.com/api#issuing_authorization_object-merchant_data-category) of authorizations to decline. All other categories will be allowed. Cannot be set with `allowed_categories`.
        sig { returns(T.nilable(T::Array[String])) }
        def blocked_categories; end
        sig {
          params(_blocked_categories: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def blocked_categories=(_blocked_categories); end
        # Array of strings containing representing countries from which authorizations will be declined. Country codes should be ISO 3166 alpha-2 country codes (e.g. `US`). Cannot be set with `allowed_merchant_countries`. Provide an empty value to unset this control.
        sig { returns(T.nilable(T::Array[String])) }
        def blocked_merchant_countries; end
        sig {
          params(_blocked_merchant_countries: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def blocked_merchant_countries=(_blocked_merchant_countries); end
        # Limit spending with amount-based rules that apply across this cardholder's cards.
        sig {
          returns(T.nilable(T::Array[Issuing::CardholderCreateParams::SpendingControls::SpendingLimit]))
         }
        def spending_limits; end
        sig {
          params(_spending_limits: T.nilable(T::Array[Issuing::CardholderCreateParams::SpendingControls::SpendingLimit])).returns(T.nilable(T::Array[Issuing::CardholderCreateParams::SpendingControls::SpendingLimit]))
         }
        def spending_limits=(_spending_limits); end
        # Currency of amounts within `spending_limits`. Defaults to your merchant country's currency.
        sig { returns(T.nilable(String)) }
        def spending_limits_currency; end
        sig { params(_spending_limits_currency: T.nilable(String)).returns(T.nilable(String)) }
        def spending_limits_currency=(_spending_limits_currency); end
        sig {
          params(allowed_categories: T.nilable(T::Array[String]), allowed_merchant_countries: T.nilable(T::Array[String]), blocked_categories: T.nilable(T::Array[String]), blocked_merchant_countries: T.nilable(T::Array[String]), spending_limits: T.nilable(T::Array[Issuing::CardholderCreateParams::SpendingControls::SpendingLimit]), spending_limits_currency: T.nilable(String)).void
         }
        def initialize(
          allowed_categories: nil,
          allowed_merchant_countries: nil,
          blocked_categories: nil,
          blocked_merchant_countries: nil,
          spending_limits: nil,
          spending_limits_currency: nil
        ); end
      end
      # The cardholder's billing address.
      sig { returns(Issuing::CardholderCreateParams::Billing) }
      def billing; end
      sig {
        params(_billing: Issuing::CardholderCreateParams::Billing).returns(Issuing::CardholderCreateParams::Billing)
       }
      def billing=(_billing); end
      # Additional information about a `company` cardholder.
      sig { returns(T.nilable(Issuing::CardholderCreateParams::Company)) }
      def company; end
      sig {
        params(_company: T.nilable(Issuing::CardholderCreateParams::Company)).returns(T.nilable(Issuing::CardholderCreateParams::Company))
       }
      def company=(_company); end
      # The cardholder's email address.
      sig { returns(T.nilable(String)) }
      def email; end
      sig { params(_email: T.nilable(String)).returns(T.nilable(String)) }
      def email=(_email); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Additional information about an `individual` cardholder.
      sig { returns(T.nilable(Issuing::CardholderCreateParams::Individual)) }
      def individual; end
      sig {
        params(_individual: T.nilable(Issuing::CardholderCreateParams::Individual)).returns(T.nilable(Issuing::CardholderCreateParams::Individual))
       }
      def individual=(_individual); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The cardholder's name. This will be printed on cards issued to them. The maximum length of this field is 24 characters. This field cannot contain any special characters or numbers.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      # The cardholder's phone number. This will be transformed to [E.164](https://en.wikipedia.org/wiki/E.164) if it is not provided in that format already. This is required for all cardholders who will be creating EU cards. See the [3D Secure documentation](https://docs.stripe.com/issuing/3d-secure#when-is-3d-secure-applied) for more details.
      sig { returns(T.nilable(String)) }
      def phone_number; end
      sig { params(_phone_number: T.nilable(String)).returns(T.nilable(String)) }
      def phone_number=(_phone_number); end
      # The cardholder’s preferred locales (languages), ordered by preference. Locales can be `de`, `en`, `es`, `fr`, or `it`.
      #  This changes the language of the [3D Secure flow](https://docs.stripe.com/issuing/3d-secure) and one-time password messages sent to the cardholder.
      sig { returns(T.nilable(T::Array[String])) }
      def preferred_locales; end
      sig {
        params(_preferred_locales: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
       }
      def preferred_locales=(_preferred_locales); end
      # Rules that control spending across this cardholder's cards. Refer to our [documentation](https://docs.stripe.com/issuing/controls/spending-controls) for more details.
      sig { returns(T.nilable(Issuing::CardholderCreateParams::SpendingControls)) }
      def spending_controls; end
      sig {
        params(_spending_controls: T.nilable(Issuing::CardholderCreateParams::SpendingControls)).returns(T.nilable(Issuing::CardholderCreateParams::SpendingControls))
       }
      def spending_controls=(_spending_controls); end
      # Specifies whether to permit authorizations on this cardholder's cards. Defaults to `active`.
      sig { returns(T.nilable(String)) }
      def status; end
      sig { params(_status: T.nilable(String)).returns(T.nilable(String)) }
      def status=(_status); end
      # One of `individual` or `company`. See [Choose a cardholder type](https://docs.stripe.com/issuing/other/choose-cardholder) for more details.
      sig { returns(T.nilable(String)) }
      def type; end
      sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
      def type=(_type); end
      sig {
        params(billing: Issuing::CardholderCreateParams::Billing, company: T.nilable(Issuing::CardholderCreateParams::Company), email: T.nilable(String), expand: T.nilable(T::Array[String]), individual: T.nilable(Issuing::CardholderCreateParams::Individual), metadata: T.nilable(T::Hash[String, String]), name: String, phone_number: T.nilable(String), preferred_locales: T.nilable(T::Array[String]), spending_controls: T.nilable(Issuing::CardholderCreateParams::SpendingControls), status: T.nilable(String), type: T.nilable(String)).void
       }
      def initialize(
        billing: nil,
        company: nil,
        email: nil,
        expand: nil,
        individual: nil,
        metadata: nil,
        name: nil,
        phone_number: nil,
        preferred_locales: nil,
        spending_controls: nil,
        status: nil,
        type: nil
      ); end
    end
  end
end