# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class LocationCreateParams < ::Stripe::RequestParams
      class Address < ::Stripe::RequestParams
        # City, district, suburb, town, or village.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(String) }
        def country; end
        sig { params(_country: String).returns(String) }
        def country=(_country); end
        # Address line 1, such as the street, PO Box, or company name.
        sig { returns(T.nilable(String)) }
        def line1; end
        sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
        def line1=(_line1); end
        # Address line 2, such as the apartment, suite, unit, or building.
        sig { returns(T.nilable(String)) }
        def line2; end
        sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
        def line2=(_line2); end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def postal_code=(_postal_code); end
        # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        sig {
          params(city: T.nilable(String), country: String, line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String)).void
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
      class AddressKana < ::Stripe::RequestParams
        # City or ward.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
        def country=(_country); end
        # Block or building number.
        sig { returns(T.nilable(String)) }
        def line1; end
        sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
        def line1=(_line1); end
        # Building details.
        sig { returns(T.nilable(String)) }
        def line2; end
        sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
        def line2=(_line2); end
        # Postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def postal_code=(_postal_code); end
        # Prefecture.
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        # Town or cho-me.
        sig { returns(T.nilable(String)) }
        def town; end
        sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
        def town=(_town); end
        sig {
          params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
         }
        def initialize(
          city: nil,
          country: nil,
          line1: nil,
          line2: nil,
          postal_code: nil,
          state: nil,
          town: nil
        ); end
      end
      class AddressKanji < ::Stripe::RequestParams
        # City or ward.
        sig { returns(T.nilable(String)) }
        def city; end
        sig { params(_city: T.nilable(String)).returns(T.nilable(String)) }
        def city=(_city); end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        sig { params(_country: T.nilable(String)).returns(T.nilable(String)) }
        def country=(_country); end
        # Block or building number.
        sig { returns(T.nilable(String)) }
        def line1; end
        sig { params(_line1: T.nilable(String)).returns(T.nilable(String)) }
        def line1=(_line1); end
        # Building details.
        sig { returns(T.nilable(String)) }
        def line2; end
        sig { params(_line2: T.nilable(String)).returns(T.nilable(String)) }
        def line2=(_line2); end
        # Postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        sig { params(_postal_code: T.nilable(String)).returns(T.nilable(String)) }
        def postal_code=(_postal_code); end
        # Prefecture.
        sig { returns(T.nilable(String)) }
        def state; end
        sig { params(_state: T.nilable(String)).returns(T.nilable(String)) }
        def state=(_state); end
        # Town or cho-me.
        sig { returns(T.nilable(String)) }
        def town; end
        sig { params(_town: T.nilable(String)).returns(T.nilable(String)) }
        def town=(_town); end
        sig {
          params(city: T.nilable(String), country: T.nilable(String), line1: T.nilable(String), line2: T.nilable(String), postal_code: T.nilable(String), state: T.nilable(String), town: T.nilable(String)).void
         }
        def initialize(
          city: nil,
          country: nil,
          line1: nil,
          line2: nil,
          postal_code: nil,
          state: nil,
          town: nil
        ); end
      end
      # The full address of the location.
      sig { returns(T.nilable(Terminal::LocationCreateParams::Address)) }
      def address; end
      sig {
        params(_address: T.nilable(Terminal::LocationCreateParams::Address)).returns(T.nilable(Terminal::LocationCreateParams::Address))
       }
      def address=(_address); end
      # The Kana variation of the full address of the location (Japan only).
      sig { returns(T.nilable(Terminal::LocationCreateParams::AddressKana)) }
      def address_kana; end
      sig {
        params(_address_kana: T.nilable(Terminal::LocationCreateParams::AddressKana)).returns(T.nilable(Terminal::LocationCreateParams::AddressKana))
       }
      def address_kana=(_address_kana); end
      # The Kanji variation of the full address of the location (Japan only).
      sig { returns(T.nilable(Terminal::LocationCreateParams::AddressKanji)) }
      def address_kanji; end
      sig {
        params(_address_kanji: T.nilable(Terminal::LocationCreateParams::AddressKanji)).returns(T.nilable(Terminal::LocationCreateParams::AddressKanji))
       }
      def address_kanji=(_address_kanji); end
      # The ID of a configuration that will be used to customize all readers in this location.
      sig { returns(T.nilable(String)) }
      def configuration_overrides; end
      sig { params(_configuration_overrides: T.nilable(String)).returns(T.nilable(String)) }
      def configuration_overrides=(_configuration_overrides); end
      # A name for the location. Maximum length is 1000 characters.
      sig { returns(T.nilable(String)) }
      def display_name; end
      sig { params(_display_name: T.nilable(String)).returns(T.nilable(String)) }
      def display_name=(_display_name); end
      # The Kana variation of the name for the location (Japan only). Maximum length is 1000 characters.
      sig { returns(T.nilable(String)) }
      def display_name_kana; end
      sig { params(_display_name_kana: T.nilable(String)).returns(T.nilable(String)) }
      def display_name_kana=(_display_name_kana); end
      # The Kanji variation of the name for the location (Japan only). Maximum length is 1000 characters.
      sig { returns(T.nilable(String)) }
      def display_name_kanji; end
      sig { params(_display_name_kanji: T.nilable(String)).returns(T.nilable(String)) }
      def display_name_kanji=(_display_name_kanji); end
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
      # The phone number for the location.
      sig { returns(T.nilable(String)) }
      def phone; end
      sig { params(_phone: T.nilable(String)).returns(T.nilable(String)) }
      def phone=(_phone); end
      sig {
        params(address: T.nilable(Terminal::LocationCreateParams::Address), address_kana: T.nilable(Terminal::LocationCreateParams::AddressKana), address_kanji: T.nilable(Terminal::LocationCreateParams::AddressKanji), configuration_overrides: T.nilable(String), display_name: T.nilable(String), display_name_kana: T.nilable(String), display_name_kanji: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), phone: T.nilable(String)).void
       }
      def initialize(
        address: nil,
        address_kana: nil,
        address_kanji: nil,
        configuration_overrides: nil,
        display_name: nil,
        display_name_kana: nil,
        display_name_kanji: nil,
        expand: nil,
        metadata: nil,
        phone: nil
      ); end
    end
  end
end