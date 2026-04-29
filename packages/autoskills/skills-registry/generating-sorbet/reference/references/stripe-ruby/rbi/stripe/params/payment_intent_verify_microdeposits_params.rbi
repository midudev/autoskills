# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentIntentVerifyMicrodepositsParams < ::Stripe::RequestParams
    # Two positive integers, in *cents*, equal to the values of the microdeposits sent to the bank account.
    sig { returns(T.nilable(T::Array[Integer])) }
    def amounts; end
    sig { params(_amounts: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer])) }
    def amounts=(_amounts); end
    # A six-character code starting with SM present in the microdeposit sent to the bank account.
    sig { returns(T.nilable(String)) }
    def descriptor_code; end
    sig { params(_descriptor_code: T.nilable(String)).returns(T.nilable(String)) }
    def descriptor_code=(_descriptor_code); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig {
      params(amounts: T.nilable(T::Array[Integer]), descriptor_code: T.nilable(String), expand: T.nilable(T::Array[String])).void
     }
    def initialize(amounts: nil, descriptor_code: nil, expand: nil); end
  end
end