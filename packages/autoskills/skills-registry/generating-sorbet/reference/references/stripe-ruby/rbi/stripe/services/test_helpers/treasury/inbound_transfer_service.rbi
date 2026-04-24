# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Treasury
      class InboundTransferService < StripeService
        # Transitions a test mode created InboundTransfer to the failed status. The InboundTransfer must already be in the processing state.
        sig {
          params(id: String, params: T.any(::Stripe::TestHelpers::Treasury::InboundTransferFailParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
         }
        def fail(id, params = {}, opts = {}); end

        # Marks the test mode InboundTransfer object as returned and links the InboundTransfer to a ReceivedDebit. The InboundTransfer must already be in the succeeded state.
        sig {
          params(id: String, params: T.any(::Stripe::TestHelpers::Treasury::InboundTransferReturnInboundTransferParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
         }
        def return_inbound_transfer(id, params = {}, opts = {}); end

        # Transitions a test mode created InboundTransfer to the succeeded status. The InboundTransfer must already be in the processing state.
        sig {
          params(id: String, params: T.any(::Stripe::TestHelpers::Treasury::InboundTransferSucceedParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
         }
        def succeed(id, params = {}, opts = {}); end
      end
    end
  end
end