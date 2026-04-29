# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    # TransactionEntries represent individual units of money movements within a single [Transaction](https://api.stripe.com#transactions).
    class TransactionEntry < APIResource
      class BalanceImpact < ::Stripe::StripeObject
        # The change made to funds the user can spend right now.
        sig { returns(Integer) }
        def cash; end
        # The change made to funds that are not spendable yet, but will become available at a later time.
        sig { returns(Integer) }
        def inbound_pending; end
        # The change made to funds in the account, but not spendable because they are being held for pending outbound flows.
        sig { returns(Integer) }
        def outbound_pending; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class FlowDetails < ::Stripe::StripeObject
        # You can reverse some [ReceivedCredits](https://api.stripe.com#received_credits) depending on their network and source flow. Reversing a ReceivedCredit leads to the creation of a new object known as a CreditReversal.
        sig { returns(T.nilable(::Stripe::Treasury::CreditReversal)) }
        def credit_reversal; end
        # You can reverse some [ReceivedDebits](https://api.stripe.com#received_debits) depending on their network and source flow. Reversing a ReceivedDebit leads to the creation of a new object known as a DebitReversal.
        sig { returns(T.nilable(::Stripe::Treasury::DebitReversal)) }
        def debit_reversal; end
        # Use [InboundTransfers](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/into/inbound-transfers) to add funds to your [FinancialAccount](https://api.stripe.com#financial_accounts) via a PaymentMethod that is owned by you. The funds will be transferred via an ACH debit.
        #
        # Related guide: [Moving money with Treasury using InboundTransfer objects](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/into/inbound-transfers)
        sig { returns(T.nilable(::Stripe::Treasury::InboundTransfer)) }
        def inbound_transfer; end
        # When an [issued card](https://docs.stripe.com/issuing) is used to make a purchase, an Issuing `Authorization`
        # object is created. [Authorizations](https://docs.stripe.com/issuing/purchases/authorizations) must be approved for the
        # purchase to be completed successfully.
        #
        # Related guide: [Issued card authorizations](https://docs.stripe.com/issuing/purchases/authorizations)
        sig { returns(T.nilable(::Stripe::Issuing::Authorization)) }
        def issuing_authorization; end
        # Use [OutboundPayments](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/out-of/outbound-payments) to send funds to another party's external bank account or [FinancialAccount](https://api.stripe.com#financial_accounts). To send money to an account belonging to the same user, use an [OutboundTransfer](https://api.stripe.com#outbound_transfers).
        #
        # Simulate OutboundPayment state changes with the `/v1/test_helpers/treasury/outbound_payments` endpoints. These methods can only be called on test mode objects.
        #
        # Related guide: [Moving money with Treasury using OutboundPayment objects](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/out-of/outbound-payments)
        sig { returns(T.nilable(::Stripe::Treasury::OutboundPayment)) }
        def outbound_payment; end
        # Use [OutboundTransfers](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/out-of/outbound-transfers) to transfer funds from a [FinancialAccount](https://api.stripe.com#financial_accounts) to a PaymentMethod belonging to the same entity. To send funds to a different party, use [OutboundPayments](https://api.stripe.com#outbound_payments) instead. You can send funds over ACH rails or through a domestic wire transfer to a user's own external bank account.
        #
        # Simulate OutboundTransfer state changes with the `/v1/test_helpers/treasury/outbound_transfers` endpoints. These methods can only be called on test mode objects.
        #
        # Related guide: [Moving money with Treasury using OutboundTransfer objects](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/out-of/outbound-transfers)
        sig { returns(T.nilable(::Stripe::Treasury::OutboundTransfer)) }
        def outbound_transfer; end
        # ReceivedCredits represent funds sent to a [FinancialAccount](https://api.stripe.com#financial_accounts) (for example, via ACH or wire). These money movements are not initiated from the FinancialAccount.
        sig { returns(T.nilable(::Stripe::Treasury::ReceivedCredit)) }
        def received_credit; end
        # ReceivedDebits represent funds pulled from a [FinancialAccount](https://api.stripe.com#financial_accounts). These are not initiated from the FinancialAccount.
        sig { returns(T.nilable(::Stripe::Treasury::ReceivedDebit)) }
        def received_debit; end
        # Type of the flow that created the Transaction. Set to the same value as `flow_type`.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Change to a FinancialAccount's balance
      sig { returns(BalanceImpact) }
      def balance_impact; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # When the TransactionEntry will impact the FinancialAccount's balance.
      sig { returns(Integer) }
      def effective_at; end
      # The FinancialAccount associated with this object.
      sig { returns(String) }
      def financial_account; end
      # Token of the flow associated with the TransactionEntry.
      sig { returns(T.nilable(String)) }
      def flow; end
      # Details of the flow associated with the TransactionEntry.
      sig { returns(T.nilable(FlowDetails)) }
      def flow_details; end
      # Type of the flow associated with the TransactionEntry.
      sig { returns(String) }
      def flow_type; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The Transaction associated with this object.
      sig { returns(T.any(String, ::Stripe::Treasury::Transaction)) }
      def transaction; end
      # The specific money movement that generated the TransactionEntry.
      sig { returns(String) }
      def type; end
      # Retrieves a list of TransactionEntry objects.
      sig {
        params(params: T.any(::Stripe::Treasury::TransactionEntryListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end