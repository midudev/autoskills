# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ReviewService < StripeService
    # Approves a Review object, closing it and removing it from the list of reviews.
    sig {
      params(review: String, params: T.any(::Stripe::ReviewApproveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Review)
     }
    def approve(review, params = {}, opts = {}); end

    # Returns a list of Review objects that have open set to true. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    sig {
      params(params: T.any(::Stripe::ReviewListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves a Review object.
    sig {
      params(review: String, params: T.any(::Stripe::ReviewRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Review)
     }
    def retrieve(review, params = {}, opts = {}); end
  end
end