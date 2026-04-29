# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ConnectionTokenCreateParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The id of the location that this connection token is scoped to. If specified the connection token will only be usable with readers assigned to that location, otherwise the connection token will be usable with all readers. Note that location scoping only applies to internet-connected readers. For more details, see [the docs on scoping connection tokens](https://docs.stripe.com/terminal/fleet/locations-and-zones?dashboard-or-api=api#connection-tokens).
      sig { returns(T.nilable(String)) }
      def location; end
      sig { params(_location: T.nilable(String)).returns(T.nilable(String)) }
      def location=(_location); end
      sig { params(expand: T.nilable(T::Array[String]), location: T.nilable(String)).void }
      def initialize(expand: nil, location: nil); end
    end
  end
end