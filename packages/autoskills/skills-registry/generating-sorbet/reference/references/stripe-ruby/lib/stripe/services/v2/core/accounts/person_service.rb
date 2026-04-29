# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      module Accounts
        class PersonService < StripeService
          # Create a Person. Adds an individual to an Account's identity. You can set relationship attributes and identity information at creation.
          def create(account_id, params = {}, opts = {})
            request(
              method: :post,
              path: format("/v2/core/accounts/%<account_id>s/persons", { account_id: CGI.escape(account_id) }),
              params: params,
              opts: opts,
              base_address: :api
            )
          end

          # Delete a Person associated with an Account.
          def delete(account_id, id, params = {}, opts = {})
            request(
              method: :delete,
              path: format("/v2/core/accounts/%<account_id>s/persons/%<id>s", { account_id: CGI.escape(account_id), id: CGI.escape(id) }),
              params: params,
              opts: opts,
              base_address: :api
            )
          end

          # Returns a paginated list of Persons associated with an Account.
          def list(account_id, params = {}, opts = {})
            request(
              method: :get,
              path: format("/v2/core/accounts/%<account_id>s/persons", { account_id: CGI.escape(account_id) }),
              params: params,
              opts: opts,
              base_address: :api
            )
          end

          # Retrieves a Person associated with an Account.
          def retrieve(account_id, id, params = {}, opts = {})
            request(
              method: :get,
              path: format("/v2/core/accounts/%<account_id>s/persons/%<id>s", { account_id: CGI.escape(account_id), id: CGI.escape(id) }),
              params: params,
              opts: opts,
              base_address: :api
            )
          end

          # Updates a Person associated with an Account.
          def update(account_id, id, params = {}, opts = {})
            request(
              method: :post,
              path: format("/v2/core/accounts/%<account_id>s/persons/%<id>s", { account_id: CGI.escape(account_id), id: CGI.escape(id) }),
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
