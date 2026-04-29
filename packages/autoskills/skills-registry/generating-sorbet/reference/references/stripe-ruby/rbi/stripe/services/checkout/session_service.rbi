# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Checkout
    class SessionService < StripeService
      attr_reader :line_items
      # Creates a Checkout Session object.
      sig {
        params(params: T.any(::Stripe::Checkout::SessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Checkout::Session)
       }
      def create(params = {}, opts = {}); end

      # A Checkout Session can be expired when it is in one of these statuses: open
      #
      # After it expires, a customer can't complete a Checkout Session and customers loading the Checkout Session see a message saying the Checkout Session is expired.
      sig {
        params(session: String, params: T.any(::Stripe::Checkout::SessionExpireParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Checkout::Session)
       }
      def expire(session, params = {}, opts = {}); end

      # Returns a list of Checkout Sessions.
      sig {
        params(params: T.any(::Stripe::Checkout::SessionListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves a Checkout Session object.
      sig {
        params(session: String, params: T.any(::Stripe::Checkout::SessionRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Checkout::Session)
       }
      def retrieve(session, params = {}, opts = {}); end

      # Updates a Checkout Session object.
      #
      # Related guide: [Dynamically update Checkout](https://docs.stripe.com/payments/checkout/dynamic-updates)
      sig {
        params(session: String, params: T.any(::Stripe::Checkout::SessionUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Checkout::Session)
       }
      def update(session, params = {}, opts = {}); end
    end
  end
end