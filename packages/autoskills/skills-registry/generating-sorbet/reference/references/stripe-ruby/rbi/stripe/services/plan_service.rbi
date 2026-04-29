# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PlanService < StripeService
    # You can now model subscriptions more flexibly using the [Prices API](https://docs.stripe.com/api#prices). It replaces the Plans API and is backwards compatible to simplify your migration.
    sig {
      params(params: T.any(::Stripe::PlanCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Plan)
     }
    def create(params = {}, opts = {}); end

    # Deleting plans means new subscribers can't be added. Existing subscribers aren't affected.
    sig {
      params(plan: String, params: T.any(::Stripe::PlanDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Plan)
     }
    def delete(plan, params = {}, opts = {}); end

    # Returns a list of your plans.
    sig {
      params(params: T.any(::Stripe::PlanListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the plan with the given ID.
    sig {
      params(plan: String, params: T.any(::Stripe::PlanRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Plan)
     }
    def retrieve(plan, params = {}, opts = {}); end

    # Updates the specified plan by setting the values of the parameters passed. Any parameters not provided are left unchanged. By design, you cannot change a plan's ID, amount, currency, or billing cycle.
    sig {
      params(plan: String, params: T.any(::Stripe::PlanUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Plan)
     }
    def update(plan, params = {}, opts = {}); end
  end
end