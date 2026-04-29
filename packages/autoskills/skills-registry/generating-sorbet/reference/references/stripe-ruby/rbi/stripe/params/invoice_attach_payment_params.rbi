# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceAttachPaymentParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # The ID of the PaymentIntent to attach to the invoice.
    sig { returns(T.nilable(String)) }
    def payment_intent; end
    sig { params(_payment_intent: T.nilable(String)).returns(T.nilable(String)) }
    def payment_intent=(_payment_intent); end
    # The ID of the PaymentRecord to attach to the invoice.
    sig { returns(T.nilable(String)) }
    def payment_record; end
    sig { params(_payment_record: T.nilable(String)).returns(T.nilable(String)) }
    def payment_record=(_payment_record); end
    sig {
      params(expand: T.nilable(T::Array[String]), payment_intent: T.nilable(String), payment_record: T.nilable(String)).void
     }
    def initialize(expand: nil, payment_intent: nil, payment_record: nil); end
  end
end