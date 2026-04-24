# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentMethodDomainService < StripeService
    # Creates a payment method domain.
    sig {
      params(params: T.any(::Stripe::PaymentMethodDomainCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodDomain)
     }
    def create(params = {}, opts = {}); end

    # Lists the details of existing payment method domains.
    sig {
      params(params: T.any(::Stripe::PaymentMethodDomainListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of an existing payment method domain.
    sig {
      params(payment_method_domain: String, params: T.any(::Stripe::PaymentMethodDomainRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodDomain)
     }
    def retrieve(payment_method_domain, params = {}, opts = {}); end

    # Updates an existing payment method domain.
    sig {
      params(payment_method_domain: String, params: T.any(::Stripe::PaymentMethodDomainUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodDomain)
     }
    def update(payment_method_domain, params = {}, opts = {}); end

    # Some payment methods might require additional steps to register a domain. If the requirements weren't satisfied when the domain was created, the payment method will be inactive on the domain.
    # The payment method doesn't appear in Elements or Embedded Checkout for this domain until it is active.
    #
    # To activate a payment method on an existing payment method domain, complete the required registration steps specific to the payment method, and then validate the payment method domain with this endpoint.
    #
    # Related guides: [Payment method domains](https://docs.stripe.com/docs/payments/payment-methods/pmd-registration).
    sig {
      params(payment_method_domain: String, params: T.any(::Stripe::PaymentMethodDomainValidateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodDomain)
     }
    def validate(payment_method_domain, params = {}, opts = {}); end
  end
end