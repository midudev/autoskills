# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ReaderRefundPaymentParams < ::Stripe::RequestParams
      class RefundPaymentConfig < ::Stripe::RequestParams
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
      # A positive integer in __cents__ representing how much of this charge to refund.
      sig { returns(T.nilable(Integer)) }
      def amount; end
      sig { params(_amount: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount=(_amount); end
      # ID of the Charge to refund.
      sig { returns(T.nilable(String)) }
      def charge; end
      sig { params(_charge: T.nilable(String)).returns(T.nilable(String)) }
      def charge=(_charge); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # ID of the PaymentIntent to refund.
      sig { returns(T.nilable(String)) }
      def payment_intent; end
      sig { params(_payment_intent: T.nilable(String)).returns(T.nilable(String)) }
      def payment_intent=(_payment_intent); end
      # Boolean indicating whether the application fee should be refunded when refunding this charge. If a full charge refund is given, the full application fee will be refunded. Otherwise, the application fee will be refunded in an amount proportional to the amount of the charge refunded. An application fee can be refunded only by the application that created the charge.
      sig { returns(T.nilable(T::Boolean)) }
      def refund_application_fee; end
      sig { params(_refund_application_fee: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def refund_application_fee=(_refund_application_fee); end
      # Configuration overrides for this refund, such as customer cancellation settings.
      sig { returns(T.nilable(Terminal::ReaderRefundPaymentParams::RefundPaymentConfig)) }
      def refund_payment_config; end
      sig {
        params(_refund_payment_config: T.nilable(Terminal::ReaderRefundPaymentParams::RefundPaymentConfig)).returns(T.nilable(Terminal::ReaderRefundPaymentParams::RefundPaymentConfig))
       }
      def refund_payment_config=(_refund_payment_config); end
      # Boolean indicating whether the transfer should be reversed when refunding this charge. The transfer will be reversed proportionally to the amount being refunded (either the entire or partial amount). A transfer can be reversed only by the application that created the charge.
      sig { returns(T.nilable(T::Boolean)) }
      def reverse_transfer; end
      sig { params(_reverse_transfer: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def reverse_transfer=(_reverse_transfer); end
      sig {
        params(amount: T.nilable(Integer), charge: T.nilable(String), expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), payment_intent: T.nilable(String), refund_application_fee: T.nilable(T::Boolean), refund_payment_config: T.nilable(Terminal::ReaderRefundPaymentParams::RefundPaymentConfig), reverse_transfer: T.nilable(T::Boolean)).void
       }
      def initialize(
        amount: nil,
        charge: nil,
        expand: nil,
        metadata: nil,
        payment_intent: nil,
        refund_application_fee: nil,
        refund_payment_config: nil,
        reverse_transfer: nil
      ); end
    end
  end
end