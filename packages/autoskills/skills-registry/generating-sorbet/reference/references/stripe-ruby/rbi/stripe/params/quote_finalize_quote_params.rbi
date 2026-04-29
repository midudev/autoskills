# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class QuoteFinalizeQuoteParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # A future timestamp on which the quote will be canceled if in `open` or `draft` status. Measured in seconds since the Unix epoch.
    sig { returns(T.nilable(Integer)) }
    def expires_at; end
    sig { params(_expires_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def expires_at=(_expires_at); end
    sig { params(expand: T.nilable(T::Array[String]), expires_at: T.nilable(Integer)).void }
    def initialize(expand: nil, expires_at: nil); end
  end
end