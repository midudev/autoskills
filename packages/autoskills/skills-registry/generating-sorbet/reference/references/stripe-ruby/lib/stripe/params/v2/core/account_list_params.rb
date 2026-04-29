# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      class AccountListParams < ::Stripe::RequestParams
        # Filter only accounts that have all of the configurations specified. If omitted, returns all accounts regardless of which configurations they have.
        attr_accessor :applied_configurations
        # Filter by whether the account is closed. If omitted, returns only Accounts that are not closed.
        attr_accessor :closed
        # The upper limit on the number of accounts returned by the List Account request.
        attr_accessor :limit

        def initialize(applied_configurations: nil, closed: nil, limit: nil)
          @applied_configurations = applied_configurations
          @closed = closed
          @limit = limit
        end
      end
    end
  end
end
