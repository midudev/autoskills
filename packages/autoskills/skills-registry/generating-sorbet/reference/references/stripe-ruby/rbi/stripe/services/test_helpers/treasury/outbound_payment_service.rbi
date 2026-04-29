# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Treasury
      class OutboundPaymentService < StripeService
        # Transitions a test mode created OutboundPayment to the failed status. The OutboundPayment must already be in the processing state.
        sig {
          params(id: String, params: T.any(::Stripe::TestHelpers::Treasury::OutboundPaymentFailParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
         }
        def fail(id, params = {}, opts = {}); end

        # Transitions a test mode created OutboundPayment to the posted status. The OutboundPayment must already be in the processing state.
        sig {
          params(id: String, params: T.any(::Stripe::TestHelpers::Treasury::OutboundPaymentPostParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
         }
        def post(id, params = {}, opts = {}); end

        # Transitions a test mode created OutboundPayment to the returned status. The OutboundPayment must already be in the processing state.
        sig {
          params(id: String, params: T.any(::Stripe::TestHelpers::Treasury::OutboundPaymentReturnOutboundPaymentParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
         }
        def return_outbound_payment(id, params = {}, opts = {}); end

        # Updates a test mode created OutboundPayment with tracking details. The OutboundPayment must not be cancelable, and cannot be in the canceled or failed states.
        sig {
          params(id: String, params: T.any(::Stripe::TestHelpers::Treasury::OutboundPaymentUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
         }
        def update(id, params = {}, opts = {}); end
      end
    end
  end
end