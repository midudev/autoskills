# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PriceService < StripeService
    # Creates a new [Price for an existing <a href="https://docs.stripe.com/api/products">Product](https://docs.stripe.com/api/prices). The Price can be recurring or one-time.
    sig {
      params(params: T.any(::Stripe::PriceCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Price)
     }
    def create(params = {}, opts = {}); end

    # Returns a list of your active prices, excluding [inline prices](https://docs.stripe.com/docs/products-prices/pricing-models#inline-pricing). For the list of inactive prices, set active to false.
    sig {
      params(params: T.any(::Stripe::PriceListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the price with the given ID.
    sig {
      params(price: String, params: T.any(::Stripe::PriceRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Price)
     }
    def retrieve(price, params = {}, opts = {}); end

    # Search for prices you've previously created using Stripe's [Search Query Language](https://docs.stripe.com/docs/search#search-query-language).
    # Don't use search in read-after-write flows where strict consistency is necessary. Under normal operating
    # conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up
    # to an hour behind during outages. Search functionality is not available to merchants in India.
    sig {
      params(params: T.any(::Stripe::PriceSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def search(params = {}, opts = {}); end

    # Updates the specified price by setting the values of the parameters passed. Any parameters not provided are left unchanged.
    sig {
      params(price: String, params: T.any(::Stripe::PriceUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Price)
     }
    def update(price, params = {}, opts = {}); end
  end
end