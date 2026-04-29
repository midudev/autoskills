# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionScheduleService < StripeService
    # Cancels a subscription schedule and its associated subscription immediately (if the subscription schedule has an active subscription). A subscription schedule can only be canceled if its status is not_started or active.
    sig {
      params(schedule: String, params: T.any(::Stripe::SubscriptionScheduleCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionSchedule)
     }
    def cancel(schedule, params = {}, opts = {}); end

    # Creates a new subscription schedule object. Each customer can have up to 500 active or scheduled subscriptions.
    sig {
      params(params: T.any(::Stripe::SubscriptionScheduleCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionSchedule)
     }
    def create(params = {}, opts = {}); end

    # Retrieves the list of your subscription schedules.
    sig {
      params(params: T.any(::Stripe::SubscriptionScheduleListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Releases the subscription schedule immediately, which will stop scheduling of its phases, but leave any existing subscription in place. A schedule can only be released if its status is not_started or active. If the subscription schedule is currently associated with a subscription, releasing it will remove its subscription property and set the subscription's ID to the released_subscription property.
    sig {
      params(schedule: String, params: T.any(::Stripe::SubscriptionScheduleReleaseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionSchedule)
     }
    def release(schedule, params = {}, opts = {}); end

    # Retrieves the details of an existing subscription schedule. You only need to supply the unique subscription schedule identifier that was returned upon subscription schedule creation.
    sig {
      params(schedule: String, params: T.any(::Stripe::SubscriptionScheduleRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionSchedule)
     }
    def retrieve(schedule, params = {}, opts = {}); end

    # Updates an existing subscription schedule.
    sig {
      params(schedule: String, params: T.any(::Stripe::SubscriptionScheduleUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SubscriptionSchedule)
     }
    def update(schedule, params = {}, opts = {}); end
  end
end