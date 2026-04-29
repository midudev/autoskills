# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class TransactionListParams < ::Stripe::RequestParams
      class Created < ::Stripe::RequestParams
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
      class StatusTransitions < ::Stripe::RequestParams
        class PostedAt < ::Stripe::RequestParams
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
        # Returns Transactions with `posted_at` within the specified range.
        sig {
          returns(T.nilable(T.any(Treasury::TransactionListParams::StatusTransitions::PostedAt, Integer)))
         }
        def posted_at; end
        sig {
          params(_posted_at: T.nilable(T.any(Treasury::TransactionListParams::StatusTransitions::PostedAt, Integer))).returns(T.nilable(T.any(Treasury::TransactionListParams::StatusTransitions::PostedAt, Integer)))
         }
        def posted_at=(_posted_at); end
        sig {
          params(posted_at: T.nilable(T.any(Treasury::TransactionListParams::StatusTransitions::PostedAt, Integer))).void
         }
        def initialize(posted_at: nil); end
      end
      # Only return Transactions that were created during the given date interval.
      sig { returns(T.nilable(T.any(Treasury::TransactionListParams::Created, Integer))) }
      def created; end
      sig {
        params(_created: T.nilable(T.any(Treasury::TransactionListParams::Created, Integer))).returns(T.nilable(T.any(Treasury::TransactionListParams::Created, Integer)))
       }
      def created=(_created); end
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
      # Returns objects associated with this FinancialAccount.
      sig { returns(String) }
      def financial_account; end
      sig { params(_financial_account: String).returns(String) }
      def financial_account=(_financial_account); end
      # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
      sig { returns(T.nilable(Integer)) }
      def limit; end
      sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def limit=(_limit); end
      # The results are in reverse chronological order by `created` or `posted_at`. The default is `created`.
      sig { returns(T.nilable(String)) }
      def order_by; end
      sig { params(_order_by: T.nilable(String)).returns(T.nilable(String)) }
      def order_by=(_order_by); end
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      # Only return Transactions that have the given status: `open`, `posted`, or `void`.
      sig { returns(T.nilable(String)) }
      def status; end
      sig { params(_status: T.nilable(String)).returns(T.nilable(String)) }
      def status=(_status); end
      # A filter for the `status_transitions.posted_at` timestamp. When using this filter, `status=posted` and `order_by=posted_at` must also be specified.
      sig { returns(T.nilable(Treasury::TransactionListParams::StatusTransitions)) }
      def status_transitions; end
      sig {
        params(_status_transitions: T.nilable(Treasury::TransactionListParams::StatusTransitions)).returns(T.nilable(Treasury::TransactionListParams::StatusTransitions))
       }
      def status_transitions=(_status_transitions); end
      sig {
        params(created: T.nilable(T.any(Treasury::TransactionListParams::Created, Integer)), ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), financial_account: String, limit: T.nilable(Integer), order_by: T.nilable(String), starting_after: T.nilable(String), status: T.nilable(String), status_transitions: T.nilable(Treasury::TransactionListParams::StatusTransitions)).void
       }
      def initialize(
        created: nil,
        ending_before: nil,
        expand: nil,
        financial_account: nil,
        limit: nil,
        order_by: nil,
        starting_after: nil,
        status: nil,
        status_transitions: nil
      ); end
    end
  end
end