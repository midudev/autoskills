# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    # A Financial Connections Session is the secure way to programmatically launch the client-side Stripe.js modal that lets your users link their accounts.
    class Session < APIResource
      class AccountHolder < ::Stripe::StripeObject
        # The ID of the Stripe account that this account belongs to. Only available when `account_holder.type` is `account`.
        sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
        def account; end
        # The ID for an Account representing a customer that this account belongs to. Only available when `account_holder.type` is `customer`.
        sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
        def customer; end
        # Attribute for field customer_account
        sig { returns(T.nilable(String)) }
        def customer_account; end
        # Type of account holder that this account belongs to.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Filters < ::Stripe::StripeObject
        # Restricts the Session to subcategories of accounts that can be linked. Valid subcategories are: `checking`, `savings`, `mortgage`, `line_of_credit`, `credit_card`.
        sig { returns(T.nilable(T::Array[String])) }
        def account_subcategories; end
        # List of countries from which to filter accounts.
        sig { returns(T.nilable(T::Array[String])) }
        def countries; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The account holder for whom accounts are collected in this session.
      sig { returns(T.nilable(AccountHolder)) }
      def account_holder; end
      # The accounts that were collected as part of this Session.
      sig { returns(::Stripe::ListObject) }
      def accounts; end
      # A value that will be passed to the client to launch the authentication flow.
      sig { returns(T.nilable(String)) }
      def client_secret; end
      # Attribute for field filters
      sig { returns(T.nilable(Filters)) }
      def filters; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Permissions requested for accounts collected during this session.
      sig { returns(T::Array[String]) }
      def permissions; end
      # Data features requested to be retrieved upon account creation.
      sig { returns(T.nilable(T::Array[String])) }
      def prefetch; end
      # For webview integrations only. Upon completing OAuth login in the native browser, the user will be redirected to this URL to return to your app.
      sig { returns(T.nilable(String)) }
      def return_url; end
      # To launch the Financial Connections authorization flow, create a Session. The session's client_secret can be used to launch the flow using Stripe.js.
      sig {
        params(params: T.any(::Stripe::FinancialConnections::SessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Session)
       }
      def self.create(params = {}, opts = {}); end
    end
  end
end