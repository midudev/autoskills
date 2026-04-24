# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SetupAttemptService < StripeService
    # Returns a list of SetupAttempts that associate with a provided SetupIntent.
    sig {
      params(params: T.any(::Stripe::SetupAttemptListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end
  end
end