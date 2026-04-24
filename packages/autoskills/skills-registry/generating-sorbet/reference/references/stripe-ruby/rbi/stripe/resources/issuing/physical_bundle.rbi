# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    # A Physical Bundle represents the bundle of physical items - card stock, carrier letter, and envelope - that is shipped to a cardholder when you create a physical card.
    class PhysicalBundle < APIResource
      class Features < ::Stripe::StripeObject
        # The policy for how to use card logo images in a card design with this physical bundle.
        sig { returns(String) }
        def card_logo; end
        # The policy for how to use carrier letter text in a card design with this physical bundle.
        sig { returns(String) }
        def carrier_text; end
        # The policy for how to use a second line on a card with this physical bundle.
        sig { returns(String) }
        def second_line; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field features
      sig { returns(Features) }
      def features; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Friendly display name.
      sig { returns(String) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Whether this physical bundle can be used to create cards.
      sig { returns(String) }
      def status; end
      # Whether this physical bundle is a standard Stripe offering or custom-made for you.
      sig { returns(String) }
      def type; end
      # Returns a list of physical bundle objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::PhysicalBundleListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end