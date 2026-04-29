# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ExchangeRateService < StripeService
    # [Deprecated] The ExchangeRate APIs are deprecated. Please use the [FX Quotes API](https://docs.stripe.com/payments/currencies/localize-prices/fx-quotes-api) instead.
    #
    # Returns a list of objects that contain the rates at which foreign currencies are converted to one another. Only shows the currencies for which Stripe supports.
    sig {
      params(params: T.any(::Stripe::ExchangeRateListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # [Deprecated] The ExchangeRate APIs are deprecated. Please use the [FX Quotes API](https://docs.stripe.com/payments/currencies/localize-prices/fx-quotes-api) instead.
    #
    # Retrieves the exchange rates from the given currency to every supported currency.
    sig {
      params(rate_id: String, params: T.any(::Stripe::ExchangeRateRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ExchangeRate)
     }
    def retrieve(rate_id, params = {}, opts = {}); end
  end
end