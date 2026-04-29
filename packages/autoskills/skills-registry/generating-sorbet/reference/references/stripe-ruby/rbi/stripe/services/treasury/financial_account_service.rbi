# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class FinancialAccountService < StripeService
      attr_reader :features
      # Closes a FinancialAccount. A FinancialAccount can only be closed if it has a zero balance, has no pending InboundTransfers, and has canceled all attached Issuing cards.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountCloseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccount)
       }
      def close(financial_account, params = {}, opts = {}); end

      # Creates a new FinancialAccount. Each connected account can have up to three FinancialAccounts by default.
      sig {
        params(params: T.any(::Stripe::Treasury::FinancialAccountCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccount)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of FinancialAccounts.
      sig {
        params(params: T.any(::Stripe::Treasury::FinancialAccountListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of a FinancialAccount.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccount)
       }
      def retrieve(financial_account, params = {}, opts = {}); end

      # Updates the details of a FinancialAccount.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccount)
       }
      def update(financial_account, params = {}, opts = {}); end
    end
  end
end