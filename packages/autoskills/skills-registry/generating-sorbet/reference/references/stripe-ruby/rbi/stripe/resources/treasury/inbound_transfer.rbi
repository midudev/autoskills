# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    # Use [InboundTransfers](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/into/inbound-transfers) to add funds to your [FinancialAccount](https://api.stripe.com#financial_accounts) via a PaymentMethod that is owned by you. The funds will be transferred via an ACH debit.
    #
    # Related guide: [Moving money with Treasury using InboundTransfer objects](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/into/inbound-transfers)
    class InboundTransfer < APIResource
      class FailureDetails < ::Stripe::StripeObject
        # Reason for the failure.
        sig { returns(String) }
        def code; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class LinkedFlows < ::Stripe::StripeObject
        # If funds for this flow were returned after the flow went to the `succeeded` state, this field contains a reference to the ReceivedDebit return.
        sig { returns(T.nilable(String)) }
        def received_debit; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class OriginPaymentMethodDetails < ::Stripe::StripeObject
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
        class UsBankAccount < ::Stripe::StripeObject
          # Account holder type: individual or company.
          sig { returns(T.nilable(String)) }
          def account_holder_type; end
          # Account type: checkings or savings. Defaults to checking if omitted.
          sig { returns(T.nilable(String)) }
          def account_type; end
          # Name of the bank associated with the bank account.
          sig { returns(T.nilable(String)) }
          def bank_name; end
          # Uniquely identifies this particular bank account. You can use this attribute to check whether two bank accounts are the same.
          sig { returns(T.nilable(String)) }
          def fingerprint; end
          # Last four digits of the bank account number.
          sig { returns(T.nilable(String)) }
          def last4; end
          # ID of the mandate used to make this payment.
          sig { returns(T.nilable(T.any(String, ::Stripe::Mandate))) }
          def mandate; end
          # The network rails used. See the [docs](https://docs.stripe.com/treasury/money-movement/timelines) to learn more about money movement timelines for each network type.
          sig { returns(String) }
          def network; end
          # Routing number of the bank account.
          sig { returns(T.nilable(String)) }
          def routing_number; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field billing_details
        sig { returns(BillingDetails) }
        def billing_details; end
        # The type of the payment method used in the InboundTransfer.
        sig { returns(String) }
        def type; end
        # Attribute for field us_bank_account
        sig { returns(T.nilable(UsBankAccount)) }
        def us_bank_account; end
        def self.inner_class_types
          @inner_class_types = {billing_details: BillingDetails, us_bank_account: UsBankAccount}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StatusTransitions < ::Stripe::StripeObject
        # Timestamp describing when an InboundTransfer changed status to `canceled`.
        sig { returns(T.nilable(Integer)) }
        def canceled_at; end
        # Timestamp describing when an InboundTransfer changed status to `failed`.
        sig { returns(T.nilable(Integer)) }
        def failed_at; end
        # Timestamp describing when an InboundTransfer changed status to `succeeded`.
        sig { returns(T.nilable(Integer)) }
        def succeeded_at; end
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
      # Returns `true` if the InboundTransfer is able to be canceled.
      sig { returns(T::Boolean) }
      def cancelable; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # An arbitrary string attached to the object. Often useful for displaying to users.
      sig { returns(T.nilable(String)) }
      def description; end
      # Details about this InboundTransfer's failure. Only set when status is `failed`.
      sig { returns(T.nilable(FailureDetails)) }
      def failure_details; end
      # The FinancialAccount that received the funds.
      sig { returns(String) }
      def financial_account; end
      # A [hosted transaction receipt](https://docs.stripe.com/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.
      sig { returns(T.nilable(String)) }
      def hosted_regulatory_receipt_url; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Attribute for field linked_flows
      sig { returns(LinkedFlows) }
      def linked_flows; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The origin payment method to be debited for an InboundTransfer.
      sig { returns(T.nilable(String)) }
      def origin_payment_method; end
      # Details about the PaymentMethod for an InboundTransfer.
      sig { returns(T.nilable(OriginPaymentMethodDetails)) }
      def origin_payment_method_details; end
      # Returns `true` if the funds for an InboundTransfer were returned after the InboundTransfer went to the `succeeded` state.
      sig { returns(T.nilable(T::Boolean)) }
      def returned; end
      # Statement descriptor shown when funds are debited from the source. Not all payment networks support `statement_descriptor`.
      sig { returns(String) }
      def statement_descriptor; end
      # Status of the InboundTransfer: `processing`, `succeeded`, `failed`, and `canceled`. An InboundTransfer is `processing` if it is created and pending. The status changes to `succeeded` once the funds have been "confirmed" and a `transaction` is created and posted. The status changes to `failed` if the transfer fails.
      sig { returns(String) }
      def status; end
      # Attribute for field status_transitions
      sig { returns(StatusTransitions) }
      def status_transitions; end
      # The Transaction associated with this object.
      sig { returns(T.nilable(T.any(String, ::Stripe::Treasury::Transaction))) }
      def transaction; end
      # Cancels an InboundTransfer.
      sig {
        params(params: T.any(::Stripe::Treasury::InboundTransferCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
       }
      def cancel(params = {}, opts = {}); end

      # Cancels an InboundTransfer.
      sig {
        params(inbound_transfer: String, params: T.any(::Stripe::Treasury::InboundTransferCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
       }
      def self.cancel(inbound_transfer, params = {}, opts = {}); end

      # Creates an InboundTransfer.
      sig {
        params(params: T.any(::Stripe::Treasury::InboundTransferCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of InboundTransfers sent from the specified FinancialAccount.
      sig {
        params(params: T.any(::Stripe::Treasury::InboundTransferListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end