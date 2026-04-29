# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ReserveTransaction < APIResource
    # Attribute for field amount
    sig { returns(Integer) }
    def amount; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # An arbitrary string attached to the object. Often useful for displaying to users.
    sig { returns(T.nilable(String)) }
    def description; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
  end
end