# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentMethodAttachParams < ::Stripe::RequestParams
    # The ID of the customer to which to attach the PaymentMethod.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # The ID of the Account representing the customer to which to attach the PaymentMethod.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
    def customer_account=(_customer_account); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig {
      params(customer: T.nilable(String), customer_account: T.nilable(String), expand: T.nilable(T::Array[String])).void
     }
    def initialize(customer: nil, customer_account: nil, expand: nil); end
  end
end