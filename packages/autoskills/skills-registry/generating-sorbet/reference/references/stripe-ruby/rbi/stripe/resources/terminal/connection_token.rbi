# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    # A Connection Token is used by the Stripe Terminal SDK to connect to a reader.
    #
    # Related guide: [Fleet management](https://docs.stripe.com/terminal/fleet/locations)
    class ConnectionToken < APIResource
      # The id of the location that this connection token is scoped to. Note that location scoping only applies to internet-connected readers. For more details, see [the docs on scoping connection tokens](https://docs.stripe.com/terminal/fleet/locations-and-zones?dashboard-or-api=api#connection-tokens).
      sig { returns(T.nilable(String)) }
      def location; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Your application should pass this token to the Stripe Terminal SDK.
      sig { returns(String) }
      def secret; end
      # To connect to a reader the Stripe Terminal SDK needs to retrieve a short-lived connection token from Stripe, proxied through your server. On your backend, add an endpoint that creates and returns a connection token.
      sig {
        params(params: T.any(::Stripe::Terminal::ConnectionTokenCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::ConnectionToken)
       }
      def self.create(params = {}, opts = {}); end
    end
  end
end