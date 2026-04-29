# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountExternalAccountService < StripeService
    # Create an external account for a given account.
    sig {
      params(account: String, params: T.any(::Stripe::AccountExternalAccountCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::BankAccount, ::Stripe::Card))
     }
    def create(account, params = {}, opts = {}); end

    # Delete a specified external account for a given account.
    sig {
      params(account: String, id: String, params: T.any(::Stripe::AccountExternalAccountDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::BankAccount, ::Stripe::Card))
     }
    def delete(account, id, params = {}, opts = {}); end

    # List external accounts for an account.
    sig {
      params(account: String, params: T.any(::Stripe::AccountExternalAccountListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(account, params = {}, opts = {}); end

    # Retrieve a specified external account for a given account.
    sig {
      params(account: String, id: String, params: T.any(::Stripe::AccountExternalAccountRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::BankAccount, ::Stripe::Card))
     }
    def retrieve(account, id, params = {}, opts = {}); end

    # Updates the metadata, account holder name, account holder type of a bank account belonging to
    # a connected account and optionally sets it as the default for its currency. Other bank account
    # details are not editable by design.
    #
    # You can only update bank accounts when [account.controller.requirement_collection is application, which includes <a href="/connect/custom-accounts">Custom accounts](https://docs.stripe.com/api/accounts/object#account_object-controller-requirement_collection).
    #
    # You can re-enable a disabled bank account by performing an update call without providing any
    # arguments or changes.
    sig {
      params(account: String, id: String, params: T.any(::Stripe::AccountExternalAccountUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::BankAccount, ::Stripe::Card))
     }
    def update(account, id, params = {}, opts = {}); end
  end
end