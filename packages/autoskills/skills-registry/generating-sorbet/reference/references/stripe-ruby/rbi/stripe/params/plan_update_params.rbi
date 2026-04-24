# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PlanUpdateParams < ::Stripe::RequestParams
    # Whether the plan is currently available for new subscriptions.
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # A brief description of the plan, hidden from customers.
    sig { returns(T.nilable(String)) }
    def nickname; end
    sig { params(_nickname: T.nilable(String)).returns(T.nilable(String)) }
    def nickname=(_nickname); end
    # The product the plan belongs to. This cannot be changed once it has been used in a subscription or subscription schedule.
    sig { returns(T.nilable(String)) }
    def product; end
    sig { params(_product: T.nilable(String)).returns(T.nilable(String)) }
    def product=(_product); end
    # Default number of trial days when subscribing a customer to this plan using [`trial_from_plan=true`](https://docs.stripe.com/api#create_subscription-trial_from_plan).
    sig { returns(T.nilable(Integer)) }
    def trial_period_days; end
    sig { params(_trial_period_days: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def trial_period_days=(_trial_period_days); end
    sig {
      params(active: T.nilable(T::Boolean), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), nickname: T.nilable(String), product: T.nilable(String), trial_period_days: T.nilable(Integer)).void
     }
    def initialize(
      active: nil,
      expand: nil,
      metadata: nil,
      nickname: nil,
      product: nil,
      trial_period_days: nil
    ); end
  end
end