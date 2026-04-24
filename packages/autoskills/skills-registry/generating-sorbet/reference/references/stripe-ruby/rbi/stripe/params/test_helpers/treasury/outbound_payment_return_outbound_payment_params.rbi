# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Treasury
      class OutboundPaymentReturnOutboundPaymentParams < ::Stripe::RequestParams
        class ReturnedDetails < ::Stripe::RequestParams
          # The return code to be set on the OutboundPayment object.
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
        # Optional hash to set the return code.
        sig {
          returns(T.nilable(TestHelpers::Treasury::OutboundPaymentReturnOutboundPaymentParams::ReturnedDetails))
         }
        def returned_details; end
        sig {
          params(_returned_details: T.nilable(TestHelpers::Treasury::OutboundPaymentReturnOutboundPaymentParams::ReturnedDetails)).returns(T.nilable(TestHelpers::Treasury::OutboundPaymentReturnOutboundPaymentParams::ReturnedDetails))
         }
        def returned_details=(_returned_details); end
        sig {
          params(expand: T.nilable(T::Array[String]), returned_details: T.nilable(TestHelpers::Treasury::OutboundPaymentReturnOutboundPaymentParams::ReturnedDetails)).void
         }
        def initialize(expand: nil, returned_details: nil); end
      end
    end
  end
end