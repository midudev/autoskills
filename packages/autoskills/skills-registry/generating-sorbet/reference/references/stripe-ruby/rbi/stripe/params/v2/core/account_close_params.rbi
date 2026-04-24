# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module V2
    module Core
      class AccountCloseParams < ::Stripe::RequestParams
        # Configurations on the Account to be closed. All configurations on the Account must be passed in for this request to succeed.
        sig { returns(T.nilable(T::Array[String])) }
        def applied_configurations; end
        sig {
          params(_applied_configurations: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
         }
        def applied_configurations=(_applied_configurations); end
        sig { params(applied_configurations: T.nilable(T::Array[String])).void }
        def initialize(applied_configurations: nil); end
      end
    end
  end
end