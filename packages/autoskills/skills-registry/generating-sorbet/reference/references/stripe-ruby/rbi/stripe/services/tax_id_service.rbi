# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class TaxIdService < StripeService
    # Creates a new account or customer tax_id object.
    sig {
      params(params: T.any(::Stripe::TaxIdCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxId)
     }
    def create(params = {}, opts = {}); end

    # Deletes an existing account or customer tax_id object.
    sig {
      params(id: String, params: T.any(::Stripe::TaxIdDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxId)
     }
    def delete(id, params = {}, opts = {}); end

    # Returns a list of tax IDs.
    sig {
      params(params: T.any(::Stripe::TaxIdListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves an account or customer tax_id object.
    sig {
      params(id: String, params: T.any(::Stripe::TaxIdRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::TaxId)
     }
    def retrieve(id, params = {}, opts = {}); end
  end
end