# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SourceTransactionService < StripeService
    # List source transactions for a given source.
    sig {
      params(source: String, params: T.any(::Stripe::SourceTransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(source, params = {}, opts = {}); end
  end
end