# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ConfigurationService < StripeService
      # Creates a new Configuration object.
      sig {
        params(params: T.any(::Stripe::Terminal::ConfigurationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Configuration)
       }
      def create(params = {}, opts = {}); end

      # Deletes a Configuration object.
      sig {
        params(configuration: String, params: T.any(::Stripe::Terminal::ConfigurationDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Configuration)
       }
      def delete(configuration, params = {}, opts = {}); end

      # Returns a list of Configuration objects.
      sig {
        params(params: T.any(::Stripe::Terminal::ConfigurationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a Configuration object.
      sig {
        params(configuration: String, params: T.any(::Stripe::Terminal::ConfigurationRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Configuration)
       }
      def retrieve(configuration, params = {}, opts = {}); end

      # Updates a new Configuration object.
      sig {
        params(configuration: String, params: T.any(::Stripe::Terminal::ConfigurationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Configuration)
       }
      def update(configuration, params = {}, opts = {}); end
    end
  end
end