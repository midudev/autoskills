# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionResumeParams < ::Stripe::RequestParams
    # The billing cycle anchor that applies when the subscription is resumed. Either `now` or `unchanged`. The default is `now`. For more information, see the billing cycle [documentation](https://docs.stripe.com/billing/subscriptions/billing-cycle).
    sig { returns(T.nilable(String)) }
    def billing_cycle_anchor; end
    sig { params(_billing_cycle_anchor: T.nilable(String)).returns(T.nilable(String)) }
    def billing_cycle_anchor=(_billing_cycle_anchor); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Determines how to handle [prorations](https://docs.stripe.com/billing/subscriptions/prorations) resulting from the `billing_cycle_anchor` being `unchanged`. When the `billing_cycle_anchor` is set to `now` (default value), no prorations are generated. If no value is passed, the default is `create_prorations`.
    sig { returns(T.nilable(String)) }
    def proration_behavior; end
    sig { params(_proration_behavior: T.nilable(String)).returns(T.nilable(String)) }
    def proration_behavior=(_proration_behavior); end
    # If set, prorations will be calculated as though the subscription was resumed at the given time. This can be used to apply exactly the same prorations that were previewed with the [create preview](https://stripe.com/docs/api/invoices/create_preview) endpoint.
    sig { returns(T.nilable(Integer)) }
    def proration_date; end
    sig { params(_proration_date: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def proration_date=(_proration_date); end
    sig {
      params(billing_cycle_anchor: T.nilable(String), expand: T.nilable(T::Array[String]), proration_behavior: T.nilable(String), proration_date: T.nilable(Integer)).void
     }
    def initialize(
      billing_cycle_anchor: nil,
      expand: nil,
      proration_behavior: nil,
      proration_date: nil
    ); end
  end
end