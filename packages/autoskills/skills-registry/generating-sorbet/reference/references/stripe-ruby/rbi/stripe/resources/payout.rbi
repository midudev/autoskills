# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A `Payout` object is created when you receive funds from Stripe, or when you
  # initiate a payout to either a bank account or debit card of a [connected
  # Stripe account](https://docs.stripe.com/docs/connect/bank-debit-card-payouts). You can retrieve individual payouts,
  # and list all payouts. Payouts are made on [varying
  # schedules](https://docs.stripe.com/docs/connect/manage-payout-schedule), depending on your country and
  # industry.
  #
  # Related guide: [Receiving payouts](https://docs.stripe.com/payouts)
  class Payout < APIResource
    class TraceId < ::Stripe::StripeObject
      # Possible values are `pending`, `supported`, and `unsupported`. When `payout.status` is `pending` or `in_transit`, this will be `pending`. When the payout transitions to `paid`, `failed`, or `canceled`, this status will become `supported` or `unsupported` shortly after in most cases. In some cases, this may appear as `pending` for up to 10 days after `arrival_date` until transitioning to `supported` or `unsupported`.
      sig { returns(String) }
      def status; end
      # The trace ID value if `trace_id.status` is `supported`, otherwise `nil`.
      sig { returns(T.nilable(String)) }
      def value; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The amount (in cents (or local equivalent)) that transfers to your bank account or debit card.
    sig { returns(Integer) }
    def amount; end
    # The application fee (if any) for the payout. [See the Connect documentation](https://docs.stripe.com/connect/instant-payouts#monetization-and-fees) for details.
    sig { returns(T.nilable(T.any(String, ::Stripe::ApplicationFee))) }
    def application_fee; end
    # The amount of the application fee (if any) requested for the payout. [See the Connect documentation](https://docs.stripe.com/connect/instant-payouts#monetization-and-fees) for details.
    sig { returns(T.nilable(Integer)) }
    def application_fee_amount; end
    # Date that you can expect the payout to arrive in the bank. This factors in delays to account for weekends or bank holidays.
    sig { returns(Integer) }
    def arrival_date; end
    # Returns `true` if the payout is created by an [automated payout schedule](https://docs.stripe.com/payouts#payout-schedule) and `false` if it's [requested manually](https://stripe.com/docs/payouts#manual-payouts).
    sig { returns(T::Boolean) }
    def automatic; end
    # ID of the balance transaction that describes the impact of this payout on your account balance.
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def balance_transaction; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # ID of the bank account or card the payout is sent to.
    sig { returns(T.nilable(T.any(String, T.any(::Stripe::BankAccount, ::Stripe::Card)))) }
    def destination; end
    # If the payout fails or cancels, this is the ID of the balance transaction that reverses the initial balance transaction and returns the funds from the failed payout back in your balance.
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def failure_balance_transaction; end
    # Error code that provides a reason for a payout failure, if available. View our [list of failure codes](https://docs.stripe.com/api#payout_failures).
    sig { returns(T.nilable(String)) }
    def failure_code; end
    # Message that provides the reason for a payout failure, if available.
    sig { returns(T.nilable(String)) }
    def failure_message; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # The method used to send this payout, which can be `standard` or `instant`. `instant` is supported for payouts to debit cards and bank accounts in certain countries. Learn more about [bank support for Instant Payouts](https://stripe.com/docs/payouts/instant-payouts-banks).
    sig { returns(String) }
    def method; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # If the payout reverses another, this is the ID of the original payout.
    sig { returns(T.nilable(T.any(String, ::Stripe::Payout))) }
    def original_payout; end
    # ID of the v2 FinancialAccount the funds are sent to.
    sig { returns(T.nilable(String)) }
    def payout_method; end
    # If `completed`, you can use the [Balance Transactions API](https://docs.stripe.com/api/balance_transactions/list#balance_transaction_list-payout) to list all balance transactions that are paid out in this payout.
    sig { returns(String) }
    def reconciliation_status; end
    # If the payout reverses, this is the ID of the payout that reverses this payout.
    sig { returns(T.nilable(T.any(String, ::Stripe::Payout))) }
    def reversed_by; end
    # The source balance this payout came from, which can be one of the following: `card`, `fpx`, or `bank_account`.
    sig { returns(String) }
    def source_type; end
    # Extra information about a payout that displays on the user's bank statement.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    # Current status of the payout: `paid`, `pending`, `in_transit`, `canceled` or `failed`. A payout is `pending` until it's submitted to the bank, when it becomes `in_transit`. The status changes to `paid` if the transaction succeeds, or to `failed` or `canceled` (within 5 business days). Some payouts that fail might initially show as `paid`, then change to `failed`.
    sig { returns(String) }
    def status; end
    # A value that generates from the beneficiary's bank that allows users to track payouts with their bank. Banks might call this a "reference number" or something similar.
    sig { returns(T.nilable(TraceId)) }
    def trace_id; end
    # Can be `bank_account` or `card`.
    sig { returns(String) }
    def type; end
    # You can cancel a previously created payout if its status is pending. Stripe refunds the funds to your available balance. You can't cancel automatic Stripe payouts.
    sig {
      params(params: T.any(::Stripe::PayoutCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Payout)
     }
    def cancel(params = {}, opts = {}); end

    # You can cancel a previously created payout if its status is pending. Stripe refunds the funds to your available balance. You can't cancel automatic Stripe payouts.
    sig {
      params(payout: String, params: T.any(::Stripe::PayoutCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Payout)
     }
    def self.cancel(payout, params = {}, opts = {}); end

    # To send funds to your own bank account, create a new payout object. Your [Stripe balance](https://docs.stripe.com/api#balance) must cover the payout amount. If it doesn't, you receive an “Insufficient Funds” error.
    #
    # If your API key is in test mode, money won't actually be sent, though every other action occurs as if you're in live mode.
    #
    # If you create a manual payout on a Stripe account that uses multiple payment source types, you need to specify the source type balance that the payout draws from. The [balance object](https://docs.stripe.com/api#balance_object) details available and pending amounts by source type.
    sig {
      params(params: T.any(::Stripe::PayoutCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Payout)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of existing payouts sent to third-party bank accounts or payouts that Stripe sent to you. The payouts return in sorted order, with the most recently created payouts appearing first.
    sig {
      params(params: T.any(::Stripe::PayoutListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Reverses a payout by debiting the destination bank account. At this time, you can only reverse payouts for connected accounts to US and Canadian bank accounts. If the payout is manual and in the pending status, use /v1/payouts/:id/cancel instead.
    #
    # By requesting a reversal through /v1/payouts/:id/reverse, you confirm that the authorized signatory of the selected bank account authorizes the debit on the bank account and that no other authorization is required.
    sig {
      params(params: T.any(::Stripe::PayoutReverseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Payout)
     }
    def reverse(params = {}, opts = {}); end

    # Reverses a payout by debiting the destination bank account. At this time, you can only reverse payouts for connected accounts to US and Canadian bank accounts. If the payout is manual and in the pending status, use /v1/payouts/:id/cancel instead.
    #
    # By requesting a reversal through /v1/payouts/:id/reverse, you confirm that the authorized signatory of the selected bank account authorizes the debit on the bank account and that no other authorization is required.
    sig {
      params(payout: String, params: T.any(::Stripe::PayoutReverseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Payout)
     }
    def self.reverse(payout, params = {}, opts = {}); end

    # Updates the specified payout by setting the values of the parameters you pass. We don't change parameters that you don't provide. This request only accepts the metadata as arguments.
    sig {
      params(payout: String, params: T.any(::Stripe::PayoutUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Payout)
     }
    def self.update(payout, params = {}, opts = {}); end
  end
end