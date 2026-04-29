# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceRemoveLinesParams < ::Stripe::RequestParams
    class Line < ::Stripe::RequestParams
      # Either `delete` or `unassign`. Deleted line items are permanently deleted. Unassigned line items can be reassigned to an invoice.
      sig { returns(String) }
      def behavior; end
      sig { params(_behavior: String).returns(String) }
      def behavior=(_behavior); end
      # ID of an existing line item to remove from this invoice.
      sig { returns(String) }
      def id; end
      sig { params(_id: String).returns(String) }
      def id=(_id); end
      sig { params(behavior: String, id: String).void }
      def initialize(behavior: nil, id: nil); end
    end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def invoice_metadata; end
    sig {
      params(_invoice_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def invoice_metadata=(_invoice_metadata); end
    # The line items to remove.
    sig { returns(T::Array[InvoiceRemoveLinesParams::Line]) }
    def lines; end
    sig {
      params(_lines: T::Array[InvoiceRemoveLinesParams::Line]).returns(T::Array[InvoiceRemoveLinesParams::Line])
     }
    def lines=(_lines); end
    sig {
      params(expand: T.nilable(T::Array[String]), invoice_metadata: T.nilable(T.any(String, T::Hash[String, String])), lines: T::Array[InvoiceRemoveLinesParams::Line]).void
     }
    def initialize(expand: nil, invoice_metadata: nil, lines: nil); end
  end
end