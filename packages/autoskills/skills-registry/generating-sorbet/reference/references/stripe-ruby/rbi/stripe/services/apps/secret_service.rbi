# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Apps
    class SecretService < StripeService
      # Create or replace a secret in the secret store.
      sig {
        params(params: T.any(::Stripe::Apps::SecretCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Apps::Secret)
       }
      def create(params = {}, opts = {}); end

      # Deletes a secret from the secret store by name and scope.
      sig {
        params(params: T.any(::Stripe::Apps::SecretDeleteWhereParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Apps::Secret)
       }
      def delete_where(params = {}, opts = {}); end

      # Finds a secret in the secret store by name and scope.
      sig {
        params(params: T.any(::Stripe::Apps::SecretFindParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Apps::Secret)
       }
      def find(params = {}, opts = {}); end

      # List all secrets stored on the given scope.
      sig {
        params(params: T.any(::Stripe::Apps::SecretListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end
    end
  end
end