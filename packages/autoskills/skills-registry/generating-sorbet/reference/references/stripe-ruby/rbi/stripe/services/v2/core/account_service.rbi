# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class AccountService < StripeService
        attr_reader :persons
        attr_reader :person_tokens
        # Removes access to the Account and its associated resources. Closed Accounts can no longer be operated on, but limited information can still be retrieved through the API in order to be able to track their history.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::AccountCloseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::Account)
         }
        def close(id, params = {}, opts = {}); end

        # An Account is a representation of a company, individual or other entity that a user interacts with. Accounts contain identifying information about the entity, and configurations that store the features an account has access to. An account can be configured as any or all of the following configurations: Customer, Merchant and/or Recipient.
        sig {
          params(params: T.any(::Stripe::V2::Core::AccountCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::Account)
         }
        def create(params = {}, opts = {}); end

        # Returns a list of Accounts.
        sig {
          params(params: T.any(::Stripe::V2::Core::AccountListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::ListObject)
         }
        def list(params = {}, opts = {}); end

        # Retrieves the details of an Account.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::AccountRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::Account)
         }
        def retrieve(id, params = {}, opts = {}); end

        # Updates the details of an Account.
        sig {
          params(id: String, params: T.any(::Stripe::V2::Core::AccountUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::V2::Core::Account)
         }
        def update(id, params = {}, opts = {}); end
      end
    end
  end
end