# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PayoutCreateParams < ::Stripe::RequestParams
    # A positive integer in cents representing how much to payout.
    sig { returns(Integer) }
    def amount; end
    sig { params(_amount: Integer).returns(Integer) }
    def amount=(_amount); end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    sig { params(_currency: String).returns(String) }
    def currency=(_currency); end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # The ID of a bank account or a card to send the payout to. If you don't provide a destination, we use the default external account for the specified currency.
    sig { returns(T.nilable(String)) }
    def destination; end
    sig { params(_destination: T.nilable(String)).returns(T.nilable(String)) }
    def destination=(_destination); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
     }
    def metadata=(_metadata); end
    # The method used to send this payout, which is `standard` or `instant`. We support `instant` for payouts to debit cards and bank accounts in certain countries. Learn more about [bank support for Instant Payouts](https://stripe.com/docs/payouts/instant-payouts-banks).
    sig { returns(T.nilable(String)) }
    def method; end
    sig { params(_method: T.nilable(String)).returns(T.nilable(String)) }
    def method=(_method); end
    # The ID of a v2 FinancialAccount to send funds to.
    sig { returns(T.nilable(String)) }
    def payout_method; end
    sig { params(_payout_method: T.nilable(String)).returns(T.nilable(String)) }
    def payout_method=(_payout_method); end
    # The balance type of your Stripe balance to draw this payout from. Balances for different payment sources are kept separately. You can find the amounts with the Balances API. One of `bank_account`, `card`, or `fpx`.
    sig { returns(T.nilable(String)) }
    def source_type; end
    sig { params(_source_type: T.nilable(String)).returns(T.nilable(String)) }
    def source_type=(_source_type); end
    # A string that displays on the recipient's bank or card statement (up to 22 characters). A `statement_descriptor` that's longer than 22 characters return an error. Most banks truncate this information and display it inconsistently. Some banks might not display it at all.
    sig { returns(T.nilable(String)) }
    def statement_descriptor; end
    sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
    def statement_descriptor=(_statement_descriptor); end
    sig {
      params(amount: Integer, currency: String, description: T.nilable(String), destination: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), method: T.nilable(String), payout_method: T.nilable(String), source_type: T.nilable(String), statement_descriptor: T.nilable(String)).void
     }
    def initialize(
      amount: nil,
      currency: nil,
      description: nil,
      destination: nil,
      expand: nil,
      metadata: nil,
      method: nil,
      payout_method: nil,
      source_type: nil,
      statement_descriptor: nil
    ); end
  end
end