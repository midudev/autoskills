# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    # ReceivedCredits represent funds sent to a [FinancialAccount](https://api.stripe.com#financial_accounts) (for example, via ACH or wire). These money movements are not initiated from the FinancialAccount.
    class ReceivedCredit < APIResource
      class InitiatingPaymentMethodDetails < ::Stripe::StripeObject
        class BillingDetails < ::Stripe::StripeObject
          class Address < ::Stripe::StripeObject
            # City, district, suburb, town, or village.
            sig { returns(T.nilable(String)) }
            def city; end
            # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
            sig { returns(T.nilable(String)) }
            def country; end
            # Address line 1, such as the street, PO Box, or company name.
            sig { returns(T.nilable(String)) }
            def line1; end
            # Address line 2, such as the apartment, suite, unit, or building.
            sig { returns(T.nilable(String)) }
            def line2; end
            # ZIP or postal code.
            sig { returns(T.nilable(String)) }
            def postal_code; end
            # State, county, province, or region ([ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2)).
            sig { returns(T.nilable(String)) }
            def state; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Attribute for field address
          sig { returns(Address) }
          def address; end
          # Email address.
          sig { returns(T.nilable(String)) }
          def email; end
          # Full name.
          sig { returns(T.nilable(String)) }
          def name; end
          def self.inner_class_types
            @inner_class_types = {address: Address}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class FinancialAccount < ::Stripe::StripeObject
          # The FinancialAccount ID.
          sig { returns(String) }
          def id; end
          # The rails the ReceivedCredit was sent over. A FinancialAccount can only send funds over `stripe`.
          sig { returns(String) }
          def network; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class UsBankAccount < ::Stripe::StripeObject
          # Bank name.
          sig { returns(T.nilable(String)) }
          def bank_name; end
          # The last four digits of the bank account number.
          sig { returns(T.nilable(String)) }
          def last4; end
          # The routing number for the bank account.
          sig { returns(T.nilable(String)) }
          def routing_number; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Set when `type` is `balance`.
        sig { returns(T.nilable(String)) }
        def balance; end
        # Attribute for field billing_details
        sig { returns(BillingDetails) }
        def billing_details; end
        # Attribute for field financial_account
        sig { returns(T.nilable(FinancialAccount)) }
        def financial_account; end
        # Set when `type` is `issuing_card`. This is an [Issuing Card](https://api.stripe.com#issuing_cards) ID.
        sig { returns(T.nilable(String)) }
        def issuing_card; end
        # Polymorphic type matching the originating money movement's source. This can be an external account, a Stripe balance, or a FinancialAccount.
        sig { returns(String) }
        def type; end
        # Attribute for field us_bank_account
        sig { returns(T.nilable(UsBankAccount)) }
        def us_bank_account; end
        def self.inner_class_types
          @inner_class_types = {
            billing_details: BillingDetails,
            financial_account: FinancialAccount,
            us_bank_account: UsBankAccount,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class LinkedFlows < ::Stripe::StripeObject
        class SourceFlowDetails < ::Stripe::StripeObject
          # You can reverse some [ReceivedCredits](https://api.stripe.com#received_credits) depending on their network and source flow. Reversing a ReceivedCredit leads to the creation of a new object known as a CreditReversal.
          sig { returns(T.nilable(::Stripe::Treasury::CreditReversal)) }
          def credit_reversal; end
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
          # A `Payout` object is created when you receive funds from Stripe, or when you
          # initiate a payout to either a bank account or debit card of a [connected
          # Stripe account](/docs/connect/bank-debit-card-payouts). You can retrieve individual payouts,
          # and list all payouts. Payouts are made on [varying
          # schedules](/docs/connect/manage-payout-schedule), depending on your country and
          # industry.
          #
          # Related guide: [Receiving payouts](https://docs.stripe.com/payouts)
          sig { returns(T.nilable(::Stripe::Payout)) }
          def payout; end
          # The type of the source flow that originated the ReceivedCredit.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The CreditReversal created as a result of this ReceivedCredit being reversed.
        sig { returns(T.nilable(String)) }
        def credit_reversal; end
        # Set if the ReceivedCredit was created due to an [Issuing Authorization](https://api.stripe.com#issuing_authorizations) object.
        sig { returns(T.nilable(String)) }
        def issuing_authorization; end
        # Set if the ReceivedCredit is also viewable as an [Issuing transaction](https://api.stripe.com#issuing_transactions) object.
        sig { returns(T.nilable(String)) }
        def issuing_transaction; end
        # ID of the source flow. Set if `network` is `stripe` and the source flow is visible to the user. Examples of source flows include OutboundPayments, payouts, or CreditReversals.
        sig { returns(T.nilable(String)) }
        def source_flow; end
        # The expandable object of the source flow.
        sig { returns(T.nilable(SourceFlowDetails)) }
        def source_flow_details; end
        # The type of flow that originated the ReceivedCredit (for example, `outbound_payment`).
        sig { returns(T.nilable(String)) }
        def source_flow_type; end
        def self.inner_class_types
          @inner_class_types = {source_flow_details: SourceFlowDetails}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ReversalDetails < ::Stripe::StripeObject
        # Time before which a ReceivedCredit can be reversed.
        sig { returns(T.nilable(Integer)) }
        def deadline; end
        # Set if a ReceivedCredit cannot be reversed.
        sig { returns(T.nilable(String)) }
        def restricted_reason; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Amount (in cents) transferred.
      sig { returns(Integer) }
      def amount; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # An arbitrary string attached to the object. Often useful for displaying to users.
      sig { returns(String) }
      def description; end
      # Reason for the failure. A ReceivedCredit might fail because the receiving FinancialAccount is closed or frozen.
      sig { returns(T.nilable(String)) }
      def failure_code; end
      # The FinancialAccount that received the funds.
      sig { returns(T.nilable(String)) }
      def financial_account; end
      # A [hosted transaction receipt](https://docs.stripe.com/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.
      sig { returns(T.nilable(String)) }
      def hosted_regulatory_receipt_url; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Attribute for field initiating_payment_method_details
      sig { returns(InitiatingPaymentMethodDetails) }
      def initiating_payment_method_details; end
      # Attribute for field linked_flows
      sig { returns(LinkedFlows) }
      def linked_flows; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The rails used to send the funds.
      sig { returns(String) }
      def network; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Details describing when a ReceivedCredit may be reversed.
      sig { returns(T.nilable(ReversalDetails)) }
      def reversal_details; end
      # Status of the ReceivedCredit. ReceivedCredits are created either `succeeded` (approved) or `failed` (declined). If a ReceivedCredit is declined, the failure reason can be found in the `failure_code` field.
      sig { returns(String) }
      def status; end
      # The Transaction associated with this object.
      sig { returns(T.nilable(T.any(String, ::Stripe::Treasury::Transaction))) }
      def transaction; end
      # Returns a list of ReceivedCredits.
      sig {
        params(params: T.any(::Stripe::Treasury::ReceivedCreditListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end