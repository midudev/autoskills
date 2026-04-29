# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Radar
    class ValueListService < StripeService
      # Creates a new ValueList object, which can then be referenced in rules.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueList)
       }
      def create(params = {}, opts = {}); end

      # Deletes a ValueList object, also deleting any items contained within the value list. To be deleted, a value list must not be referenced in any rules.
      sig {
        params(value_list: String, params: T.any(::Stripe::Radar::ValueListDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueList)
       }
      def delete(value_list, params = {}, opts = {}); end

      # Returns a list of ValueList objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a ValueList object.
      sig {
        params(value_list: String, params: T.any(::Stripe::Radar::ValueListRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueList)
       }
      def retrieve(value_list, params = {}, opts = {}); end

      # Updates a ValueList object by setting the values of the parameters passed. Any parameters not provided will be left unchanged. Note that item_type is immutable.
      sig {
        params(value_list: String, params: T.any(::Stripe::Radar::ValueListUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueList)
       }
      def update(value_list, params = {}, opts = {}); end
    end
  end
end