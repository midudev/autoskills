# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Forwarding
    class RequestService < StripeService
      # Creates a ForwardingRequest object.
      sig {
        params(params: T.any(::Stripe::Forwarding::RequestCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Forwarding::Request)
       }
      def create(params = {}, opts = {}); end

      # Lists all ForwardingRequest objects.
      sig {
        params(params: T.any(::Stripe::Forwarding::RequestListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a ForwardingRequest object.
      sig {
        params(id: String, params: T.any(::Stripe::Forwarding::RequestRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Forwarding::Request)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end