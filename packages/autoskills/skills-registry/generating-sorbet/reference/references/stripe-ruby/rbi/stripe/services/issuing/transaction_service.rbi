# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class TransactionService < StripeService
      # Returns a list of Issuing Transaction objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Issuing::TransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves an Issuing Transaction object.
      sig {
        params(transaction: String, params: T.any(::Stripe::Issuing::TransactionRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Transaction)
       }
      def retrieve(transaction, params = {}, opts = {}); end

      # Updates the specified Issuing Transaction object by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
      sig {
        params(transaction: String, params: T.any(::Stripe::Issuing::TransactionUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Transaction)
       }
      def update(transaction, params = {}, opts = {}); end
    end
  end
end