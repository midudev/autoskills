# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class AccountCapabilityService < StripeService
    # Returns a list of capabilities associated with the account. The capabilities are returned sorted by creation date, with the most recent capability appearing first.
    sig {
      params(account: String, params: T.any(::Stripe::AccountCapabilityListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(account, params = {}, opts = {}); end

    # Retrieves information about the specified Account Capability.
    sig {
      params(account: String, capability: String, params: T.any(::Stripe::AccountCapabilityRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Capability)
     }
    def retrieve(account, capability, params = {}, opts = {}); end

    # Updates an existing Account Capability. Request or remove a capability by updating its requested parameter.
    sig {
      params(account: String, capability: String, params: T.any(::Stripe::AccountCapabilityUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Capability)
     }
    def update(account, capability, params = {}, opts = {}); end
  end
end