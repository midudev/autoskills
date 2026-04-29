# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ApplePayDomainService < StripeService
    # Create an apple pay domain.
    sig {
      params(params: T.any(::Stripe::ApplePayDomainCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ApplePayDomain)
     }
    def create(params = {}, opts = {}); end

    # Delete an apple pay domain.
    sig {
      params(domain: String, params: T.any(::Stripe::ApplePayDomainDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ApplePayDomain)
     }
    def delete(domain, params = {}, opts = {}); end

    # List apple pay domains.
    sig {
      params(params: T.any(::Stripe::ApplePayDomainListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieve an apple pay domain.
    sig {
      params(domain: String, params: T.any(::Stripe::ApplePayDomainRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ApplePayDomain)
     }
    def retrieve(domain, params = {}, opts = {}); end
  end
end