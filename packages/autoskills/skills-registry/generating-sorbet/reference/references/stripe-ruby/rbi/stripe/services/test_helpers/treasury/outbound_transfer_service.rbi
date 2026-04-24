# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Treasury
      class OutboundTransferService < StripeService
        # Transitions a test mode created OutboundTransfer to the failed status. The OutboundTransfer must already be in the processing state.
        sig {
          params(outbound_transfer: String, params: T.any(::Stripe::TestHelpers::Treasury::OutboundTransferFailParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundTransfer)
         }
        def fail(outbound_transfer, params = {}, opts = {}); end

        # Transitions a test mode created OutboundTransfer to the posted status. The OutboundTransfer must already be in the processing state.
        sig {
          params(outbound_transfer: String, params: T.any(::Stripe::TestHelpers::Treasury::OutboundTransferPostParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundTransfer)
         }
        def post(outbound_transfer, params = {}, opts = {}); end

        # Transitions a test mode created OutboundTransfer to the returned status. The OutboundTransfer must already be in the processing state.
        sig {
          params(outbound_transfer: String, params: T.any(::Stripe::TestHelpers::Treasury::OutboundTransferReturnOutboundTransferParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundTransfer)
         }
        def return_outbound_transfer(outbound_transfer, params = {}, opts = {}); end

        # Updates a test mode created OutboundTransfer with tracking details. The OutboundTransfer must not be cancelable, and cannot be in the canceled or failed states.
        sig {
          params(outbound_transfer: String, params: T.any(::Stripe::TestHelpers::Treasury::OutboundTransferUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundTransfer)
         }
        def update(outbound_transfer, params = {}, opts = {}); end
      end
    end
  end
end