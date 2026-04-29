# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Balance transactions represent funds moving through your Stripe account.
  # Stripe creates them for every type of transaction that enters or leaves your Stripe account balance.
  #
  # Related guide: [Balance transaction types](https://docs.stripe.com/reports/balance-transaction-types)
  class BalanceTransaction < APIResource
    class FeeDetail < ::Stripe::StripeObject
      # Amount of the fee, in cents.
      sig { returns(Integer) }
      def amount; end
      # ID of the Connect application that earned the fee.
      sig { returns(T.nilable(String)) }
      def application; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # An arbitrary string attached to the object. Often useful for displaying to users.
      sig { returns(T.nilable(String)) }
      def description; end
      # Type of the fee, one of: `application_fee`, `payment_method_passthrough_fee`, `stripe_fee` or `tax`.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Gross amount of this transaction (in cents (or local equivalent)). A positive value represents funds charged to another party, and a negative value represents funds sent to another party.
    sig { returns(Integer) }
    def amount; end
    # The date that the transaction's net funds become available in the Stripe balance.
    sig { returns(Integer) }
    def available_on; end
    # The balance that this transaction impacts.
    sig { returns(String) }
    def balance_type; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # If applicable, this transaction uses an exchange rate. If money converts from currency A to currency B, then the `amount` in currency A, multipled by the `exchange_rate`, equals the `amount` in currency B. For example, if you charge a customer 10.00 EUR, the PaymentIntent's `amount` is `1000` and `currency` is `eur`. If this converts to 12.34 USD in your Stripe account, the BalanceTransaction's `amount` is `1234`, its `currency` is `usd`, and the `exchange_rate` is `1.234`.
    sig { returns(T.nilable(Float)) }
    def exchange_rate; end
    # Fees (in cents (or local equivalent)) paid for this transaction. Represented as a positive integer when assessed.
    sig { returns(Integer) }
    def fee; end
    # Detailed breakdown of fees (in cents (or local equivalent)) paid for this transaction.
    sig { returns(T::Array[FeeDetail]) }
    def fee_details; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Net impact to a Stripe balance (in cents (or local equivalent)). A positive value represents incrementing a Stripe balance, and a negative value decrementing a Stripe balance. You can calculate the net impact of a transaction on a balance by `amount` - `fee`
    sig { returns(Integer) }
    def net; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Learn more about how [reporting categories](https://stripe.com/docs/reports/reporting-categories) can help you understand balance transactions from an accounting perspective.
    sig { returns(String) }
    def reporting_category; end
    # This transaction relates to the Stripe object.
    sig {
      returns(T.nilable(T.any(String, T.any(::Stripe::ApplicationFee, ::Stripe::Charge, ::Stripe::ConnectCollectionTransfer, ::Stripe::CustomerCashBalanceTransaction, ::Stripe::Dispute, ::Stripe::ApplicationFeeRefund, ::Stripe::Issuing::Authorization, ::Stripe::Issuing::Dispute, ::Stripe::Issuing::Transaction, ::Stripe::Payout, ::Stripe::Refund, ::Stripe::ReserveTransaction, ::Stripe::TaxDeductedAtSource, ::Stripe::Topup, ::Stripe::Transfer, ::Stripe::Reversal))))
     }
    def source; end
    # The transaction's net funds status in the Stripe balance, which are either `available` or `pending`.
    sig { returns(String) }
    def status; end
    # Transaction type: `adjustment`, `advance`, `advance_funding`, `anticipation_repayment`, `application_fee`, `application_fee_refund`, `charge`, `climate_order_purchase`, `climate_order_refund`, `connect_collection_transfer`, `contribution`, `issuing_authorization_hold`, `issuing_authorization_release`, `issuing_dispute`, `issuing_transaction`, `obligation_outbound`, `obligation_reversal_inbound`, `payment`, `payment_failure_refund`, `payment_network_reserve_hold`, `payment_network_reserve_release`, `payment_refund`, `payment_reversal`, `payment_unreconciled`, `payout`, `payout_cancel`, `payout_failure`, `payout_minimum_balance_hold`, `payout_minimum_balance_release`, `refund`, `refund_failure`, `reserve_transaction`, `reserved_funds`, `stripe_fee`, `stripe_fx_fee`, `stripe_balance_payment_debit`, `stripe_balance_payment_debit_reversal`, `tax_fee`, `topup`, `topup_reversal`, `transfer`, `transfer_cancel`, `transfer_failure`, or `transfer_refund`. Learn more about [balance transaction types and what they represent](https://stripe.com/docs/reports/balance-transaction-types). To classify transactions for accounting purposes, consider `reporting_category` instead.
    sig { returns(String) }
    def type; end
    # Returns a list of transactions that have contributed to the Stripe account balance (e.g., charges, transfers, and so forth). The transactions are returned in sorted order, with the most recent transactions appearing first.
    #
    # Note that this endpoint was previously called “Balance history” and used the path /v1/balance/history.
    sig {
      params(params: T.any(::Stripe::BalanceTransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end