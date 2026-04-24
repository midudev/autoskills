# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Treasury
      class InboundTransferFailParams < ::Stripe::RequestParams
        class FailureDetails < ::Stripe::RequestParams
          # Reason for the failure.
          sig { returns(T.nilable(String)) }
          def code; end
          sig { params(_code: T.nilable(String)).returns(T.nilable(String)) }
          def code=(_code); end
          sig { params(code: T.nilable(String)).void }
          def initialize(code: nil); end
        end
        # Specifies which fields in the response should be expanded.
        sig { returns(T.nilable(T::Array[String])) }
        def expand; end
        sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
        def expand=(_expand); end
        # Details about a failed InboundTransfer.
        sig { returns(T.nilable(TestHelpers::Treasury::InboundTransferFailParams::FailureDetails)) }
        def failure_details; end
        sig {
          params(_failure_details: T.nilable(TestHelpers::Treasury::InboundTransferFailParams::FailureDetails)).returns(T.nilable(TestHelpers::Treasury::InboundTransferFailParams::FailureDetails))
         }
        def failure_details=(_failure_details); end
        sig {
          params(expand: T.nilable(T::Array[String]), failure_details: T.nilable(TestHelpers::Treasury::InboundTransferFailParams::FailureDetails)).void
         }
        def initialize(expand: nil, failure_details: nil); end
      end
    end
  end
end