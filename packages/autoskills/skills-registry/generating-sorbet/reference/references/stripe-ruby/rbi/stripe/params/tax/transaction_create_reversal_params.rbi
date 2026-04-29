# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class TransactionCreateReversalParams < ::Stripe::RequestParams
      class LineItem < ::Stripe::RequestParams
        # The amount to reverse, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) in negative.
        sig { returns(Integer) }
        def amount; end
        sig { params(_amount: Integer).returns(Integer) }
        def amount=(_amount); end
        # The amount of tax to reverse, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) in negative.
        sig { returns(Integer) }
        def amount_tax; end
        sig { params(_amount_tax: Integer).returns(Integer) }
        def amount_tax=(_amount_tax); end
        # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
        sig { returns(T.nilable(T::Hash[String, String])) }
        def metadata; end
        sig {
          params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
         }
        def metadata=(_metadata); end
        # The `id` of the line item to reverse in the original transaction.
        sig { returns(String) }
        def original_line_item; end
        sig { params(_original_line_item: String).returns(String) }
        def original_line_item=(_original_line_item); end
        # The quantity reversed. Appears in [tax exports](https://docs.stripe.com/tax/reports), but does not affect the amount of tax reversed.
        sig { returns(T.nilable(Integer)) }
        def quantity; end
        sig { params(_quantity: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def quantity=(_quantity); end
        # A custom identifier for this line item in the reversal transaction, such as 'L1-refund'.
        sig { returns(String) }
        def reference; end
        sig { params(_reference: String).returns(String) }
        def reference=(_reference); end
        sig {
          params(amount: Integer, amount_tax: Integer, metadata: T.nilable(T::Hash[String, String]), original_line_item: String, quantity: T.nilable(Integer), reference: String).void
         }
        def initialize(
          amount: nil,
          amount_tax: nil,
          metadata: nil,
          original_line_item: nil,
          quantity: nil,
          reference: nil
        ); end
      end
      class ShippingCost < ::Stripe::RequestParams
        # The amount to reverse, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) in negative.
        sig { returns(Integer) }
        def amount; end
        sig { params(_amount: Integer).returns(Integer) }
        def amount=(_amount); end
        # The amount of tax to reverse, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) in negative.
        sig { returns(Integer) }
        def amount_tax; end
        sig { params(_amount_tax: Integer).returns(Integer) }
        def amount_tax=(_amount_tax); end
        sig { params(amount: Integer, amount_tax: Integer).void }
        def initialize(amount: nil, amount_tax: nil); end
      end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A flat amount to reverse across the entire transaction, in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) in negative. This value represents the total amount to refund from the transaction, including taxes.
      sig { returns(T.nilable(Integer)) }
      def flat_amount; end
      sig { params(_flat_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def flat_amount=(_flat_amount); end
      # The line item amounts to reverse.
      sig { returns(T.nilable(T::Array[Tax::TransactionCreateReversalParams::LineItem])) }
      def line_items; end
      sig {
        params(_line_items: T.nilable(T::Array[Tax::TransactionCreateReversalParams::LineItem])).returns(T.nilable(T::Array[Tax::TransactionCreateReversalParams::LineItem]))
       }
      def line_items=(_line_items); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # If `partial`, the provided line item or shipping cost amounts are reversed. If `full`, the original transaction is fully reversed.
      sig { returns(String) }
      def mode; end
      sig { params(_mode: String).returns(String) }
      def mode=(_mode); end
      # The ID of the Transaction to partially or fully reverse.
      sig { returns(String) }
      def original_transaction; end
      sig { params(_original_transaction: String).returns(String) }
      def original_transaction=(_original_transaction); end
      # A custom identifier for this reversal, such as `myOrder_123-refund_1`, which must be unique across all transactions. The reference helps identify this reversal transaction in exported [tax reports](https://docs.stripe.com/tax/reports).
      sig { returns(String) }
      def reference; end
      sig { params(_reference: String).returns(String) }
      def reference=(_reference); end
      # The shipping cost to reverse.
      sig { returns(T.nilable(Tax::TransactionCreateReversalParams::ShippingCost)) }
      def shipping_cost; end
      sig {
        params(_shipping_cost: T.nilable(Tax::TransactionCreateReversalParams::ShippingCost)).returns(T.nilable(Tax::TransactionCreateReversalParams::ShippingCost))
       }
      def shipping_cost=(_shipping_cost); end
      sig {
        params(expand: T.nilable(T::Array[String]), flat_amount: T.nilable(Integer), line_items: T.nilable(T::Array[Tax::TransactionCreateReversalParams::LineItem]), metadata: T.nilable(T::Hash[String, String]), mode: String, original_transaction: String, reference: String, shipping_cost: T.nilable(Tax::TransactionCreateReversalParams::ShippingCost)).void
       }
      def initialize(
        expand: nil,
        flat_amount: nil,
        line_items: nil,
        metadata: nil,
        mode: nil,
        original_transaction: nil,
        reference: nil,
        shipping_cost: nil
      ); end
    end
  end
end