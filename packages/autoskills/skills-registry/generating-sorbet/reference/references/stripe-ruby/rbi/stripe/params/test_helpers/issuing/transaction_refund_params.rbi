# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Issuing
      class TransactionRefundParams < ::Stripe::RequestParams
        # Specifies which fields in the response should be expanded.
        sig { returns(T.nilable(T::Array[String])) }
        def expand; end
        sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def expand=(_expand); end
        # The total amount to attempt to refund. This amount is in the provided currency, or defaults to the cards currency, and in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal).
        sig { returns(T.nilable(Integer)) }
        def refund_amount; end
        sig { params(_refund_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def refund_amount=(_refund_amount); end
        sig { params(expand: T.nilable(T::Array[String]), refund_amount: T.nilable(Integer)).void }
        def initialize(expand: nil, refund_amount: nil); end
      end
    end
  end
end