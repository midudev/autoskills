# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      module Accounts
        class PersonTokenService < StripeService
          # Creates a Person Token associated with an Account.
          def create(account_id, params = {}, opts = {})
            request(
              method: :post,
              path: format("/v2/core/accounts/%<account_id>s/person_tokens", { account_id: CGI.escape(account_id) }),
              params: params,
              opts: opts,
              base_address: :api
            )
          end

          # Retrieves a Person Token associated with an Account.
          def retrieve(account_id, id, params = {}, opts = {})
            request(
              method: :get,
              path: format("/v2/core/accounts/%<account_id>s/person_tokens/%<id>s", { account_id: CGI.escape(account_id), id: CGI.escape(id) }),
              params: params,
              opts: opts,
              base_address: :api
            )
          end
        end
      end
    end
  end
end
