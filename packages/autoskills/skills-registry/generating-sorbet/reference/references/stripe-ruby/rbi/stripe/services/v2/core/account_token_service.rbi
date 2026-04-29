# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class AccountTokenService < StripeService
        # Creates an Account Token.
        sig {
          params(params: T.any(::Stripe::V2::Core::AccountTokenCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::AccountToken)
         }
        def create(params = {}, opts = {}); end

        # Retrieves an Account Token.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::AccountTokenRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::AccountToken)
         }
        def retrieve(id, params = {}, opts = {}); end
      end
    end
  end
end