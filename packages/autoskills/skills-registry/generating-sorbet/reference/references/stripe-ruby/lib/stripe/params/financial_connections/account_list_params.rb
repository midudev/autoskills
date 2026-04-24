# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module FinancialConnections
    class AccountListParams < ::Stripe::RequestParams
      class AccountHolder < ::Stripe::RequestParams
        # The ID of the Stripe account whose accounts you will retrieve.
        attr_accessor :account
        # The ID of the Stripe customer whose accounts you will retrieve.
        attr_accessor :customer
        # The ID of the Account representing a customer whose accounts you will retrieve.
        attr_accessor :customer_account

        def initialize(account: nil, customer: nil, customer_account: nil)
          @account = account
          @customer = customer
          @customer_account = customer_account
        end
      end
      # If present, only return accounts that belong to the specified account holder. `account_holder[customer]` and `account_holder[account]` are mutually exclusive.
      attr_accessor :account_holder
      # A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
      attr_accessor :ending_before
      # Specifies which fields in the response should be expanded.
      attr_accessor :expand
      # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
      attr_accessor :limit
      # If present, only return accounts that were collected as part of the given session.
      attr_accessor :session
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      attr_accessor :starting_after

      def initialize(
        account_holder: nil,
        ending_before: nil,
        expand: nil,
        limit: nil,
        session: nil,
        starting_after: nil
      )
        @account_holder = account_holder
        @ending_before = ending_before
        @expand = expand
        @limit = limit
        @session = session
        @starting_after = starting_after
      end
    end
  end
end
