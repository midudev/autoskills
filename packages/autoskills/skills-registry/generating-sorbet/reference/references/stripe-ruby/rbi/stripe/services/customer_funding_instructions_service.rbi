# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerFundingInstructionsService < StripeService
    # Retrieve funding instructions for a customer cash balance. If funding instructions do not yet exist for the customer, new
    # funding instructions will be created. If funding instructions have already been created for a given customer, the same
    # funding instructions will be retrieved. In other words, we will return the same funding instructions each time.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerFundingInstructionsCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FundingInstructions)
     }
    def create(customer, params = {}, opts = {}); end
  end
end