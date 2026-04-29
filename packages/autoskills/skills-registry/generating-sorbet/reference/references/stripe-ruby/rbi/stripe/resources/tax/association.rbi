# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    # A Tax Association exposes the Tax Transactions that Stripe attempted to create on your behalf based on the PaymentIntent input
    class Association < APIResource
      class TaxTransactionAttempt < ::Stripe::StripeObject
        class Committed < ::Stripe::StripeObject
          # The [Tax Transaction](https://docs.stripe.com/api/tax/transaction/object)
          sig { returns(String) }
          def transaction; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Errored < ::Stripe::StripeObject
          # Details on why we couldn't commit the tax transaction.
          sig { returns(String) }
          def reason; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field committed
        sig { returns(T.nilable(Committed)) }
        def committed; end
        # Attribute for field errored
        sig { returns(T.nilable(Errored)) }
        def errored; end
        # The source of the tax transaction attempt. This is either a refund or a payment intent.
        sig { returns(String) }
        def source; end
        # The status of the transaction attempt. This can be `errored` or `committed`.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {committed: Committed, errored: Errored}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The [Tax Calculation](https://docs.stripe.com/api/tax/calculations/object) that was included in PaymentIntent.
      sig { returns(String) }
      def calculation; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The [PaymentIntent](https://docs.stripe.com/api/payment_intents/object) that this Tax Association is tracking.
      sig { returns(String) }
      def payment_intent; end
      # Information about the tax transactions linked to this payment intent
      sig { returns(T.nilable(T::Array[TaxTransactionAttempt])) }
      def tax_transaction_attempts; end
      # Finds a tax association object by PaymentIntent id.
      sig {
        params(params: T.any(::Stripe::Tax::AssociationFindParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Tax::Association)
       }
      def self.find(params = {}, opts = {}); end
    end
  end
end