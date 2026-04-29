# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    # ReceivedDebits represent funds pulled from a [FinancialAccount](https://api.stripe.com#financial_accounts). These are not initiated from the FinancialAccount.
    class ReceivedDebit < APIResource
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
        # The DebitReversal created as a result of this ReceivedDebit being reversed.
        sig { returns(T.nilable(String)) }
        def debit_reversal; end
        # Set if the ReceivedDebit is associated with an InboundTransfer's return of funds.
        sig { returns(T.nilable(String)) }
        def inbound_transfer; end
        # Set if the ReceivedDebit was created due to an [Issuing Authorization](https://api.stripe.com#issuing_authorizations) object.
        sig { returns(T.nilable(String)) }
        def issuing_authorization; end
        # Set if the ReceivedDebit is also viewable as an [Issuing Dispute](https://api.stripe.com#issuing_disputes) object.
        sig { returns(T.nilable(String)) }
        def issuing_transaction; end
        # Set if the ReceivedDebit was created due to a [Payout](https://api.stripe.com#payouts) object.
        sig { returns(T.nilable(String)) }
        def payout; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ReversalDetails < ::Stripe::StripeObject
        # Time before which a ReceivedDebit can be reversed.
        sig { returns(T.nilable(Integer)) }
        def deadline; end
        # Set if a ReceivedDebit can't be reversed.
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
      # Reason for the failure. A ReceivedDebit might fail because the FinancialAccount doesn't have sufficient funds, is closed, or is frozen.
      sig { returns(T.nilable(String)) }
      def failure_code; end
      # The FinancialAccount that funds were pulled from.
      sig { returns(T.nilable(String)) }
      def financial_account; end
      # A [hosted transaction receipt](https://docs.stripe.com/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.
      sig { returns(T.nilable(String)) }
      def hosted_regulatory_receipt_url; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Attribute for field initiating_payment_method_details
      sig { returns(T.nilable(InitiatingPaymentMethodDetails)) }
      def initiating_payment_method_details; end
      # Attribute for field linked_flows
      sig { returns(LinkedFlows) }
      def linked_flows; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The network used for the ReceivedDebit.
      sig { returns(String) }
      def network; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Details describing when a ReceivedDebit might be reversed.
      sig { returns(T.nilable(ReversalDetails)) }
      def reversal_details; end
      # Status of the ReceivedDebit. ReceivedDebits are created with a status of either `succeeded` (approved) or `failed` (declined). The failure reason can be found under the `failure_code`.
      sig { returns(String) }
      def status; end
      # The Transaction associated with this object.
      sig { returns(T.nilable(T.any(String, ::Stripe::Treasury::Transaction))) }
      def transaction; end
      # Returns a list of ReceivedDebits.
      sig {
        params(params: T.any(::Stripe::Treasury::ReceivedDebitListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end