# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # `Application Fee Refund` objects allow you to refund an application fee that
  # has previously been created but not yet refunded. Funds will be refunded to
  # the Stripe account from which the fee was originally collected.
  #
  # Related guide: [Refunding application fees](https://docs.stripe.com/connect/destination-charges#refunding-app-fee)
  class ApplicationFeeRefund < APIResource
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
    # ID of the application fee that was refunded.
    sig { returns(T.any(String, ::Stripe::ApplicationFee)) }
    def fee; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T.nilable(T::Hash[String, String])) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
  end
end