# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Issuing
      class TransactionService < StripeService
        # Allows the user to capture an arbitrary amount, also known as a forced capture.
        sig {
          params(params: T.any(::Stripe::TestHelpers::Issuing::TransactionCreateForceCaptureParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Transaction)
         }
        def create_force_capture(params = {}, opts = {}); end

        # Allows the user to refund an arbitrary amount, also known as a unlinked refund.
        sig {
          params(params: T.any(::Stripe::TestHelpers::Issuing::TransactionCreateUnlinkedRefundParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Transaction)
         }
        def create_unlinked_refund(params = {}, opts = {}); end

        # Refund a test-mode Transaction.
        sig {
          params(transaction: String, params: T.any(::Stripe::TestHelpers::Issuing::TransactionRefundParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Issuing::Transaction)
         }
        def refund(transaction, params = {}, opts = {}); end
      end
    end
  end
end