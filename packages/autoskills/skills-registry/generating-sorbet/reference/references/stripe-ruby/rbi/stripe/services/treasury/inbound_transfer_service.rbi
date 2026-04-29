# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class InboundTransferService < StripeService
      # Cancels an InboundTransfer.
      sig {
        params(inbound_transfer: String, params: T.any(::Stripe::Treasury::InboundTransferCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
       }
      def cancel(inbound_transfer, params = {}, opts = {}); end

      # Creates an InboundTransfer.
      sig {
        params(params: T.any(::Stripe::Treasury::InboundTransferCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
       }
      def create(params = {}, opts = {}); end

      # Returns a list of InboundTransfers sent from the specified FinancialAccount.
      sig {
        params(params: T.any(::Stripe::Treasury::InboundTransferListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of an existing InboundTransfer.
      sig {
        params(id: String, params: T.any(::Stripe::Treasury::InboundTransferRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::InboundTransfer)
       }
      def retrieve(id, params = {}, opts = {}); end
    end
  end
end