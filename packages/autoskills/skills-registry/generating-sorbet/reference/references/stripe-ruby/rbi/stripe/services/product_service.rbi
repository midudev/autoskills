# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ProductService < StripeService
    attr_reader :features
    # Creates a new product object.
    sig {
      params(params: T.any(::Stripe::ProductCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Product)
     }
    def create(params = {}, opts = {}); end

    # Delete a product. Deleting a product is only possible if it has no prices associated with it. Additionally, deleting a product with type=good is only possible if it has no SKUs associated with it.
    sig {
      params(id: String, params: T.any(::Stripe::ProductDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Product)
     }
    def delete(id, params = {}, opts = {}); end

    # Returns a list of your products. The products are returned sorted by creation date, with the most recently created products appearing first.
    sig {
      params(params: T.any(::Stripe::ProductListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of an existing product. Supply the unique product ID from either a product creation request or the product list, and Stripe will return the corresponding product information.
    sig {
      params(id: String, params: T.any(::Stripe::ProductRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Product)
     }
    def retrieve(id, params = {}, opts = {}); end

    # Search for products you've previously created using Stripe's [Search Query Language](https://docs.stripe.com/docs/search#search-query-language).
    # Don't use search in read-after-write flows where strict consistency is necessary. Under normal operating
    # conditions, data is searchable in less than a minute. Occasionally, propagation of new or updated data can be up
    # to an hour behind during outages. Search functionality is not available to merchants in India.
    sig {
      params(params: T.any(::Stripe::ProductSearchParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::SearchResultObject)
     }
    def search(params = {}, opts = {}); end

    # Updates the specific product by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    sig {
      params(id: String, params: T.any(::Stripe::ProductUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Product)
     }
    def update(id, params = {}, opts = {}); end
  end
end