# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      class AccountService < StripeService
        attr_reader :persons, :person_tokens

        def initialize(requestor)
          super
          @persons = Stripe::V2::Core::Accounts::PersonService.new(@requestor)
          @person_tokens = Stripe::V2::Core::Accounts::PersonTokenService.new(@requestor)
        end

        # Removes access to the Account and its associated resources. Closed Accounts can no longer be operated on, but limited information can still be retrieved through the API in order to be able to track their history.
        def close(id, params = {}, opts = {})
          request(
            method: :post,
            path: format("/v2/core/accounts/%<id>s/close", { id: CGI.escape(id) }),
            params: params,
            opts: opts,
            base_address: :api
          )
        end

        # An Account is a representation of a company, individual or other entity that a user interacts with. Accounts contain identifying information about the entity, and configurations that store the features an account has access to. An account can be configured as any or all of the following configurations: Customer, Merchant and/or Recipient.
        def create(params = {}, opts = {})
          request(
            method: :post,
            path: "/v2/core/accounts",
            params: params,
            opts: opts,
            base_address: :api
          )
        end

        # Returns a list of Accounts.
        def list(params = {}, opts = {})
          request(
            method: :get,
            path: "/v2/core/accounts",
            params: params,
            opts: opts,
            base_address: :api
          )
        end

        # Retrieves the details of an Account.
        def retrieve(id, params = {}, opts = {})
          request(
            method: :get,
            path: format("/v2/core/accounts/%<id>s", { id: CGI.escape(id) }),
            params: params,
            opts: opts,
            base_address: :api
          )
        end

        # Updates the details of an Account.
        def update(id, params = {}, opts = {})
          request(
            method: :post,
            path: format("/v2/core/accounts/%<id>s", { id: CGI.escape(id) }),
            params: params,
            opts: opts,
            base_address: :api
          )
        end
      end
    end
  end
end
