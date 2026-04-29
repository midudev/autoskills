# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # [Stripe Connect](https://docs.stripe.com/connect) platforms can reverse transfers made to a
  # connected account, either entirely or partially, and can also specify whether
  # to refund any related application fees. Transfer reversals add to the
  # platform's balance and subtract from the destination account's balance.
  #
  # Reversing a transfer that was made for a [destination
  # charge](https://docs.stripe.com/docs/connect/destination-charges) is allowed only up to the amount of
  # the charge. It is possible to reverse a
  # [transfer_group](https://docs.stripe.com/connect/separate-charges-and-transfers#transfer-options)
  # transfer only if the destination account has enough balance to cover the
  # reversal.
  #
  # Related guide: [Reverse transfers](https://docs.stripe.com/connect/separate-charges-and-transfers#reverse-transfers)
  class Reversal < APIResource
    # Amount, in cents (or local equivalent).
    sig { returns(Integer) }
    def amount; end
    # Balance transaction that describes the impact on your account balance.
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def balance_transaction; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # Linked payment refund for the transfer reversal.
    sig { returns(T.nilable(T.any(String, ::Stripe::Refund))) }
    def destination_payment_refund; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # ID of the refund responsible for the transfer reversal.
    sig { returns(T.nilable(T.any(String, ::Stripe::Refund))) }
    def source_refund; end
    # ID of the transfer that was reversed.
    sig { returns(T.any(String, ::Stripe::Transfer)) }
    def transfer; end
  end
end