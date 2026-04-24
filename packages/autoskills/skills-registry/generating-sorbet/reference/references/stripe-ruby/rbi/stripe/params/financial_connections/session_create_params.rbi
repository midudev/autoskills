# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    class SessionCreateParams < ::Stripe::RequestParams
      class AccountHolder < ::Stripe::RequestParams
        # The ID of the Stripe account whose accounts you will retrieve. Only available when `type` is `account`.
        sig { returns(T.nilable(String)) }
        def account; end
        sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
        def account=(_account); end
        # The ID of the Stripe customer whose accounts you will retrieve. Only available when `type` is `customer`.
        sig { returns(T.nilable(String)) }
        def customer; end
        sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
        def customer=(_customer); end
        # The ID of Account representing a customer whose accounts you will retrieve. Only available when `type` is `customer`.
        sig { returns(T.nilable(String)) }
        def customer_account; end
        sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
        def customer_account=(_customer_account); end
        # Type of account holder to collect accounts for.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(account: T.nilable(String), customer: T.nilable(String), customer_account: T.nilable(String), type: String).void
         }
        def initialize(account: nil, customer: nil, customer_account: nil, type: nil); end
      end
      class Filters < ::Stripe::RequestParams
        # Restricts the Session to subcategories of accounts that can be linked. Valid subcategories are: `checking`, `savings`, `mortgage`, `line_of_credit`, `credit_card`.
        sig { returns(T.nilable(T::Array[String])) }
        def account_subcategories; end
        sig {
          params(_account_subcategories: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def account_subcategories=(_account_subcategories); end
        # List of countries from which to collect accounts.
        sig { returns(T.nilable(T::Array[String])) }
        def countries; end
        sig { params(_countries: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def countries=(_countries); end
        sig {
          params(account_subcategories: T.nilable(T::Array[String]), countries: T.nilable(T::Array[String])).void
         }
        def initialize(account_subcategories: nil, countries: nil); end
      end
      # The account holder to link accounts for.
      sig { returns(FinancialConnections::SessionCreateParams::AccountHolder) }
      def account_holder; end
      sig {
        params(_account_holder: FinancialConnections::SessionCreateParams::AccountHolder).returns(FinancialConnections::SessionCreateParams::AccountHolder)
       }
      def account_holder=(_account_holder); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Filters to restrict the kinds of accounts to collect.
      sig { returns(T.nilable(FinancialConnections::SessionCreateParams::Filters)) }
      def filters; end
      sig {
        params(_filters: T.nilable(FinancialConnections::SessionCreateParams::Filters)).returns(T.nilable(FinancialConnections::SessionCreateParams::Filters))
       }
      def filters=(_filters); end
      # List of data features that you would like to request access to.
      #
      # Possible values are `balances`, `transactions`, `ownership`, and `payment_method`.
      sig { returns(T::Array[String]) }
      def permissions; end
      sig { params(_permissions: T::Array[String]).returns(T::Array[String]) }
      def permissions=(_permissions); end
      # List of data features that you would like to retrieve upon account creation.
      sig { returns(T.nilable(T::Array[String])) }
      def prefetch; end
      sig { params(_prefetch: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def prefetch=(_prefetch); end
      # For webview integrations only. Upon completing OAuth login in the native browser, the user will be redirected to this URL to return to your app.
      sig { returns(T.nilable(String)) }
      def return_url; end
      sig { params(_return_url: T.nilable(String)).returns(T.nilable(String)) }
      def return_url=(_return_url); end
      sig {
        params(account_holder: FinancialConnections::SessionCreateParams::AccountHolder, expand: T.nilable(T::Array[String]), filters: T.nilable(FinancialConnections::SessionCreateParams::Filters), permissions: T::Array[String], prefetch: T.nilable(T::Array[String]), return_url: T.nilable(String)).void
       }
      def initialize(
        account_holder: nil,
        expand: nil,
        filters: nil,
        permissions: nil,
        prefetch: nil,
        return_url: nil
      ); end
    end
  end
end