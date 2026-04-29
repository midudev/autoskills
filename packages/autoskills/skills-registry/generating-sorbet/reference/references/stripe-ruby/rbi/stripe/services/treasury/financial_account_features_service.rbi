# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class FinancialAccountFeaturesService < StripeService
      # Retrieves Features information associated with the FinancialAccount.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountFeaturesRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccountFeatures)
       }
      def retrieve(financial_account, params = {}, opts = {}); end

      # Updates the Features associated with a FinancialAccount.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountFeaturesUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccountFeatures)
       }
      def update(financial_account, params = {}, opts = {}); end
    end
  end
end