# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class OutboundPaymentService < StripeService
      # Cancel an OutboundPayment.
      sig {
        params(id: String, params: T.any(::Stripe::Treasury::OutboundPaymentCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
       }
      def cancel(id, params = {}, opts = {}); end

      # Creates an OutboundPayment.
      sig {
        params(params: T.any(::Stripe::Treasury::OutboundPaymentCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of OutboundPayments sent from the specified FinancialAccount.
      sig {
        params(params: T.any(::Stripe::Treasury::OutboundPaymentListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an existing OutboundPayment by passing the unique OutboundPayment ID from either the OutboundPayment creation request or OutboundPayment list.
      sig {
        params(id: String, params: T.any(::Stripe::Treasury::OutboundPaymentRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::OutboundPayment)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end