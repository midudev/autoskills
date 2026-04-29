# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountPersonService < StripeService
    # Creates a new person.
    sig {
      params(account: String, params: T.any(::Stripe::AccountPersonCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Person)
     }
    def create(account, params = {}, opts = {}); end

    # Deletes an existing person's relationship to the account's legal entity. Any person with a relationship for an account can be deleted through the API, except if the person is the account_opener. If your integration is using the executive parameter, you cannot delete the only verified executive on file.
    sig {
      params(account: String, person: String, params: T.any(::Stripe::AccountPersonDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Person)
     }
    def delete(account, person, params = {}, opts = {}); end

    # Returns a list of people associated with the account's legal entity. The people are returned sorted by creation date, with the most recent people appearing first.
    sig {
      params(account: String, params: T.any(::Stripe::AccountPersonListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(account, params = {}, opts = {}); end

    # Retrieves an existing person.
    sig {
      params(account: String, person: String, params: T.any(::Stripe::AccountPersonRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Person)
     }
    def retrieve(account, person, params = {}, opts = {}); end

    # Updates an existing person.
    sig {
      params(account: String, person: String, params: T.any(::Stripe::AccountPersonUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Person)
     }
    def update(account, person, params = {}, opts = {}); end
  end
end