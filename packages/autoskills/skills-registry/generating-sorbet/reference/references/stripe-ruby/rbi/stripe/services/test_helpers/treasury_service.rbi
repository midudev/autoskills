# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    class TreasuryService < StripeService
      attr_reader :inbound_transfers
      attr_reader :outbound_payments
      attr_reader :outbound_transfers
      attr_reader :received_credits
      attr_reader :received_debits
    end
  end
end