# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    # Use [OutboundPayments](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/out-of/outbound-payments) to send funds to another party's external bank account or [FinancialAccount](https://api.stripe.com#financial_accounts). To send money to an account belonging to the same user, use an [OutboundTransfer](https://api.stripe.com#outbound_transfers).
    #
    # Simulate OutboundPayment state changes with the `/v1/test_helpers/treasury/outbound_payments` endpoints. These methods can only be called on test mode objects.
    #
    # Related guide: [Moving money with Treasury using OutboundPayment objects](https://docs.stripe.com/docs/treasury/moving-money/financial-accounts/out-of/outbound-payments)
    class OutboundPayment < APIResource
      class DestinationPaymentMethodDetails < ::Stripe::StripeObject
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
          # Token of the FinancialAccount.
          sig { returns(String) }
          def id; end
          # The rails used to send funds.
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
        # Attribute for field financial_account
        sig { returns(T.nilable(FinancialAccount)) }
        def financial_account; end
        # The type of the payment method used in the OutboundPayment.
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
      class EndUserDetails < ::Stripe::StripeObject
        # IP address of the user initiating the OutboundPayment. Set if `present` is set to `true`. IP address collection is required for risk and compliance reasons. This will be used to help determine if the OutboundPayment is authorized or should be blocked.
        sig { returns(T.nilable(String)) }
        def ip_address; end
        # `true` if the OutboundPayment creation request is being made on behalf of an end user by a platform. Otherwise, `false`.
        sig { returns(T::Boolean) }
        def present; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ReturnedDetails < ::Stripe::StripeObject
        # Reason for the return.
        sig { returns(String) }
        def code; end
        # The Transaction associated with this object.
        sig { returns(T.any(String, ::Stripe::Treasury::Transaction)) }
        def transaction; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StatusTransitions < ::Stripe::StripeObject
        # Timestamp describing when an OutboundPayment changed status to `canceled`.
        sig { returns(T.nilable(Integer)) }
        def canceled_at; end
        # Timestamp describing when an OutboundPayment changed status to `failed`.
        sig { returns(T.nilable(Integer)) }
        def failed_at; end
        # Timestamp describing when an OutboundPayment changed status to `posted`.
        sig { returns(T.nilable(Integer)) }
        def posted_at; end
        # Timestamp describing when an OutboundPayment changed status to `returned`.
        sig { returns(T.nilable(Integer)) }
        def returned_at; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class TrackingDetails < ::Stripe::StripeObject
        class Ach < ::Stripe::StripeObject
          # ACH trace ID of the OutboundPayment for payments sent over the `ach` network.
          sig { returns(String) }
          def trace_id; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class UsDomesticWire < ::Stripe::StripeObject
          # CHIPS System Sequence Number (SSN) of the OutboundPayment for payments sent over the `us_domestic_wire` network.
          sig { returns(T.nilable(String)) }
          def chips; end
          # IMAD of the OutboundPayment for payments sent over the `us_domestic_wire` network.
          sig { returns(T.nilable(String)) }
          def imad; end
          # OMAD of the OutboundPayment for payments sent over the `us_domestic_wire` network.
          sig { returns(T.nilable(String)) }
          def omad; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field ach
        sig { returns(T.nilable(Ach)) }
        def ach; end
        # The US bank account network used to send funds.
        sig { returns(String) }
        def type; end
        # Attribute for field us_domestic_wire
        sig { returns(T.nilable(UsDomesticWire)) }
        def us_domestic_wire; end
        def self.inner_class_types
          @inner_class_types = {ach: Ach, us_domestic_wire: UsDomesticWire}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Amount (in cents) transferred.
      sig { returns(Integer) }
      def amount; end
      # Returns `true` if the object can be canceled, and `false` otherwise.
      sig { returns(T::Boolean) }
      def cancelable; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # ID of the [customer](https://docs.stripe.com/api/customers) to whom an OutboundPayment is sent.
      sig { returns(T.nilable(String)) }
      def customer; end
      # An arbitrary string attached to the object. Often useful for displaying to users.
      sig { returns(T.nilable(String)) }
      def description; end
      # The PaymentMethod via which an OutboundPayment is sent. This field can be empty if the OutboundPayment was created using `destination_payment_method_data`.
      sig { returns(T.nilable(String)) }
      def destination_payment_method; end
      # Details about the PaymentMethod for an OutboundPayment.
      sig { returns(T.nilable(DestinationPaymentMethodDetails)) }
      def destination_payment_method_details; end
      # Details about the end user.
      sig { returns(T.nilable(EndUserDetails)) }
      def end_user_details; end
      # The date when funds are expected to arrive in the destination account.
      sig { returns(Integer) }
      def expected_arrival_date; end
      # The FinancialAccount that funds were pulled from.
      sig { returns(String) }
      def financial_account; end
      # A [hosted transaction receipt](https://docs.stripe.com/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.
      sig { returns(T.nilable(String)) }
      def hosted_regulatory_receipt_url; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Details about a returned OutboundPayment. Only set when the status is `returned`.
      sig { returns(T.nilable(ReturnedDetails)) }
      def returned_details; end
      # The description that appears on the receiving end for an OutboundPayment (for example, bank statement for external bank transfer).
      sig { returns(String) }
      def statement_descriptor; end
      # Current status of the OutboundPayment: `processing`, `failed`, `posted`, `returned`, `canceled`. An OutboundPayment is `processing` if it has been created and is pending. The status changes to `posted` once the OutboundPayment has been "confirmed" and funds have left the account, or to `failed` or `canceled`. If an OutboundPayment fails to arrive at its destination, its status will change to `returned`.
      sig { returns(String) }
      def status; end
      # Attribute for field status_transitions
      sig { returns(StatusTransitions) }
      def status_transitions; end
      # Details about network-specific tracking information if available.
      sig { returns(T.nilable(TrackingDetails)) }
      def tracking_details; end
      # The Transaction associated with this object.
      sig { returns(T.any(String, ::Stripe::Treasury::Transaction)) }
      def transaction; end
      # Cancel an OutboundPayment.
      sig {
        params(params: T.any(::Stripe::Treasury::OutboundPaymentCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
       }
      def cancel(params = {}, opts = {}); end

      # Cancel an OutboundPayment.
      sig {
        params(id: String, params: T.any(::Stripe::Treasury::OutboundPaymentCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
       }
      def self.cancel(id, params = {}, opts = {}); end

      # Creates an OutboundPayment.
      sig {
        params(params: T.any(::Stripe::Treasury::OutboundPaymentCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of OutboundPayments sent from the specified FinancialAccount.
      sig {
        params(params: T.any(::Stripe::Treasury::OutboundPaymentListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end