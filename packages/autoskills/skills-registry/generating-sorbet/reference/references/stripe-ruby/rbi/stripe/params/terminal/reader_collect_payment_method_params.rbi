# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ReaderCollectPaymentMethodParams < ::Stripe::RequestParams
      class CollectConfig < ::Stripe::RequestParams
        class Tipping < ::Stripe::RequestParams
          # Amount used to calculate tip suggestions on tipping selection screen for this transaction. Must be a positive integer in the smallest currency unit (e.g., 100 cents to represent $1.00 or 100 to represent ¥100, a zero-decimal currency).
          sig { returns(T.nilable(Integer)) }
          def amount_eligible; end
          sig { params(_amount_eligible: T.nilable(Integer)).returns(T.nilable(Integer)) }
          def amount_eligible=(_amount_eligible); end
          sig { params(amount_eligible: T.nilable(Integer)).void }
          def initialize(amount_eligible: nil); end
        end
        # This field indicates whether this payment method can be shown again to its customer in a checkout flow. Stripe products such as Checkout and Elements use this field to determine whether a payment method can be shown as a saved payment method in a checkout flow.
        sig { returns(T.nilable(String)) }
        def allow_redisplay; end
        sig { params(_allow_redisplay: T.nilable(String)).returns(T.nilable(String)) }
        def allow_redisplay=(_allow_redisplay); end
        # Enables cancel button on transaction screens.
        sig { returns(T.nilable(T::Boolean)) }
        def enable_customer_cancellation; end
        sig {
          params(_enable_customer_cancellation: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean))
         }
        def enable_customer_cancellation=(_enable_customer_cancellation); end
        # Override showing a tipping selection screen on this transaction.
        sig { returns(T.nilable(T::Boolean)) }
        def skip_tipping; end
        sig { params(_skip_tipping: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
        def skip_tipping=(_skip_tipping); end
        # Tipping configuration for this transaction.
        sig {
          returns(T.nilable(Terminal::ReaderCollectPaymentMethodParams::CollectConfig::Tipping))
         }
        def tipping; end
        sig {
          params(_tipping: T.nilable(Terminal::ReaderCollectPaymentMethodParams::CollectConfig::Tipping)).returns(T.nilable(Terminal::ReaderCollectPaymentMethodParams::CollectConfig::Tipping))
         }
        def tipping=(_tipping); end
        sig {
          params(allow_redisplay: T.nilable(String), enable_customer_cancellation: T.nilable(T::Boolean), skip_tipping: T.nilable(T::Boolean), tipping: T.nilable(Terminal::ReaderCollectPaymentMethodParams::CollectConfig::Tipping)).void
         }
        def initialize(
          allow_redisplay: nil,
          enable_customer_cancellation: nil,
          skip_tipping: nil,
          tipping: nil
        ); end
      end
      # Configuration overrides for this collection, such as tipping, surcharging, and customer cancellation settings.
      sig { returns(T.nilable(Terminal::ReaderCollectPaymentMethodParams::CollectConfig)) }
      def collect_config; end
      sig {
        params(_collect_config: T.nilable(Terminal::ReaderCollectPaymentMethodParams::CollectConfig)).returns(T.nilable(Terminal::ReaderCollectPaymentMethodParams::CollectConfig))
       }
      def collect_config=(_collect_config); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The ID of the PaymentIntent to collect a payment method for.
      sig { returns(String) }
      def payment_intent; end
      sig { params(_payment_intent: String).returns(String) }
      def payment_intent=(_payment_intent); end
      sig {
        params(collect_config: T.nilable(Terminal::ReaderCollectPaymentMethodParams::CollectConfig), expand: T.nilable(T::Array[String]), payment_intent: String).void
       }
      def initialize(collect_config: nil, expand: nil, payment_intent: nil); end
    end
  end
end