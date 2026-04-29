# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionItemService < StripeService
    # Adds a new item to an existing subscription. No existing items will be changed or replaced.
    sig {
      params(params: T.any(::Stripe::SubscriptionItemCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionItem)
     }
    def create(params = {}, opts = {}); end

    # Deletes an item from the subscription. Removing a subscription item from a subscription will not cancel the subscription.
    sig {
      params(item: String, params: T.any(::Stripe::SubscriptionItemDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionItem)
     }
    def delete(item, params = {}, opts = {}); end

    # Returns a list of your subscription items for a given subscription.
    sig {
      params(params: T.any(::Stripe::SubscriptionItemListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the subscription item with the given ID.
    sig {
      params(item: String, params: T.any(::Stripe::SubscriptionItemRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionItem)
     }
    def retrieve(item, params = {}, opts = {}); end

    # Updates the plan or quantity of an item on a current subscription.
    sig {
      params(item: String, params: T.any(::Stripe::SubscriptionItemUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionItem)
     }
    def update(item, params = {}, opts = {}); end
  end
end