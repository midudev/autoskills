# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    # A Personalization Design is a logical grouping of a Physical Bundle, card logo, and carrier text that represents a product line.
    class PersonalizationDesign < APIResource
      class CarrierText < ::Stripe::StripeObject
        # The footer body text of the carrier letter.
        sig { returns(T.nilable(String)) }
        def footer_body; end
        # The footer title text of the carrier letter.
        sig { returns(T.nilable(String)) }
        def footer_title; end
        # The header body text of the carrier letter.
        sig { returns(T.nilable(String)) }
        def header_body; end
        # The header title text of the carrier letter.
        sig { returns(T.nilable(String)) }
        def header_title; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Preferences < ::Stripe::StripeObject
        # Whether we use this personalization design to create cards when one isn't specified. A connected account uses the Connect platform's default design if no personalization design is set as the default design.
        sig { returns(T::Boolean) }
        def is_default; end
        # Whether this personalization design is used to create cards when one is not specified and a default for this connected account does not exist.
        sig { returns(T.nilable(T::Boolean)) }
        def is_platform_default; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RejectionReasons < ::Stripe::StripeObject
        # The reason(s) the card logo was rejected.
        sig { returns(T.nilable(T::Array[String])) }
        def card_logo; end
        # The reason(s) the carrier text was rejected.
        sig { returns(T.nilable(T::Array[String])) }
        def carrier_text; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The file for the card logo to use with physical bundles that support card logos. Must have a `purpose` value of `issuing_logo`.
      sig { returns(T.nilable(T.any(String, ::Stripe::File))) }
      def card_logo; end
      # Hash containing carrier text, for use with physical bundles that support carrier text.
      sig { returns(T.nilable(CarrierText)) }
      def carrier_text; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # A lookup key used to retrieve personalization designs dynamically from a static string. This may be up to 200 characters.
      sig { returns(T.nilable(String)) }
      def lookup_key; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # Friendly display name.
      sig { returns(T.nilable(String)) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The physical bundle object belonging to this personalization design.
      sig { returns(T.any(String, ::Stripe::Issuing::PhysicalBundle)) }
      def physical_bundle; end
      # Attribute for field preferences
      sig { returns(Preferences) }
      def preferences; end
      # Attribute for field rejection_reasons
      sig { returns(RejectionReasons) }
      def rejection_reasons; end
      # Whether this personalization design can be used to create cards.
      sig { returns(String) }
      def status; end
      # Creates a personalization design object.
      sig {
        params(params: T.any(::Stripe::Issuing::PersonalizationDesignCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::PersonalizationDesign)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of personalization design objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::PersonalizationDesignListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates a card personalization object.
      sig {
        params(personalization_design: String, params: T.any(::Stripe::Issuing::PersonalizationDesignUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::PersonalizationDesign)
       }
      def self.update(personalization_design, params = {}, opts = {}); end
    end
  end
end