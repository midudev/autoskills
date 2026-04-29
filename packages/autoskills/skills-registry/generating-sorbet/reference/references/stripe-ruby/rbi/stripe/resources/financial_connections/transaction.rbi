# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    # A Transaction represents a real transaction that affects a Financial Connections Account balance.
    class Transaction < APIResource
      class StatusTransitions < ::Stripe::StripeObject
        # Time at which this transaction posted. Measured in seconds since the Unix epoch.
        sig { returns(T.nilable(Integer)) }
        def posted_at; end
        # Time at which this transaction was voided. Measured in seconds since the Unix epoch.
        sig { returns(T.nilable(Integer)) }
        def void_at; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The ID of the Financial Connections Account this transaction belongs to.
      sig { returns(String) }
      def account; end
      # The amount of this transaction, in cents (or local equivalent).
      sig { returns(Integer) }
      def amount; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # The description of this transaction.
      sig { returns(String) }
      def description; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The status of the transaction.
      sig { returns(String) }
      def status; end
      # Attribute for field status_transitions
      sig { returns(StatusTransitions) }
      def status_transitions; end
      # Time at which the transaction was transacted. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def transacted_at; end
      # The token of the transaction refresh that last updated or created this transaction.
      sig { returns(String) }
      def transaction_refresh; end
      # Time at which the object was last updated. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def updated; end
      # Returns a list of Financial Connections Transaction objects.
      sig {
        params(params: T.any(::Stripe::FinancialConnections::TransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end