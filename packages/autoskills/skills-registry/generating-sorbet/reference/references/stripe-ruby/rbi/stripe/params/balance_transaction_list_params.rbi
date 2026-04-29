# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class BalanceTransactionListParams < ::Stripe::RequestParams
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
    # Only return transactions that were created during the given date interval.
    sig { returns(T.nilable(T.any(BalanceTransactionListParams::Created, Integer))) }
    def created; end
    sig {
      params(_created: T.nilable(T.any(BalanceTransactionListParams::Created, Integer))).returns(T.nilable(T.any(BalanceTransactionListParams::Created, Integer)))
     }
    def created=(_created); end
    # Only return transactions in a certain currency. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(String)) }
    def currency; end
    sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
    def currency=(_currency); end
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
    # For automatic Stripe payouts only, only returns transactions that were paid out on the specified payout ID.
    sig { returns(T.nilable(String)) }
    def payout; end
    sig { params(_payout: T.nilable(String)).returns(T.nilable(String)) }
    def payout=(_payout); end
    # Only returns the original transaction.
    sig { returns(T.nilable(String)) }
    def source; end
    sig { params(_source: T.nilable(String)).returns(T.nilable(String)) }
    def source=(_source); end
    # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
    sig { returns(T.nilable(String)) }
    def starting_after; end
    sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
    def starting_after=(_starting_after); end
    # Only returns transactions of the given type. One of: `adjustment`, `advance`, `advance_funding`, `anticipation_repayment`, `application_fee`, `application_fee_refund`, `charge`, `climate_order_purchase`, `climate_order_refund`, `connect_collection_transfer`, `contribution`, `issuing_authorization_hold`, `issuing_authorization_release`, `issuing_dispute`, `issuing_transaction`, `obligation_outbound`, `obligation_reversal_inbound`, `payment`, `payment_failure_refund`, `payment_network_reserve_hold`, `payment_network_reserve_release`, `payment_refund`, `payment_reversal`, `payment_unreconciled`, `payout`, `payout_cancel`, `payout_failure`, `payout_minimum_balance_hold`, `payout_minimum_balance_release`, `refund`, `refund_failure`, `reserve_transaction`, `reserved_funds`, `stripe_fee`, `stripe_fx_fee`, `stripe_balance_payment_debit`, `stripe_balance_payment_debit_reversal`, `tax_fee`, `topup`, `topup_reversal`, `transfer`, `transfer_cancel`, `transfer_failure`, or `transfer_refund`.
    sig { returns(T.nilable(String)) }
    def type; end
    sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
    def type=(_type); end
    sig {
      params(created: T.nilable(T.any(BalanceTransactionListParams::Created, Integer)), currency: T.nilable(String), ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), payout: T.nilable(String), source: T.nilable(String), starting_after: T.nilable(String), type: T.nilable(String)).void
     }
    def initialize(
      created: nil,
      currency: nil,
      ending_before: nil,
      expand: nil,
      limit: nil,
      payout: nil,
      source: nil,
      starting_after: nil,
      type: nil
    ); end
  end
end