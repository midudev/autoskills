# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentRecordReportPaymentAttemptFailedParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # When the reported payment failed. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def failed_at; end
    sig { params(_failed_at: Integer).returns(Integer) }
    def failed_at=(_failed_at); end
    # Attribute for param field metadata
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    sig {
      params(expand: T.nilable(T::Array[String]), failed_at: Integer, metadata: T.nilable(T.any(String, T::Hash[String, String]))).void
     }
    def initialize(expand: nil, failed_at: nil, metadata: nil); end
  end
end