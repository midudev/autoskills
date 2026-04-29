# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Radar
    class ValueListItemService < StripeService
      # Creates a new ValueListItem object, which is added to the specified parent value list.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListItemCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueListItem)
       }
      def create(params = {}, opts = {}); end

      # Deletes a ValueListItem object, removing it from its parent value list.
      sig {
        params(item: String, params: T.any(::Stripe::Radar::ValueListItemDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueListItem)
       }
      def delete(item, params = {}, opts = {}); end

      # Returns a list of ValueListItem objects. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
      sig {
        params(params: T.any(::Stripe::Radar::ValueListItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a ValueListItem object.
      sig {
        params(item: String, params: T.any(::Stripe::Radar::ValueListItemRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Radar::ValueListItem)
       }
      def retrieve(item, params = {}, opts = {}); end
    end
  end
end