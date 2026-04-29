# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    class TransactionListParams < ::Stripe::RequestParams
      class TransactedAt < ::Stripe::RequestParams
        # Minimum value to filter by (exclusive)
        sig { returns(T.nilable(Integer)) }
        def gt; end
        sig { params(_gt: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def gt=(_gt); end
        # Minimum value to filter by (inclusive)
        sig { returns(T.nilable(Integer)) }
        def gte; end
        sig { params(_gte: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def gte=(_gte); end
        # Maximum value to filter by (exclusive)
        sig { returns(T.nilable(Integer)) }
        def lt; end
        sig { params(_lt: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def lt=(_lt); end
        # Maximum value to filter by (inclusive)
        sig { returns(T.nilable(Integer)) }
        def lte; end
        sig { params(_lte: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def lte=(_lte); end
        sig {
          params(gt: T.nilable(Integer), gte: T.nilable(Integer), lt: T.nilable(Integer), lte: T.nilable(Integer)).void
         }
        def initialize(gt: nil, gte: nil, lt: nil, lte: nil); end
      end
      class TransactionRefresh < ::Stripe::RequestParams
        # Return results where the transactions were created or updated by a refresh that took place after this refresh (non-inclusive).
        sig { returns(String) }
        def after; end
        sig { params(_after: String).returns(String) }
        def after=(_after); end
        sig { params(after: String).void }
        def initialize(after: nil); end
      end
      # The ID of the Financial Connections Account whose transactions will be retrieved.
      sig { returns(String) }
      def account; end
      sig { params(_account: String).returns(String) }
      def account=(_account); end
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
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      # A filter on the list based on the object `transacted_at` field. The value can be a string with an integer Unix timestamp, or it can be a dictionary with the following options:
      sig {
        returns(T.nilable(T.any(FinancialConnections::TransactionListParams::TransactedAt, Integer)))
       }
      def transacted_at; end
      sig {
        params(_transacted_at: T.nilable(T.any(FinancialConnections::TransactionListParams::TransactedAt, Integer))).returns(T.nilable(T.any(FinancialConnections::TransactionListParams::TransactedAt, Integer)))
       }
      def transacted_at=(_transacted_at); end
      # A filter on the list based on the object `transaction_refresh` field. The value can be a dictionary with the following options:
      sig { returns(T.nilable(FinancialConnections::TransactionListParams::TransactionRefresh)) }
      def transaction_refresh; end
      sig {
        params(_transaction_refresh: T.nilable(FinancialConnections::TransactionListParams::TransactionRefresh)).returns(T.nilable(FinancialConnections::TransactionListParams::TransactionRefresh))
       }
      def transaction_refresh=(_transaction_refresh); end
      sig {
        params(account: String, ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), starting_after: T.nilable(String), transacted_at: T.nilable(T.any(FinancialConnections::TransactionListParams::TransactedAt, Integer)), transaction_refresh: T.nilable(FinancialConnections::TransactionListParams::TransactionRefresh)).void
       }
      def initialize(
        account: nil,
        ending_before: nil,
        expand: nil,
        limit: nil,
        starting_after: nil,
        transacted_at: nil,
        transaction_refresh: nil
      ); end
    end
  end
end