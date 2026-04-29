# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class EventDestinationRetrieveParams < ::Stripe::RequestParams
        # Additional fields to include in the response.
        sig { returns(T.nilable(T::Array[String])) }
        def include; end
        sig { params(_include: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def include=(_include); end
        sig { params(include: T.nilable(T::Array[String])).void }
        def initialize(include: nil); end
      end
    end
  end
end