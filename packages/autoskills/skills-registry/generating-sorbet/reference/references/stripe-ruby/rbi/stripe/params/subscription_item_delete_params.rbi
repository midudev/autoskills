# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionItemDeleteParams < ::Stripe::RequestParams
    # Delete all usage for the given subscription item. Allowed only when the current plan's `usage_type` is `metered`.
    sig { returns(T.nilable(T::Boolean)) }
    def clear_usage; end
    sig { params(_clear_usage: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def clear_usage=(_clear_usage); end
    # Determines how to handle [prorations](https://docs.stripe.com/billing/subscriptions/prorations) when the billing cycle changes (e.g., when switching plans, resetting `billing_cycle_anchor=now`, or starting a trial), or if an item's `quantity` changes. The default value is `create_prorations`.
    sig { returns(T.nilable(String)) }
    def proration_behavior; end
    sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def proration_behavior=(_proration_behavior); end
    # If set, the proration will be calculated as though the subscription was updated at the given time. This can be used to apply the same proration that was previewed with the [upcoming invoice](https://api.stripe.com#retrieve_customer_invoice) endpoint.
    sig { returns(T.nilable(Integer)) }
    def proration_date; end
    sig { params(_proration_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def proration_date=(_proration_date); end
    sig {
      params(clear_usage: T.nilable(T::Boolean), proration_behavior: T.nilable(String), proration_date: T.nilable(Integer)).void
     }
    def initialize(clear_usage: nil, proration_behavior: nil, proration_date: nil); end
  end
end