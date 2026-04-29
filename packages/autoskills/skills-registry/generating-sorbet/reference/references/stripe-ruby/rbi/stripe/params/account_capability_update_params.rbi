# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountCapabilityUpdateParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # To request a new capability for an account, pass true. There can be a delay before the requested capability becomes active. If the capability has any activation requirements, the response includes them in the `requirements` arrays.
    #
    # If a capability isn't permanent, you can remove it from the account by passing false. Some capabilities are permanent after they've been requested. Attempting to remove a permanent capability returns an error.
    sig { returns(T.nilable(T::Boolean)) }
    def requested; end
    sig { params(_requested: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def requested=(_requested); end
    sig { params(expand: T.nilable(T::Array[String]), requested: T.nilable(T::Boolean)).void }
    def initialize(expand: nil, requested: nil); end
  end
end