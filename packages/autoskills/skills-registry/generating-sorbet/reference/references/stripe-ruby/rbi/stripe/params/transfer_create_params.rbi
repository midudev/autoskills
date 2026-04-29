# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TransferCreateParams < ::Stripe::RequestParams
    # A positive integer in cents (or local equivalent) representing how much to transfer.
    sig { returns(T.nilable(Integer)) }
    def amount; end
    sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount=(_amount); end
    # Three-letter [ISO code for currency](https://www.iso.org/iso-4217-currency-codes.html) in lowercase. Must be a [supported currency](https://docs.stripe.com/currencies).
    sig { returns(String) }
    def currency; end
    sig { params(_currency: String).returns(String) }
    def currency=(_currency); end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # The ID of a connected Stripe account. <a href="/docs/connect/separate-charges-and-transfers">See the Connect documentation</a> for details.
    sig { returns(String) }
    def destination; end
    sig { params(_destination: String).returns(String) }
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
    # You can use this parameter to transfer funds from a charge before they are added to your available balance. A pending balance will transfer immediately but the funds will not become available until the original charge becomes available. [See the Connect documentation](https://docs.stripe.com/connect/separate-charges-and-transfers#transfer-availability) for details.
    sig { returns(T.nilable(String)) }
    def source_transaction; end
    sig { params(_source_transaction: T.nilable(String)).returns(T.nilable(String)) }
    def source_transaction=(_source_transaction); end
    # The source balance to use for this transfer. One of `bank_account`, `card`, or `fpx`. For most users, this will default to `card`.
    sig { returns(T.nilable(String)) }
    def source_type; end
    sig { params(_source_type: T.nilable(String)).returns(T.nilable(String)) }
    def source_type=(_source_type); end
    # A string that identifies this transaction as part of a group. See the [Connect documentation](https://docs.stripe.com/connect/separate-charges-and-transfers#transfer-options) for details.
    sig { returns(T.nilable(String)) }
    def transfer_group; end
    sig { params(_transfer_group: T.nilable(String)).returns(T.nilable(String)) }
    def transfer_group=(_transfer_group); end
    sig {
      params(amount: T.nilable(Integer), currency: String, description: T.nilable(String), destination: String, expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), source_transaction: T.nilable(String), source_type: T.nilable(String), transfer_group: T.nilable(String)).void
     }
    def initialize(
      amount: nil,
      currency: nil,
      description: nil,
      destination: nil,
      expand: nil,
      metadata: nil,
      source_transaction: nil,
      source_type: nil,
      transfer_group: nil
    ); end
  end
end