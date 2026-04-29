# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class PersonalizationDesignCreateParams < ::Stripe::RequestParams
      class CarrierText < ::Stripe::RequestParams
        # The footer body text of the carrier letter.
        sig { returns(T.nilable(String)) }
        def footer_body; end
        sig { params(_footer_body: T.nilable(String)).returns(T.nilable(String)) }
        def footer_body=(_footer_body); end
        # The footer title text of the carrier letter.
        sig { returns(T.nilable(String)) }
        def footer_title; end
        sig { params(_footer_title: T.nilable(String)).returns(T.nilable(String)) }
        def footer_title=(_footer_title); end
        # The header body text of the carrier letter.
        sig { returns(T.nilable(String)) }
        def header_body; end
        sig { params(_header_body: T.nilable(String)).returns(T.nilable(String)) }
        def header_body=(_header_body); end
        # The header title text of the carrier letter.
        sig { returns(T.nilable(String)) }
        def header_title; end
        sig { params(_header_title: T.nilable(String)).returns(T.nilable(String)) }
        def header_title=(_header_title); end
        sig {
          params(footer_body: T.nilable(String), footer_title: T.nilable(String), header_body: T.nilable(String), header_title: T.nilable(String)).void
         }
        def initialize(
          footer_body: nil,
          footer_title: nil,
          header_body: nil,
          header_title: nil
        ); end
      end
      class Preferences < ::Stripe::RequestParams
        # Whether we use this personalization design to create cards when one isn't specified. A connected account uses the Connect platform's default design if no personalization design is set as the default design.
        sig { returns(T::Boolean) }
        def is_default; end
        sig { params(_is_default: T::Boolean).returns(T::Boolean) }
        def is_default=(_is_default); end
        sig { params(is_default: T::Boolean).void }
        def initialize(is_default: nil); end
      end
      # The file for the card logo, for use with physical bundles that support card logos. Must have a `purpose` value of `issuing_logo`.
      sig { returns(T.nilable(String)) }
      def card_logo; end
      sig { params(_card_logo: T.nilable(String)).returns(T.nilable(String)) }
      def card_logo=(_card_logo); end
      # Hash containing carrier text, for use with physical bundles that support carrier text.
      sig { returns(T.nilable(Issuing::PersonalizationDesignCreateParams::CarrierText)) }
      def carrier_text; end
      sig {
        params(_carrier_text: T.nilable(Issuing::PersonalizationDesignCreateParams::CarrierText)).returns(T.nilable(Issuing::PersonalizationDesignCreateParams::CarrierText))
       }
      def carrier_text=(_carrier_text); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A lookup key used to retrieve personalization designs dynamically from a static string. This may be up to 200 characters.
      sig { returns(T.nilable(String)) }
      def lookup_key; end
      sig { params(_lookup_key: T.nilable(String)).returns(T.nilable(String)) }
      def lookup_key=(_lookup_key); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # Friendly display name.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # The physical bundle object belonging to this personalization design.
      sig { returns(String) }
      def physical_bundle; end
      sig { params(_physical_bundle: String).returns(String) }
      def physical_bundle=(_physical_bundle); end
      # Information on whether this personalization design is used to create cards when one is not specified.
      sig { returns(T.nilable(Issuing::PersonalizationDesignCreateParams::Preferences)) }
      def preferences; end
      sig {
        params(_preferences: T.nilable(Issuing::PersonalizationDesignCreateParams::Preferences)).returns(T.nilable(Issuing::PersonalizationDesignCreateParams::Preferences))
       }
      def preferences=(_preferences); end
      # If set to true, will atomically remove the lookup key from the existing personalization design, and assign it to this personalization design.
      sig { returns(T.nilable(T::Boolean)) }
      def transfer_lookup_key; end
      sig { params(_transfer_lookup_key: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def transfer_lookup_key=(_transfer_lookup_key); end
      sig {
        params(card_logo: T.nilable(String), carrier_text: T.nilable(Issuing::PersonalizationDesignCreateParams::CarrierText), expand: T.nilable(T::Array[String]), lookup_key: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), name: T.nilable(String), physical_bundle: String, preferences: T.nilable(Issuing::PersonalizationDesignCreateParams::Preferences), transfer_lookup_key: T.nilable(T::Boolean)).void
       }
      def initialize(
        card_logo: nil,
        carrier_text: nil,
        expand: nil,
        lookup_key: nil,
        metadata: nil,
        name: nil,
        physical_bundle: nil,
        preferences: nil,
        transfer_lookup_key: nil
      ); end
    end
  end
end