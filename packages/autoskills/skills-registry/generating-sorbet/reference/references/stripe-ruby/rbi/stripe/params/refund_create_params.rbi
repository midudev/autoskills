# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class RefundCreateParams < ::Stripe::RequestParams
    # Attribute for param field amount
    sig { returns(T.nilable(Integer)) }
    def amount; end
    sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def amount=(_amount); end
    # The identifier of the charge to refund.
    sig { returns(T.nilable(String)) }
    def charge; end
    sig { params(_charge: T.nilable(String)).returns(T.nilable(String)) }
    def charge=(_charge); end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(T.nilable(String)) }
    def currency; end
    sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
    def currency=(_currency); end
    # Customer whose customer balance to refund from.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # For payment methods without native refund support (e.g., Konbini, PromptPay), use this email from the customer to receive refund instructions.
    sig { returns(T.nilable(String)) }
    def instructions_email; end
    sig { params(_instructions_email: T.nilable(String)).returns(T.nilable(String)) }
    def instructions_email=(_instructions_email); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # Origin of the refund
    sig { returns(T.nilable(String)) }
    def origin; end
    sig { params(_origin: T.nilable(String)).returns(T.nilable(String)) }
    def origin=(_origin); end
    # The identifier of the PaymentIntent to refund.
    sig { returns(T.nilable(String)) }
    def payment_intent; end
    sig { params(_payment_intent: T.nilable(String)).returns(T.nilable(String)) }
    def payment_intent=(_payment_intent); end
    # String indicating the reason for the refund. If set, possible values are `duplicate`, `fraudulent`, and `requested_by_customer`. If you believe the charge to be fraudulent, specifying `fraudulent` as the reason will add the associated card and email to your [block lists](https://docs.stripe.com/radar/lists), and will also help us improve our fraud detection algorithms.
    sig { returns(T.nilable(String)) }
    def reason; end
    sig { params(_reason: T.nilable(String)).returns(T.nilable(String)) }
    def reason=(_reason); end
    # Boolean indicating whether the application fee should be refunded when refunding this charge. If a full charge refund is given, the full application fee will be refunded. Otherwise, the application fee will be refunded in an amount proportional to the amount of the charge refunded. An application fee can be refunded only by the application that created the charge.
    sig { returns(T.nilable(T::Boolean)) }
    def refund_application_fee; end
    sig { params(_refund_application_fee: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def refund_application_fee=(_refund_application_fee); end
    # Boolean indicating whether the transfer should be reversed when refunding this charge. The transfer will be reversed proportionally to the amount being refunded (either the entire or partial amount).<br><br>A transfer can be reversed only by the application that created the charge.
    sig { returns(T.nilable(T::Boolean)) }
    def reverse_transfer; end
    sig { params(_reverse_transfer: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def reverse_transfer=(_reverse_transfer); end
    sig {
      params(amount: T.nilable(Integer), charge: T.nilable(String), currency: T.nilable(String), customer: T.nilable(String), expand: T.nilable(T::Array[String]), instructions_email: T.nilable(String), metadata: T.nilable(T.any(String, T::Hash[String, String])), origin: T.nilable(String), payment_intent: T.nilable(String), reason: T.nilable(String), refund_application_fee: T.nilable(T::Boolean), reverse_transfer: T.nilable(T::Boolean)).void
     }
    def initialize(
      amount: nil,
      charge: nil,
      currency: nil,
      customer: nil,
      expand: nil,
      instructions_email: nil,
      metadata: nil,
      origin: nil,
      payment_intent: nil,
      reason: nil,
      refund_application_fee: nil,
      reverse_transfer: nil
    ); end
  end
end