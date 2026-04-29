# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    # A Location represents a grouping of readers.
    #
    # Related guide: [Fleet management](https://docs.stripe.com/terminal/fleet/locations)
    class Location < APIResource
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
      class AddressKana < ::Stripe::StripeObject
        # City/Ward.
        sig { returns(T.nilable(String)) }
        def city; end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        # Block/Building number.
        sig { returns(T.nilable(String)) }
        def line1; end
        # Building details.
        sig { returns(T.nilable(String)) }
        def line2; end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        # Prefecture.
        sig { returns(T.nilable(String)) }
        def state; end
        # Town/cho-me.
        sig { returns(T.nilable(String)) }
        def town; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AddressKanji < ::Stripe::StripeObject
        # City/Ward.
        sig { returns(T.nilable(String)) }
        def city; end
        # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
        sig { returns(T.nilable(String)) }
        def country; end
        # Block/Building number.
        sig { returns(T.nilable(String)) }
        def line1; end
        # Building details.
        sig { returns(T.nilable(String)) }
        def line2; end
        # ZIP or postal code.
        sig { returns(T.nilable(String)) }
        def postal_code; end
        # Prefecture.
        sig { returns(T.nilable(String)) }
        def state; end
        # Town/cho-me.
        sig { returns(T.nilable(String)) }
        def town; end
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
      # Attribute for field address_kana
      sig { returns(T.nilable(AddressKana)) }
      def address_kana; end
      # Attribute for field address_kanji
      sig { returns(T.nilable(AddressKanji)) }
      def address_kanji; end
      # The ID of a configuration that will be used to customize all readers in this location.
      sig { returns(T.nilable(String)) }
      def configuration_overrides; end
      # The display name of the location.
      sig { returns(String) }
      def display_name; end
      # The Kana variation of the display name of the location.
      sig { returns(T.nilable(String)) }
      def display_name_kana; end
      # The Kanji variation of the display name of the location.
      sig { returns(T.nilable(String)) }
      def display_name_kanji; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The phone number of the location.
      sig { returns(T.nilable(String)) }
      def phone; end
      # Always true for a deleted object
      sig { returns(T.nilable(T::Boolean)) }
      def deleted; end
      # Creates a new Location object.
      # For further details, including which address fields are required in each country, see the [Manage locations](https://docs.stripe.com/docs/terminal/fleet/locations) guide.
      sig {
        params(params: T.any(::Stripe::Terminal::LocationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Location)
       }
      def self.create(params = {}, opts = {}); end

      # Deletes a Location object.
      sig {
        params(location: String, params: T.any(::Stripe::Terminal::LocationDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Location)
       }
      def self.delete(location, params = {}, opts = {}); end

      # Deletes a Location object.
      sig {
        params(params: T.any(::Stripe::Terminal::LocationDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Location)
       }
      def delete(params = {}, opts = {}); end

      # Returns a list of Location objects.
      sig {
        params(params: T.any(::Stripe::Terminal::LocationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates a Location object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
      sig {
        params(location: String, params: T.any(::Stripe::Terminal::LocationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Location)
       }
      def self.update(location, params = {}, opts = {}); end
    end
  end
end