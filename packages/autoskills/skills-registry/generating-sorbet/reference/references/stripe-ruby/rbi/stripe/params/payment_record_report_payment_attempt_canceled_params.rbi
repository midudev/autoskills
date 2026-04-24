# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentRecordReportPaymentAttemptCanceledParams < ::Stripe::RequestParams
    # When the reported payment was canceled. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def canceled_at; end
    sig { params(_canceled_at: Integer).returns(Integer) }
    def canceled_at=(_canceled_at); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Attribute for param field metadata
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    sig {
      params(canceled_at: Integer, expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String]))).void
     }
    def initialize(canceled_at: nil, expand: nil, metadata: nil); end
  end
end