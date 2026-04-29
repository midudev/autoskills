# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      class AccountLinkService < StripeService
        # Creates an AccountLink object that includes a single-use URL that an account can use to access a Stripe-hosted flow for collecting or updating required information.
        def create(params = {}, opts = {})
          request(
            method: :post,
            path: "/v2/core/account_links",
            params: params,
            opts: opts,
            base_address: :api
          )
        end
      end
    end
  end
end
