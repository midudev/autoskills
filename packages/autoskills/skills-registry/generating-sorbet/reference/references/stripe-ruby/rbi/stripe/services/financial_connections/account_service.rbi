# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    class AccountService < StripeService
      attr_reader :owners
      # Disables your access to a Financial Connections Account. You will no longer be able to access data associated with the account (e.g. balances, transactions).
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountDisconnectParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def disconnect(account, params = {}, opts = {}); end

      # Returns a list of Financial Connections Account objects.
      sig {
        params(params: T.any(::Stripe::FinancialConnections::AccountListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Refreshes the data associated with a Financial Connections Account.
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountRefreshParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def refresh(account, params = {}, opts = {}); end

      # Retrieves the details of an Financial Connections Account.
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def retrieve(account, params = {}, opts = {}); end

      # Subscribes to periodic refreshes of data associated with a Financial Connections Account. When the account status is active, data is typically refreshed once a day.
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountSubscribeParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def subscribe(account, params = {}, opts = {}); end

      # Unsubscribes from periodic refreshes of data associated with a Financial Connections Account.
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountUnsubscribeParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def unsubscribe(account, params = {}, opts = {}); end
    end
  end
end