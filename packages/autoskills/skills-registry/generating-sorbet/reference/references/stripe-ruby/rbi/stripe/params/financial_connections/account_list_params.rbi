# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    class AccountListParams < ::Stripe::RequestParams
      class AccountHolder < ::Stripe::RequestParams
        # The ID of the Stripe account whose accounts you will retrieve.
        sig { returns(T.nilable(String)) }
        def account; end
        sig { params(_account: T.nilable(String)).returns(T.nilable(String)) }
        def account=(_account); end
        # The ID of the Stripe customer whose accounts you will retrieve.
        sig { returns(T.nilable(String)) }
        def customer; end
        sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
        def customer=(_customer); end
        # The ID of the Account representing a customer whose accounts you will retrieve.
        sig { returns(T.nilable(String)) }
        def customer_account; end
        sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
        def customer_account=(_customer_account); end
        sig {
          params(account: T.nilable(String), customer: T.nilable(String), customer_account: T.nilable(String)).void
         }
        def initialize(account: nil, customer: nil, customer_account: nil); end
      end
      # If present, only return accounts that belong to the specified account holder. `account_holder[customer]` and `account_holder[account]` are mutually exclusive.
      sig { returns(T.nilable(FinancialConnections::AccountListParams::AccountHolder)) }
      def account_holder; end
      sig {
        params(_account_holder: T.nilable(FinancialConnections::AccountListParams::AccountHolder)).returns(T.nilable(FinancialConnections::AccountListParams::AccountHolder))
       }
      def account_holder=(_account_holder); end
      # A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
      sig { returns(T.nilable(String)) }
      def ending_before; end
      sig { params(_ending_before: T.nilable(String)).returns(T.nilable(String)) }
      def ending_before=(_ending_before); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
      sig { returns(T.nilable(Integer)) }
      def limit; end
      sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def limit=(_limit); end
      # If present, only return accounts that were collected as part of the given session.
      sig { returns(T.nilable(String)) }
      def session; end
      sig { params(_session: T.nilable(String)).returns(T.nilable(String)) }
      def session=(_session); end
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      sig {
        params(account_holder: T.nilable(FinancialConnections::AccountListParams::AccountHolder), ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), session: T.nilable(String), starting_after: T.nilable(String)).void
       }
      def initialize(
        account_holder: nil,
        ending_before: nil,
        expand: nil,
        limit: nil,
        session: nil,
        starting_after: nil
      ); end
    end
  end
end