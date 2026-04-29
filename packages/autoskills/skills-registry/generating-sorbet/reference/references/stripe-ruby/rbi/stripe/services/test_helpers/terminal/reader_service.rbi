# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module TestHelpers
    module Terminal
      class ReaderService < StripeService
        # Presents a payment method on a simulated reader. Can be used to simulate accepting a payment, saving a card or refunding a transaction.
        sig {
          params(reader: String, params: T.any(::Stripe::TestHelpers::Terminal::ReaderPresentPaymentMethodParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
         }
        def present_payment_method(reader, params = {}, opts = {}); end

        # Use this endpoint to trigger a successful input collection on a simulated reader.
        sig {
          params(reader: String, params: T.any(::Stripe::TestHelpers::Terminal::ReaderSucceedInputCollectionParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
         }
        def succeed_input_collection(reader, params = {}, opts = {}); end

        # Use this endpoint to complete an input collection with a timeout error on a simulated reader.
        sig {
          params(reader: String, params: T.any(::Stripe::TestHelpers::Terminal::ReaderTimeoutInputCollectionParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Terminal::Reader)
         }
        def timeout_input_collection(reader, params = {}, opts = {}); end
      end
    end
  end
end