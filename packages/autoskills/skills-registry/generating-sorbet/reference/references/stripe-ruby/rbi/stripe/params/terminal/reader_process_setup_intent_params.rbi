# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ReaderProcessSetupIntentParams < ::Stripe::RequestParams
      class ProcessConfig < ::Stripe::RequestParams
        # Enables cancel button on transaction screens.
        sig { returns(T.nilable(T::Boolean)) }
        def enable_customer_cancellation; end
        sig {
          params(_enable_customer_cancellation: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
         }
        def enable_customer_cancellation=(_enable_customer_cancellation); end
        sig { params(enable_customer_cancellation: T.nilable(T::Boolean)).void }
        def initialize(enable_customer_cancellation: nil); end
      end
      # This field indicates whether this payment method can be shown again to its customer in a checkout flow. Stripe products such as Checkout and Elements use this field to determine whether a payment method can be shown as a saved payment method in a checkout flow.
      sig { returns(String) }
      def allow_redisplay; end
      sig { params(_allow_redisplay: String).returns(String) }
      def allow_redisplay=(_allow_redisplay); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Configuration overrides for this setup, such as MOTO and customer cancellation settings.
      sig { returns(T.nilable(Terminal::ReaderProcessSetupIntentParams::ProcessConfig)) }
      def process_config; end
      sig {
        params(_process_config: T.nilable(Terminal::ReaderProcessSetupIntentParams::ProcessConfig)).returns(T.nilable(Terminal::ReaderProcessSetupIntentParams::ProcessConfig))
       }
      def process_config=(_process_config); end
      # The ID of the SetupIntent to process on the reader.
      sig { returns(String) }
      def setup_intent; end
      sig { params(_setup_intent: String).returns(String) }
      def setup_intent=(_setup_intent); end
      sig {
        params(allow_redisplay: String, expand: T.nilable(T::Array[String]), process_config: T.nilable(Terminal::ReaderProcessSetupIntentParams::ProcessConfig), setup_intent: String).void
       }
      def initialize(allow_redisplay: nil, expand: nil, process_config: nil, setup_intent: nil); end
    end
  end
end