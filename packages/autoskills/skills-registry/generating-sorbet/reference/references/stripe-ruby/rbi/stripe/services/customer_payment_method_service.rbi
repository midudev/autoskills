# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerPaymentMethodService < StripeService
    # Returns a list of PaymentMethods for a given Customer
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerPaymentMethodListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(customer, params = {}, opts = {}); end

    # Retrieves a PaymentMethod object for a given Customer.
    sig {
      params(customer: String, payment_method: String, params: T.any(::Stripe::CustomerPaymentMethodRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethod)
     }
    def retrieve(customer, payment_method, params = {}, opts = {}); end
  end
end