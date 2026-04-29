# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      class AccountTokenService < StripeService
        # Creates an Account Token.
        def create(params = {}, opts = {})
          request(
            method: :post,
            path: "/v2/core/account_tokens",
            params: params,
            opts: opts,
            base_address: :api
          )
        end

        # Retrieves an Account Token.
        def retrieve(id, params = {}, opts = {})
          request(
            method: :get,
            path: format("/v2/core/account_tokens/%<id>s", { id: CGI.escape(id) }),
            params: params,
            opts: opts,
            base_address: :api
          )
        end
      end
    end
  end
end
