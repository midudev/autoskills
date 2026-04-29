# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Customers with certain payments enabled have a cash balance, representing funds that were paid
  # by the customer to a merchant, but have not yet been allocated to a payment. Cash Balance Transactions
  # represent when funds are moved into or out of this balance. This includes funding by the customer, allocation
  # to payments, and refunds to the customer.
  class CustomerCashBalanceTransaction < APIResource
    class AdjustedForOverdraft < ::Stripe::StripeObject
      # The [Balance Transaction](https://docs.stripe.com/api/balance_transactions/object) that corresponds to funds taken out of your Stripe balance.
      sig { returns(T.any(String, ::Stripe::BalanceTransaction)) }
      def balance_transaction; end
      # The [Cash Balance Transaction](https://docs.stripe.com/api/cash_balance_transactions/object) that brought the customer balance negative, triggering the clawback of funds.
      sig { returns(T.any(String, ::Stripe::CustomerCashBalanceTransaction)) }
      def linked_transaction; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class AppliedToPayment < ::Stripe::StripeObject
      # The [Payment Intent](https://docs.stripe.com/api/payment_intents/object) that funds were applied to.
      sig { returns(T.any(String, ::Stripe::PaymentIntent)) }
      def payment_intent; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Funded < ::Stripe::StripeObject
      class BankTransfer < ::Stripe::StripeObject
        class EuBankTransfer < ::Stripe::StripeObject
          # The BIC of the bank of the sender of the funding.
          sig { returns(T.nilable(String)) }
          def bic; end
          # The last 4 digits of the IBAN of the sender of the funding.
          sig { returns(T.nilable(String)) }
          def iban_last4; end
          # The full name of the sender, as supplied by the sending bank.
          sig { returns(T.nilable(String)) }
          def sender_name; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class GbBankTransfer < ::Stripe::StripeObject
          # The last 4 digits of the account number of the sender of the funding.
          sig { returns(T.nilable(String)) }
          def account_number_last4; end
          # The full name of the sender, as supplied by the sending bank.
          sig { returns(T.nilable(String)) }
          def sender_name; end
          # The sort code of the bank of the sender of the funding
          sig { returns(T.nilable(String)) }
          def sort_code; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class JpBankTransfer < ::Stripe::StripeObject
          # The name of the bank of the sender of the funding.
          sig { returns(T.nilable(String)) }
          def sender_bank; end
          # The name of the bank branch of the sender of the funding.
          sig { returns(T.nilable(String)) }
          def sender_branch; end
          # The full name of the sender, as supplied by the sending bank.
          sig { returns(T.nilable(String)) }
          def sender_name; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class UsBankTransfer < ::Stripe::StripeObject
          # The banking network used for this funding.
          sig { returns(T.nilable(String)) }
          def network; end
          # The full name of the sender, as supplied by the sending bank.
          sig { returns(T.nilable(String)) }
          def sender_name; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field eu_bank_transfer
        sig { returns(T.nilable(EuBankTransfer)) }
        def eu_bank_transfer; end
        # Attribute for field gb_bank_transfer
        sig { returns(T.nilable(GbBankTransfer)) }
        def gb_bank_transfer; end
        # Attribute for field jp_bank_transfer
        sig { returns(T.nilable(JpBankTransfer)) }
        def jp_bank_transfer; end
        # The user-supplied reference field on the bank transfer.
        sig { returns(T.nilable(String)) }
        def reference; end
        # The funding method type used to fund the customer balance. Permitted values include: `eu_bank_transfer`, `gb_bank_transfer`, `jp_bank_transfer`, `mx_bank_transfer`, or `us_bank_transfer`.
        sig { returns(String) }
        def type; end
        # Attribute for field us_bank_transfer
        sig { returns(T.nilable(UsBankTransfer)) }
        def us_bank_transfer; end
        def self.inner_class_types
          @inner_class_types = {
            eu_bank_transfer: EuBankTransfer,
            gb_bank_transfer: GbBankTransfer,
            jp_bank_transfer: JpBankTransfer,
            us_bank_transfer: UsBankTransfer,
          }
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field bank_transfer
      sig { returns(BankTransfer) }
      def bank_transfer; end
      def self.inner_class_types
        @inner_class_types = {bank_transfer: BankTransfer}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class RefundedFromPayment < ::Stripe::StripeObject
      # The [Refund](https://docs.stripe.com/api/refunds/object) that moved these funds into the customer's cash balance.
      sig { returns(T.any(String, ::Stripe::Refund)) }
      def refund; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class TransferredToBalance < ::Stripe::StripeObject
      # The [Balance Transaction](https://docs.stripe.com/api/balance_transactions/object) that corresponds to funds transferred to your Stripe balance.
      sig { returns(T.any(String, ::Stripe::BalanceTransaction)) }
      def balance_transaction; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class UnappliedFromPayment < ::Stripe::StripeObject
      # The [Payment Intent](https://docs.stripe.com/api/payment_intents/object) that funds were unapplied from.
      sig { returns(T.any(String, ::Stripe::PaymentIntent)) }
      def payment_intent; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Attribute for field adjusted_for_overdraft
    sig { returns(T.nilable(AdjustedForOverdraft)) }
    def adjusted_for_overdraft; end
    # Attribute for field applied_to_payment
    sig { returns(T.nilable(AppliedToPayment)) }
    def applied_to_payment; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # The customer whose available cash balance changed as a result of this transaction.
    sig { returns(T.any(String, ::Stripe::Customer)) }
    def customer; end
    # The ID of an Account representing a customer whose available cash balance changed as a result of this transaction.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # The total available cash balance for the specified currency after this transaction was applied. Represented in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
    sig { returns(Integer) }
    def ending_balance; end
    # Attribute for field funded
    sig { returns(T.nilable(Funded)) }
    def funded; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # The amount by which the cash balance changed, represented in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal). A positive value represents funds being added to the cash balance, a negative value represents funds being removed from the cash balance.
    sig { returns(Integer) }
    def net_amount; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Attribute for field refunded_from_payment
    sig { returns(T.nilable(RefundedFromPayment)) }
    def refunded_from_payment; end
    # Attribute for field transferred_to_balance
    sig { returns(T.nilable(TransferredToBalance)) }
    def transferred_to_balance; end
    # The type of the cash balance transaction. New types may be added in future. See [Customer Balance](https://docs.stripe.com/payments/customer-balance#types) to learn more about these types.
    sig { returns(String) }
    def type; end
    # Attribute for field unapplied_from_payment
    sig { returns(T.nilable(UnappliedFromPayment)) }
    def unapplied_from_payment; end
  end
end