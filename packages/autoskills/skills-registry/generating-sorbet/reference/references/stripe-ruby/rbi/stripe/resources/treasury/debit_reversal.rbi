# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    # You can reverse some [ReceivedDebits](https://api.stripe.com#received_debits) depending on their network and source flow. Reversing a ReceivedDebit leads to the creation of a new object known as a DebitReversal.
    class DebitReversal < APIResource
      class LinkedFlows < ::Stripe::StripeObject
        # Set if there is an Issuing dispute associated with the DebitReversal.
        sig { returns(T.nilable(String)) }
        def issuing_dispute; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StatusTransitions < ::Stripe::StripeObject
        # Timestamp describing when the DebitReversal changed status to `completed`.
        sig { returns(T.nilable(Integer)) }
        def completed_at; end
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
      # The FinancialAccount to reverse funds from.
      sig { returns(T.nilable(String)) }
      def financial_account; end
      # A [hosted transaction receipt](https://docs.stripe.com/treasury/moving-money/regulatory-receipts) URL that is provided when money movement is considered regulated under Stripe's money transmission licenses.
      sig { returns(T.nilable(String)) }
      def hosted_regulatory_receipt_url; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Other flows linked to a DebitReversal.
      sig { returns(T.nilable(LinkedFlows)) }
      def linked_flows; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # The rails used to reverse the funds.
      sig { returns(String) }
      def network; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The ReceivedDebit being reversed.
      sig { returns(String) }
      def received_debit; end
      # Status of the DebitReversal
      sig { returns(String) }
      def status; end
      # Attribute for field status_transitions
      sig { returns(StatusTransitions) }
      def status_transitions; end
      # The Transaction associated with this object.
      sig { returns(T.nilable(T.any(String, ::Stripe::Treasury::Transaction))) }
      def transaction; end
      # Reverses a ReceivedDebit and creates a DebitReversal object.
      sig {
        params(params: T.any(::Stripe::Treasury::DebitReversalCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::DebitReversal)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of DebitReversals.
      sig {
        params(params: T.any(::Stripe::Treasury::DebitReversalListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end