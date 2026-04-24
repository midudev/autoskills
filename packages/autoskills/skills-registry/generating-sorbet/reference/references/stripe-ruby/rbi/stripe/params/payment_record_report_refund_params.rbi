# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PaymentRecordReportRefundParams < ::Stripe::RequestParams
    class Amount < ::Stripe::RequestParams
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      sig { params(_currency: String).returns(String) }
      def currency=(_currency); end
      # A positive integer representing the amount in the currency's [minor unit](https://docs.stripe.com/currencies#zero-decimal). For example, `100` can represent 1 USD or 100 JPY.
      sig { returns(Integer) }
      def value; end
      sig { params(_value: Integer).returns(Integer) }
      def value=(_value); end
      sig { params(currency: String, value: Integer).void }
      def initialize(currency: nil, value: nil); end
    end
    class ProcessorDetails < ::Stripe::RequestParams
      class Custom < ::Stripe::RequestParams
        # A reference to the external refund. This field must be unique across all refunds.
        sig { returns(String) }
        def refund_reference; end
        sig { params(_refund_reference: String).returns(String) }
        def refund_reference=(_refund_reference); end
        sig { params(refund_reference: String).void }
        def initialize(refund_reference: nil); end
      end
      # Information about the custom processor used to make this refund.
      sig { returns(T.nilable(PaymentRecordReportRefundParams::ProcessorDetails::Custom)) }
      def custom; end
      sig {
        params(_custom: T.nilable(PaymentRecordReportRefundParams::ProcessorDetails::Custom)).returns(T.nilable(PaymentRecordReportRefundParams::ProcessorDetails::Custom))
       }
      def custom=(_custom); end
      # The type of the processor details. An additional hash is included on processor_details with a name matching this value. It contains additional information specific to the processor.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig {
        params(custom: T.nilable(PaymentRecordReportRefundParams::ProcessorDetails::Custom), type: String).void
       }
      def initialize(custom: nil, type: nil); end
    end
    class Refunded < ::Stripe::RequestParams
      # When the reported refund completed. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def refunded_at; end
      sig { params(_refunded_at: Integer).returns(Integer) }
      def refunded_at=(_refunded_at); end
      sig { params(refunded_at: Integer).void }
      def initialize(refunded_at: nil); end
    end
    # A positive integer in the [smallest currency unit](https://docs.stripe.com/currencies#zero-decimal) representing how much of this payment to refund. Can refund only up to the remaining, unrefunded amount of the payment.
    sig { returns(T.nilable(PaymentRecordReportRefundParams::Amount)) }
    def amount; end
    sig {
      params(_amount: T.nilable(PaymentRecordReportRefundParams::Amount)).returns(T.nilable(PaymentRecordReportRefundParams::Amount))
     }
    def amount=(_amount); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # When the reported refund was initiated. Measured in seconds since the Unix epoch.
    sig { returns(T.nilable(Integer)) }
    def initiated_at; end
    sig { params(_initiated_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def initiated_at=(_initiated_at); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # The outcome of the reported refund.
    sig { returns(String) }
    def outcome; end
    sig { params(_outcome: String).returns(String) }
    def outcome=(_outcome); end
    # Processor information for this refund.
    sig { returns(PaymentRecordReportRefundParams::ProcessorDetails) }
    def processor_details; end
    sig {
      params(_processor_details: PaymentRecordReportRefundParams::ProcessorDetails).returns(PaymentRecordReportRefundParams::ProcessorDetails)
     }
    def processor_details=(_processor_details); end
    # Information about the payment attempt refund.
    sig { returns(PaymentRecordReportRefundParams::Refunded) }
    def refunded; end
    sig {
      params(_refunded: PaymentRecordReportRefundParams::Refunded).returns(PaymentRecordReportRefundParams::Refunded)
     }
    def refunded=(_refunded); end
    sig {
      params(amount: T.nilable(PaymentRecordReportRefundParams::Amount), expand: T.nilable(T::Array[String]), initiated_at: T.nilable(Integer), metadata: T.nilable(T.any(String, T::Hash[String, String])), outcome: String, processor_details: PaymentRecordReportRefundParams::ProcessorDetails, refunded: PaymentRecordReportRefundParams::Refunded).void
     }
    def initialize(
      amount: nil,
      expand: nil,
      initiated_at: nil,
      metadata: nil,
      outcome: nil,
      processor_details: nil,
      refunded: nil
    ); end
  end
end