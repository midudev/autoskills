# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TaxCodeService < StripeService
    # A list of [all tax codes available](https://stripe.com/docs/tax/tax-categories) to add to Products in order to allow specific tax calculations.
    sig {
      params(params: T.any(::Stripe::TaxCodeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of an existing tax code. Supply the unique tax code ID and Stripe will return the corresponding tax code information.
    sig {
      params(id: String, params: T.any(::Stripe::TaxCodeRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxCode)
     }
    def retrieve(id, params = {}, opts = {}); end
  end
end