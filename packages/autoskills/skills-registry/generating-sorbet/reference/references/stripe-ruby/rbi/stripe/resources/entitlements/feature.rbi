# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Entitlements
    # A feature represents a monetizable ability or functionality in your system.
    # Features can be assigned to products, and when those products are purchased, Stripe will create an entitlement to the feature for the purchasing customer.
    class Feature < APIResource
      # Inactive features cannot be attached to new products and will not be returned from the features list endpoint.
      sig { returns(T::Boolean) }
      def active; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # A unique key you provide as your own system identifier. This may be up to 80 characters.
      sig { returns(String) }
      def lookup_key; end
      # Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # The feature's name, for your own purpose, not meant to be displayable to the customer.
      sig { returns(String) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Creates a feature
      sig {
        params(params: T.any(::Stripe::Entitlements::FeatureCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Entitlements::Feature)
       }
      def self.create(params = {}, opts = {}); end

      # Retrieve a list of features
      sig {
        params(params: T.any(::Stripe::Entitlements::FeatureListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Update a feature's metadata or permanently deactivate it.
      sig {
        params(id: String, params: T.any(::Stripe::Entitlements::FeatureUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Entitlements::Feature)
       }
      def self.update(id, params = {}, opts = {}); end
    end
  end
end