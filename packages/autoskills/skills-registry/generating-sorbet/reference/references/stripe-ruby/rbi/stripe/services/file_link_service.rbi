# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class FileLinkService < StripeService
    # Creates a new file link object.
    sig {
      params(params: T.any(::Stripe::FileLinkCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FileLink)
     }
    def create(params = {}, opts = {}); end

    # Returns a list of file links.
    sig {
      params(params: T.any(::Stripe::FileLinkListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the file link with the given ID.
    sig {
      params(link: String, params: T.any(::Stripe::FileLinkRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FileLink)
     }
    def retrieve(link, params = {}, opts = {}); end

    # Updates an existing file link object. Expired links can no longer be updated.
    sig {
      params(link: String, params: T.any(::Stripe::FileLinkUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FileLink)
     }
    def update(link, params = {}, opts = {}); end
  end
end