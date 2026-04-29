# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ConnectionTokenService < StripeService
      # To connect to a reader the Stripe Terminal SDK needs to retrieve a short-lived connection token from Stripe, proxied through your server. On your backend, add an endpoint that creates and returns a connection token.
      sig {
        params(params: T.any(::Stripe::Terminal::ConnectionTokenCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::ConnectionToken)
       }
      def create(params = {}, opts = {}); end
    end
  end
end