# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerPaymentSourceService < StripeService
    # When you create a new credit card, you must specify a customer or recipient on which to create it.
    #
    # If the card's owner has no default card, then the new card will become the default.
    # However, if the owner already has a default, then it will not change.
    # To change the default, you should [update the customer](https://docs.stripe.com/docs/api#update_customer) to have a new default_source.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerPaymentSourceCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source))
     }
    def create(customer, params = {}, opts = {}); end

    # Delete a specified source for a given customer.
    sig {
      params(customer: String, id: String, params: T.any(::Stripe::CustomerPaymentSourceDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source))
     }
    def delete(customer, id, params = {}, opts = {}); end

    # List sources for a specified customer.
    sig {
      params(customer: String, params: T.any(::Stripe::CustomerPaymentSourceListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(customer, params = {}, opts = {}); end

    # Retrieve a specified source for a given customer.
    sig {
      params(customer: String, id: String, params: T.any(::Stripe::CustomerPaymentSourceRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source))
     }
    def retrieve(customer, id, params = {}, opts = {}); end

    # Update a specified source for a given customer.
    sig {
      params(customer: String, id: String, params: T.any(::Stripe::CustomerPaymentSourceUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source))
     }
    def update(customer, id, params = {}, opts = {}); end

    # Verify a specified bank account for a given customer.
    sig {
      params(customer: String, id: String, params: T.any(::Stripe::CustomerPaymentSourceVerifyParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::BankAccount)
     }
    def verify(customer, id, params = {}, opts = {}); end
  end
end