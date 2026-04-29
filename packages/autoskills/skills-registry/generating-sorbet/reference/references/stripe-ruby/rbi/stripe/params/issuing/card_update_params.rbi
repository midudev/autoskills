# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class CardUpdateParams < ::Stripe::RequestParams
      class Pin < ::Stripe::RequestParams
        # The card's desired new PIN, encrypted under Stripe's public key.
        sig { returns(T.nilable(String)) }
        def encrypted_number; end
        sig { params(_encrypted_number: T.nilable(String)).returns(T.nilable(String)) }
        def encrypted_number=(_encrypted_number); end
        sig { params(encrypted_number: T.nilable(String)).void }
        def initialize(encrypted_number: nil); end
      end
      class Shipping < ::Stripe::RequestParams
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
        class AddressValidation < ::Stripe::RequestParams
          # The address validation capabilities to use.
          sig { returns(String) }
          def mode; end
          sig { params(_mode: String).returns(String) }
          def mode=(_mode); end
          sig { params(mode: String).void }
          def initialize(mode: nil); end
        end
        class Customs < ::Stripe::RequestParams
          # The Economic Operators Registration and Identification (EORI) number to use for Customs. Required for bulk shipments to Europe.
          sig { returns(T.nilable(String)) }
          def eori_number; end
          sig { params(_eori_number: T.nilable(String)).returns(T.nilable(String)) }
          def eori_number=(_eori_number); end
          sig { params(eori_number: T.nilable(String)).void }
          def initialize(eori_number: nil); end
        end
        # The address that the card is shipped to.
        sig { returns(Issuing::CardUpdateParams::Shipping::Address) }
        def address; end
        sig {
          params(_address: Issuing::CardUpdateParams::Shipping::Address).returns(Issuing::CardUpdateParams::Shipping::Address)
         }
        def address=(_address); end
        # Address validation settings.
        sig { returns(T.nilable(Issuing::CardUpdateParams::Shipping::AddressValidation)) }
        def address_validation; end
        sig {
          params(_address_validation: T.nilable(Issuing::CardUpdateParams::Shipping::AddressValidation)).returns(T.nilable(Issuing::CardUpdateParams::Shipping::AddressValidation))
         }
        def address_validation=(_address_validation); end
        # Customs information for the shipment.
        sig { returns(T.nilable(Issuing::CardUpdateParams::Shipping::Customs)) }
        def customs; end
        sig {
          params(_customs: T.nilable(Issuing::CardUpdateParams::Shipping::Customs)).returns(T.nilable(Issuing::CardUpdateParams::Shipping::Customs))
         }
        def customs=(_customs); end
        # The name printed on the shipping label when shipping the card.
        sig { returns(String) }
        def name; end
        sig { params(_name: String).returns(String) }
        def name=(_name); end
        # Phone number of the recipient of the shipment.
        sig { returns(T.nilable(String)) }
        def phone_number; end
        sig { params(_phone_number: T.nilable(String)).returns(T.nilable(String)) }
        def phone_number=(_phone_number); end
        # Whether a signature is required for card delivery.
        sig { returns(T.nilable(T::Boolean)) }
        def require_signature; end
        sig { params(_require_signature: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def require_signature=(_require_signature); end
        # Shipment service.
        sig { returns(T.nilable(String)) }
        def service; end
        sig { params(_service: T.nilable(String)).returns(T.nilable(String)) }
        def service=(_service); end
        # Packaging options.
        sig { returns(T.nilable(String)) }
        def type; end
        sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
        def type=(_type); end
        sig {
          params(address: Issuing::CardUpdateParams::Shipping::Address, address_validation: T.nilable(Issuing::CardUpdateParams::Shipping::AddressValidation), customs: T.nilable(Issuing::CardUpdateParams::Shipping::Customs), name: String, phone_number: T.nilable(String), require_signature: T.nilable(T::Boolean), service: T.nilable(String), type: T.nilable(String)).void
         }
        def initialize(
          address: nil,
          address_validation: nil,
          customs: nil,
          name: nil,
          phone_number: nil,
          require_signature: nil,
          service: nil,
          type: nil
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
        # Limit spending with amount-based rules that apply across any cards this card replaced (i.e., its `replacement_for` card and _that_ card's `replacement_for` card, up the chain).
        sig {
          returns(T.nilable(T::Array[Issuing::CardUpdateParams::SpendingControls::SpendingLimit]))
         }
        def spending_limits; end
        sig {
          params(_spending_limits: T.nilable(T::Array[Issuing::CardUpdateParams::SpendingControls::SpendingLimit])).returns(T.nilable(T::Array[Issuing::CardUpdateParams::SpendingControls::SpendingLimit]))
         }
        def spending_limits=(_spending_limits); end
        sig {
          params(allowed_categories: T.nilable(T::Array[String]), allowed_merchant_countries: T.nilable(T::Array[String]), blocked_categories: T.nilable(T::Array[String]), blocked_merchant_countries: T.nilable(T::Array[String]), spending_limits: T.nilable(T::Array[Issuing::CardUpdateParams::SpendingControls::SpendingLimit])).void
         }
        def initialize(
          allowed_categories: nil,
          allowed_merchant_countries: nil,
          blocked_categories: nil,
          blocked_merchant_countries: nil,
          spending_limits: nil
        ); end
      end
      # Reason why the `status` of this card is `canceled`.
      sig { returns(T.nilable(String)) }
      def cancellation_reason; end
      sig { params(_cancellation_reason: T.nilable(String)).returns(T.nilable(String)) }
      def cancellation_reason=(_cancellation_reason); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
       }
      def metadata=(_metadata); end
      # Attribute for param field personalization_design
      sig { returns(T.nilable(String)) }
      def personalization_design; end
      sig { params(_personalization_design: T.nilable(String)).returns(T.nilable(String)) }
      def personalization_design=(_personalization_design); end
      # The desired new PIN for this card.
      sig { returns(T.nilable(Issuing::CardUpdateParams::Pin)) }
      def pin; end
      sig {
        params(_pin: T.nilable(Issuing::CardUpdateParams::Pin)).returns(T.nilable(Issuing::CardUpdateParams::Pin))
       }
      def pin=(_pin); end
      # Updated shipping information for the card.
      sig { returns(T.nilable(Issuing::CardUpdateParams::Shipping)) }
      def shipping; end
      sig {
        params(_shipping: T.nilable(Issuing::CardUpdateParams::Shipping)).returns(T.nilable(Issuing::CardUpdateParams::Shipping))
       }
      def shipping=(_shipping); end
      # Rules that control spending for this card. Refer to our [documentation](https://docs.stripe.com/issuing/controls/spending-controls) for more details.
      sig { returns(T.nilable(Issuing::CardUpdateParams::SpendingControls)) }
      def spending_controls; end
      sig {
        params(_spending_controls: T.nilable(Issuing::CardUpdateParams::SpendingControls)).returns(T.nilable(Issuing::CardUpdateParams::SpendingControls))
       }
      def spending_controls=(_spending_controls); end
      # Dictates whether authorizations can be approved on this card. May be blocked from activating cards depending on past-due Cardholder requirements. Defaults to `inactive`. If this card is being canceled because it was lost or stolen, this information should be provided as `cancellation_reason`.
      sig { returns(T.nilable(String)) }
      def status; end
      sig { params(_status: T.nilable(String)).returns(T.nilable(String)) }
      def status=(_status); end
      sig {
        params(cancellation_reason: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), personalization_design: T.nilable(String), pin: T.nilable(Issuing::CardUpdateParams::Pin), shipping: T.nilable(Issuing::CardUpdateParams::Shipping), spending_controls: T.nilable(Issuing::CardUpdateParams::SpendingControls), status: T.nilable(String)).void
       }
      def initialize(
        cancellation_reason: nil,
        expand: nil,
        metadata: nil,
        personalization_design: nil,
        pin: nil,
        shipping: nil,
        spending_controls: nil,
        status: nil
      ); end
    end
  end
end