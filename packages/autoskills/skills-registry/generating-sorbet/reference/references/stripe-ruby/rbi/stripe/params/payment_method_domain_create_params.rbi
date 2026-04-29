# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentMethodDomainCreateParams < ::Stripe::RequestParams
    # The domain name that this payment method domain object represents.
    sig { returns(String) }
    def domain_name; end
    sig { params(_domain_name: String).returns(String) }
    def domain_name=(_domain_name); end
    # Whether this payment method domain is enabled. If the domain is not enabled, payment methods that require a payment method domain will not appear in Elements or Embedded Checkout.
    sig { returns(T.nilable(T::Boolean)) }
    def enabled; end
    sig { params(_enabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def enabled=(_enabled); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig {
      params(domain_name: String, enabled: T.nilable(T::Boolean), expand: T.nilable(T::Array[String])).void
     }
    def initialize(domain_name: nil, enabled: nil, expand: nil); end
  end
end