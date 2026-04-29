# File generated from our OpenAPI spec
# frozen_string_literal: true

module Stripe
  module V2
    module Core
      class AccountCloseParams < ::Stripe::RequestParams
        # Configurations on the Account to be closed. All configurations on the Account must be passed in for this request to succeed.
        attr_accessor :applied_configurations

        def initialize(applied_configurations: nil)
          @applied_configurations = applied_configurations
        end
      end
    end
  end
end
