# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class OutboundTransferReturnOutboundTransferParams < ::Stripe::RequestParams
      class ReturnedDetails < ::Stripe::RequestParams
        # Reason for the return.
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
      # Details about a returned OutboundTransfer.
      sig {
        returns(T.nilable(Treasury::OutboundTransferReturnOutboundTransferParams::ReturnedDetails))
       }
      def returned_details; end
      sig {
        params(_returned_details: T.nilable(Treasury::OutboundTransferReturnOutboundTransferParams::ReturnedDetails)).returns(T.nilable(Treasury::OutboundTransferReturnOutboundTransferParams::ReturnedDetails))
       }
      def returned_details=(_returned_details); end
      sig {
        params(expand: T.nilable(T::Array[String]), returned_details: T.nilable(Treasury::OutboundTransferReturnOutboundTransferParams::ReturnedDetails)).void
       }
      def initialize(expand: nil, returned_details: nil); end
    end
  end
end