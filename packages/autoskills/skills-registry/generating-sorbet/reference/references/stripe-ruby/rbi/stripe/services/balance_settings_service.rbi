# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class BalanceSettingsService < StripeService
    # Retrieves balance settings for a given connected account.
    #  Related guide: [Making API calls for connected accounts](https://docs.stripe.com/connect/authentication)
    sig {
      params(params: T.any(::Stripe::BalanceSettingsRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::BalanceSettings)
     }
    def retrieve(params = {}, opts = {}); end

    # Updates balance settings for a given connected account.
    #  Related guide: [Making API calls for connected accounts](https://docs.stripe.com/connect/authentication)
    sig {
      params(params: T.any(::Stripe::BalanceSettingsUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::BalanceSettings)
     }
    def update(params = {}, opts = {}); end
  end
end