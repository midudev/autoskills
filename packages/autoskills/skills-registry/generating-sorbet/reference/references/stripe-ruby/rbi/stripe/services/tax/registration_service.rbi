# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class RegistrationService < StripeService
      # Creates a new Tax Registration object.
      sig {
        params(params: T.any(::Stripe::Tax::RegistrationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Registration)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of Tax Registration objects.
      sig {
        params(params: T.any(::Stripe::Tax::RegistrationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Returns a Tax Registration object.
      sig {
        params(id: String, params: T.any(::Stripe::Tax::RegistrationRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Registration)
       }
      def retrieve(id, params = {}, opts = {}); end

      # Updates an existing Tax Registration object.
      #
      # A registration cannot be deleted after it has been created. If you wish to end a registration you may do so by setting expires_at.
      sig {
        params(id: String, params: T.any(::Stripe::Tax::RegistrationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Registration)
       }
      def update(id, params = {}, opts = {}); end
    end
  end
end