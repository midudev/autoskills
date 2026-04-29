# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CountrySpecService < StripeService
    # Lists all Country Spec objects available in the API.
    sig {
      params(params: T.any(::Stripe::CountrySpecListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Returns a Country Spec for a given Country code.
    sig {
      params(country: String, params: T.any(::Stripe::CountrySpecRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::CountrySpec)
     }
    def retrieve(country, params = {}, opts = {}); end
  end
end