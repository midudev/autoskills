# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    # A credit balance transaction is a resource representing a transaction (either a credit or a debit) against an existing credit grant.
    class CreditBalanceTransaction < APIResource
      class Credit < ::Stripe::StripeObject
        class Amount < ::Stripe::StripeObject
          class Monetary < ::Stripe::StripeObject
            # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
            sig { returns(String) }
            def currency; end
            # A positive integer representing the amount.
            sig { returns(Integer) }
            def value; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The monetary amount.
          sig { returns(T.nilable(Monetary)) }
          def monetary; end
          # The type of this amount. We currently only support `monetary` billing credits.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {monetary: Monetary}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class CreditsApplicationInvoiceVoided < ::Stripe::StripeObject
          # The invoice to which the reinstated billing credits were originally applied.
          sig { returns(T.any(String, ::Stripe::Invoice)) }
          def invoice; end
          # The invoice line item to which the reinstated billing credits were originally applied.
          sig { returns(String) }
          def invoice_line_item; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field amount
        sig { returns(Amount) }
        def amount; end
        # Details of the invoice to which the reinstated credits were originally applied. Only present if `type` is `credits_application_invoice_voided`.
        sig { returns(T.nilable(CreditsApplicationInvoiceVoided)) }
        def credits_application_invoice_voided; end
        # The type of credit transaction.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {
            amount: Amount,
            credits_application_invoice_voided: CreditsApplicationInvoiceVoided,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Debit < ::Stripe::StripeObject
        class Amount < ::Stripe::StripeObject
          class Monetary < ::Stripe::StripeObject
            # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
            sig { returns(String) }
            def currency; end
            # A positive integer representing the amount.
            sig { returns(Integer) }
            def value; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The monetary amount.
          sig { returns(T.nilable(Monetary)) }
          def monetary; end
          # The type of this amount. We currently only support `monetary` billing credits.
          sig { returns(String) }
          def type; end
          def self.inner_class_types
            @inner_class_types = {monetary: Monetary}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class CreditsApplied < ::Stripe::StripeObject
          # The invoice to which the billing credits were applied.
          sig { returns(T.any(String, ::Stripe::Invoice)) }
          def invoice; end
          # The invoice line item to which the billing credits were applied.
          sig { returns(String) }
          def invoice_line_item; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field amount
        sig { returns(Amount) }
        def amount; end
        # Details of how the billing credits were applied to an invoice. Only present if `type` is `credits_applied`.
        sig { returns(T.nilable(CreditsApplied)) }
        def credits_applied; end
        # The type of debit transaction.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {amount: Amount, credits_applied: CreditsApplied}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Credit details for this credit balance transaction. Only present if type is `credit`.
      sig { returns(T.nilable(Credit)) }
      def credit; end
      # The credit grant associated with this credit balance transaction.
      sig { returns(T.any(String, ::Stripe::Billing::CreditGrant)) }
      def credit_grant; end
      # Debit details for this credit balance transaction. Only present if type is `debit`.
      sig { returns(T.nilable(Debit)) }
      def debit; end
      # The effective time of this credit balance transaction.
      sig { returns(Integer) }
      def effective_at; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # ID of the test clock this credit balance transaction belongs to.
      sig { returns(T.nilable(T.any(String, ::Stripe::TestHelpers::TestClock))) }
      def test_clock; end
      # The type of credit balance transaction (credit or debit).
      sig { returns(T.nilable(String)) }
      def type; end
      # Retrieve a list of credit balance transactions.
      sig {
        params(params: T.any(::Stripe::Billing::CreditBalanceTransactionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end