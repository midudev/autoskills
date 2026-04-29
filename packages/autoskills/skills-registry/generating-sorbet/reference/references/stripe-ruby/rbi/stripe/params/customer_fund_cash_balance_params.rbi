# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerFundCashBalanceParams < ::Stripe::RequestParams
    # Amount to be used for this test cash balance transaction. A positive integer representing how much to fund in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) (e.g., 100 cents to fund $1.00 or 100 to fund ¥100, a zero-decimal currency).
    sig { returns(Integer) }
    def amount; end
    sig { params(_amount: Integer).returns(Integer) }
    def amount=(_amount); end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    sig { params(_currency: String).returns(String) }
    def currency=(_currency); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # A description of the test funding. This simulates free-text references supplied by customers when making bank transfers to their cash balance. You can use this to test how Stripe's [reconciliation algorithm](https://docs.stripe.com/payments/customer-balance/reconciliation) applies to different user inputs.
    sig { returns(T.nilable(String)) }
    def reference; end
    sig { params(_reference: T.nilable(String)).returns(T.nilable(String)) }
    def reference=(_reference); end
    sig {
      params(amount: Integer, currency: String, expand: T.nilable(T::Array[String]), reference: T.nilable(String)).void
     }
    def initialize(amount: nil, currency: nil, expand: nil, reference: nil); end
  end
end