# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class TransactionCreateFromCalculationParams < ::Stripe::RequestParams
      # Tax Calculation ID to be used as input when creating the transaction.
      sig { returns(String) }
      def calculation; end
      sig { params(_calculation: String).returns(String) }
      def calculation=(_calculation); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The Unix timestamp representing when the tax liability is assumed or reduced, which determines the liability posting period and handling in tax liability reports. The timestamp must fall within the `tax_date` and the current time, unless the `tax_date` is scheduled in advance. Defaults to the current time.
      sig { returns(T.nilable(Integer)) }
      def posted_at; end
      sig { params(_posted_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def posted_at=(_posted_at); end
      # A custom order or sale identifier, such as 'myOrder_123'. Must be unique across all transactions, including reversals.
      sig { returns(String) }
      def reference; end
      sig { params(_reference: String).returns(String) }
      def reference=(_reference); end
      sig {
        params(calculation: String, expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), posted_at: T.nilable(Integer), reference: String).void
       }
      def initialize(
        calculation: nil,
        expand: nil,
        metadata: nil,
        posted_at: nil,
        reference: nil
      ); end
    end
  end
end