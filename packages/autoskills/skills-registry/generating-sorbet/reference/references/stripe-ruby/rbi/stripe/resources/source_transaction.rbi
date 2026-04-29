# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Some payment methods have no required amount that a customer must send.
  # Customers can be instructed to send any amount, and it can be made up of
  # multiple transactions. As such, sources can have multiple associated
  # transactions.
  class SourceTransaction < StripeObject
    class AchCreditTransfer < ::Stripe::StripeObject
      # Customer data associated with the transfer.
      sig { returns(T.nilable(String)) }
      def customer_data; end
      # Bank account fingerprint associated with the transfer.
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # Last 4 digits of the account number associated with the transfer.
      sig { returns(T.nilable(String)) }
      def last4; end
      # Routing number associated with the transfer.
      sig { returns(T.nilable(String)) }
      def routing_number; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class ChfCreditTransfer < ::Stripe::StripeObject
      # Reference associated with the transfer.
      sig { returns(T.nilable(String)) }
      def reference; end
      # Sender's country address.
      sig { returns(T.nilable(String)) }
      def sender_address_country; end
      # Sender's line 1 address.
      sig { returns(T.nilable(String)) }
      def sender_address_line1; end
      # Sender's bank account IBAN.
      sig { returns(T.nilable(String)) }
      def sender_iban; end
      # Sender's name.
      sig { returns(T.nilable(String)) }
      def sender_name; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class GbpCreditTransfer < ::Stripe::StripeObject
      # Bank account fingerprint associated with the Stripe owned bank account receiving the transfer.
      sig { returns(T.nilable(String)) }
      def fingerprint; end
      # The credit transfer rails the sender used to push this transfer. The possible rails are: Faster Payments, BACS, CHAPS, and wire transfers. Currently only Faster Payments is supported.
      sig { returns(T.nilable(String)) }
      def funding_method; end
      # Last 4 digits of sender account number associated with the transfer.
      sig { returns(T.nilable(String)) }
      def last4; end
      # Sender entered arbitrary information about the transfer.
      sig { returns(T.nilable(String)) }
      def reference; end
      # Sender account number associated with the transfer.
      sig { returns(T.nilable(String)) }
      def sender_account_number; end
      # Sender name associated with the transfer.
      sig { returns(T.nilable(String)) }
      def sender_name; end
      # Sender sort code associated with the transfer.
      sig { returns(T.nilable(String)) }
      def sender_sort_code; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class PaperCheck < ::Stripe::StripeObject
      # Time at which the deposited funds will be available for use. Measured in seconds since the Unix epoch.
      sig { returns(T.nilable(String)) }
      def available_at; end
      # Comma-separated list of invoice IDs associated with the paper check.
      sig { returns(T.nilable(String)) }
      def invoices; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class SepaCreditTransfer < ::Stripe::StripeObject
      # Reference associated with the transfer.
      sig { returns(T.nilable(String)) }
      def reference; end
      # Sender's bank account IBAN.
      sig { returns(T.nilable(String)) }
      def sender_iban; end
      # Sender's name.
      sig { returns(T.nilable(String)) }
      def sender_name; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Attribute for field ach_credit_transfer
    sig { returns(T.nilable(AchCreditTransfer)) }
    def ach_credit_transfer; end
    # A positive integer in the smallest currency unit (that is, 100 cents for $1.00, or 1 for ¥1, Japanese Yen being a zero-decimal currency) representing the amount your customer has pushed to the receiver.
    sig { returns(Integer) }
    def amount; end
    # Attribute for field chf_credit_transfer
    sig { returns(T.nilable(ChfCreditTransfer)) }
    def chf_credit_transfer; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # Attribute for field gbp_credit_transfer
    sig { returns(T.nilable(GbpCreditTransfer)) }
    def gbp_credit_transfer; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Attribute for field paper_check
    sig { returns(T.nilable(PaperCheck)) }
    def paper_check; end
    # Attribute for field sepa_credit_transfer
    sig { returns(T.nilable(SepaCreditTransfer)) }
    def sepa_credit_transfer; end
    # The ID of the source this transaction is attached to.
    sig { returns(String) }
    def source; end
    # The status of the transaction, one of `succeeded`, `pending`, or `failed`.
    sig { returns(String) }
    def status; end
    # The type of source this transaction is attached to.
    sig { returns(String) }
    def type; end
  end
end