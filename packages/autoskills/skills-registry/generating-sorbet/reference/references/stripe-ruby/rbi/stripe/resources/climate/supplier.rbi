# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Climate
    # A supplier of carbon removal.
    class Supplier < APIResource
      class Location < ::Stripe::StripeObject
        # The city where the supplier is located.
        sig { returns(T.nilable(String)) }
        def city; end
        # Two-letter ISO code representing the country where the supplier is located.
        sig { returns(String) }
        def country; end
        # The geographic latitude where the supplier is located.
        sig { returns(T.nilable(Float)) }
        def latitude; end
        # The geographic longitude where the supplier is located.
        sig { returns(T.nilable(Float)) }
        def longitude; end
        # The state/county/province/region where the supplier is located.
        sig { returns(T.nilable(String)) }
        def region; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Link to a webpage to learn more about the supplier.
      sig { returns(String) }
      def info_url; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The locations in which this supplier operates.
      sig { returns(T::Array[Location]) }
      def locations; end
      # Name of this carbon removal supplier.
      sig { returns(String) }
      def name; end
      # String representing the object’s type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The scientific pathway used for carbon removal.
      sig { returns(String) }
      def removal_pathway; end
      # Lists all available Climate supplier objects.
      sig {
        params(params: T.any(::Stripe::Climate::SupplierListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end