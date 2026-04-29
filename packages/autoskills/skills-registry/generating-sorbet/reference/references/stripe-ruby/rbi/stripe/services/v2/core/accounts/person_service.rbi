# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      module Accounts
        class PersonService < StripeService
          # Create a Person. Adds an individual to an Account's identity. You can set relationship attributes and identity information at creation.
          sig {
            params(account_id: String, params: T.any(::Stripe::V2::Core::Accounts::PersonCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::AccountPerson)
           }
          def create(account_id, params = {}, opts = {}); end

          # Delete a Person associated with an Account.
          sig {
            params(account_id: String, id: String, params: T.any(::Stripe::V2::Core::Accounts::PersonDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::DeletedObject)
           }
          def delete(account_id, id, params = {}, opts = {}); end

          # Returns a paginated list of Persons associated with an Account.
          sig {
            params(account_id: String, params: T.any(::Stripe::V2::Core::Accounts::PersonListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::ListObject)
           }
          def list(account_id, params = {}, opts = {}); end

          # Retrieves a Person associated with an Account.
          sig {
            params(account_id: String, id: String, params: T.any(::Stripe::V2::Core::Accounts::PersonRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::AccountPerson)
           }
          def retrieve(account_id, id, params = {}, opts = {}); end

          # Updates a Person associated with an Account.
          sig {
            params(account_id: String, id: String, params: T.any(::Stripe::V2::Core::Accounts::PersonUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::AccountPerson)
           }
          def update(account_id, id, params = {}, opts = {}); end
        end
      end
    end
  end
end