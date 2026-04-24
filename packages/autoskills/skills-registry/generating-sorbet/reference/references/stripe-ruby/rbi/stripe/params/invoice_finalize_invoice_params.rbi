# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceFinalizeInvoiceParams < ::Stripe::RequestParams
    # Controls whether Stripe performs [automatic collection](https://docs.stripe.com/invoicing/integration/automatic-advancement-collection) of the invoice. If `false`, the invoice's state doesn't automatically advance without an explicit action.
    sig { returns(T.nilable(T::Boolean)) }
    def auto_advance; end
    sig { params(_auto_advance: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def auto_advance=(_auto_advance); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig { params(auto_advance: T.nilable(T::Boolean), expand: T.nilable(T::Array[String])).void }
    def initialize(auto_advance: nil, expand: nil); end
  end
end