# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    class AccountOwnerService < StripeService
      # Lists all owners for a given Account
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountOwnerListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(account, params = {}, opts = {}); end
    end
  end
end