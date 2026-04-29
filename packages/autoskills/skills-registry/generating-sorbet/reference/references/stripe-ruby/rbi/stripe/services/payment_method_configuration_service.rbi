# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentMethodConfigurationService < StripeService
    # Creates a payment method configuration
    sig {
      params(params: T.any(::Stripe::PaymentMethodConfigurationCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodConfiguration)
     }
    def create(params = {}, opts = {}); end

    # List payment method configurations
    sig {
      params(params: T.any(::Stripe::PaymentMethodConfigurationListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieve payment method configuration
    sig {
      params(configuration: String, params: T.any(::Stripe::PaymentMethodConfigurationRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodConfiguration)
     }
    def retrieve(configuration, params = {}, opts = {}); end

    # Update payment method configuration
    sig {
      params(configuration: String, params: T.any(::Stripe::PaymentMethodConfigurationUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::PaymentMethodConfiguration)
     }
    def update(configuration, params = {}, opts = {}); end
  end
end