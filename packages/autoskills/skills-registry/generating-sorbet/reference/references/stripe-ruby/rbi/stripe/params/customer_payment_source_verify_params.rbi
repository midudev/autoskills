# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerPaymentSourceVerifyParams < ::Stripe::RequestParams
    # Two positive integers, in *cents*, equal to the values of the microdeposits sent to the bank account.
    sig { returns(T.nilable(T::Array[Integer])) }
    def amounts; end
    sig { params(_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer])) }
    def amounts=(_amounts); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig { params(amounts: T.nilable(T::Array[Integer]), expand: T.nilable(T::Array[String])).void }
    def initialize(amounts: nil, expand: nil); end
  end
end