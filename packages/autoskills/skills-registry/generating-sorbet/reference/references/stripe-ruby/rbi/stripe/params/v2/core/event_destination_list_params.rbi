# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class EventDestinationListParams < ::Stripe::RequestParams
        # Additional fields to include in the response. Currently supports `webhook_endpoint.url`.
        sig { returns(T.nilable(T::Array[String])) }
        def include; end
        sig { params(_include: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def include=(_include); end
        # The page size.
        sig { returns(T.nilable(Integer)) }
        def limit; end
        sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
        def limit=(_limit); end
        sig { params(include: T.nilable(T::Array[String]), limit: T.nilable(Integer)).void }
        def initialize(include: nil, limit: nil); end
      end
    end
  end
end