# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TaxRateService < StripeService
    # Creates a new tax rate.
    sig {
      params(params: T.any(::Stripe::TaxRateCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxRate)
     }
    def create(params = {}, opts = {}); end

    # Returns a list of your tax rates. Tax rates are returned sorted by creation date, with the most recently created tax rates appearing first.
    sig {
      params(params: T.any(::Stripe::TaxRateListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves a tax rate with the given ID
    sig {
      params(tax_rate: String, params: T.any(::Stripe::TaxRateRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxRate)
     }
    def retrieve(tax_rate, params = {}, opts = {}); end

    # Updates an existing tax rate.
    sig {
      params(tax_rate: String, params: T.any(::Stripe::TaxRateUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxRate)
     }
    def update(tax_rate, params = {}, opts = {}); end
  end
end