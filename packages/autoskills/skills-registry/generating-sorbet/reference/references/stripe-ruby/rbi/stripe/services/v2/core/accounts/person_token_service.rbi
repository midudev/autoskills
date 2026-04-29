# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      module Accounts
        class PersonTokenService < StripeService
          # Creates a Person Token associated with an Account.
          sig {
            params(account_id: String, params: T.any(::Stripe::V2::Core::Accounts::PersonTokenCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::AccountPersonToken)
           }
          def create(account_id, params = {}, opts = {}); end

          # Retrieves a Person Token associated with an Account.
          sig {
            params(account_id: String, id: String, params: T.any(::Stripe::V2::Core::Accounts::PersonTokenRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::AccountPersonToken)
           }
          def retrieve(account_id, id, params = {}, opts = {}); end
        end
      end
    end
  end
end