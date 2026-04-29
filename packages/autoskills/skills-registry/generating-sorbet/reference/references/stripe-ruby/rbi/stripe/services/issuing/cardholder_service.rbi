# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class CardholderService < StripeService
      # Creates a new Issuing Cardholder object that can be issued cards.
      sig {
        params(params: T.any(::Stripe::Issuing::CardholderCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Cardholder)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of Issuing Cardholder objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::CardholderListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves an Issuing Cardholder object.
      sig {
        params(cardholder: String, params: T.any(::Stripe::Issuing::CardholderRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Cardholder)
       }
      def retrieve(cardholder, params = {}, opts = {}); end

      # Updates the specified Issuing Cardholder object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
      sig {
        params(cardholder: String, params: T.any(::Stripe::Issuing::CardholderUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Cardholder)
       }
      def update(cardholder, params = {}, opts = {}); end
    end
  end
end