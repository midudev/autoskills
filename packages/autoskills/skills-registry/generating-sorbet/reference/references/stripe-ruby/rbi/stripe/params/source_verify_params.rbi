# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SourceVerifyParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # The values needed to verify the source.
    sig { returns(T::Array[String]) }
    def values; end
    sig { params(_values: T::Array[String]).returns(T::Array[String]) }
    def values=(_values); end
    sig { params(expand: T.nilable(T::Array[String]), values: T::Array[String]).void }
    def initialize(expand: nil, values: nil); end
  end
end