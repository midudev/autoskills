# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class CardService < StripeService
      # Creates an Issuing Card object.
      sig {
        params(params: T.any(::Stripe::Issuing::CardCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of Issuing Card objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::CardListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves an Issuing Card object.
      sig {
        params(card: String, params: T.any(::Stripe::Issuing::CardRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
       }
      def retrieve(card, params = {}, opts = {}); end

      # Updates the specified Issuing Card object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
      sig {
        params(card: String, params: T.any(::Stripe::Issuing::CardUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Card)
       }
      def update(card, params = {}, opts = {}); end
    end
  end
end