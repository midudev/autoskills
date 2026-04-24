# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SourceService < StripeService
    attr_reader :transactions
    # Creates a new source object.
    sig {
      params(params: T.any(::Stripe::SourceCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Source)
     }
    def create(params = {}, opts = {}); end

    # Delete a specified source for a given customer.
    sig {
      params(customer: String, id: String, params: T.any(::Stripe::SourceDetachParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(T.any(::Stripe::Account, ::Stripe::BankAccount, ::Stripe::Card, ::Stripe::Source))
     }
    def detach(customer, id, params = {}, opts = {}); end

    # Retrieves an existing source object. Supply the unique source ID from a source creation request and Stripe will return the corresponding up-to-date source object information.
    sig {
      params(source: String, params: T.any(::Stripe::SourceRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Source)
     }
    def retrieve(source, params = {}, opts = {}); end

    # Updates the specified source by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    #
    # This request accepts the metadata and owner as arguments. It is also possible to update type specific information for selected payment methods. Please refer to our [payment method guides](https://docs.stripe.com/docs/sources) for more detail.
    sig {
      params(source: String, params: T.any(::Stripe::SourceUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Source)
     }
    def update(source, params = {}, opts = {}); end

    # Verify a given source.
    sig {
      params(source: String, params: T.any(::Stripe::SourceVerifyParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Source)
     }
    def verify(source, params = {}, opts = {}); end
  end
end