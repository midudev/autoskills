# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class OutboundTransferCreateParams < ::Stripe::RequestParams
      class DestinationPaymentMethodData < ::Stripe::RequestParams
        # Required if type is set to `financial_account`. The FinancialAccount ID to send funds to.
        sig { returns(T.nilable(String)) }
        def financial_account; end
        sig { params(_financial_account: T.nilable(String)).returns(T.nilable(String)) }
        def financial_account=(_financial_account); end
        # The type of the destination.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig { params(financial_account: T.nilable(String), type: String).void }
        def initialize(financial_account: nil, type: nil); end
      end
      class DestinationPaymentMethodOptions < ::Stripe::RequestParams
        class UsBankAccount < ::Stripe::RequestParams
          # Specifies the network rails to be used. If not set, will default to the PaymentMethod's preferred network. See the [docs](https://docs.stripe.com/treasury/money-movement/timelines) to learn more about money movement timelines for each network type.
          sig { returns(T.nilable(String)) }
          def network; end
          sig { params(_network: T.nilable(String)).returns(T.nilable(String)) }
          def network=(_network); end
          sig { params(network: T.nilable(String)).void }
          def initialize(network: nil); end
        end
        # Optional fields for `us_bank_account`.
        sig {
          returns(T.nilable(T.any(String, Treasury::OutboundTransferCreateParams::DestinationPaymentMethodOptions::UsBankAccount)))
         }
        def us_bank_account; end
        sig {
          params(_us_bank_account: T.nilable(T.any(String, Treasury::OutboundTransferCreateParams::DestinationPaymentMethodOptions::UsBankAccount))).returns(T.nilable(T.any(String, Treasury::OutboundTransferCreateParams::DestinationPaymentMethodOptions::UsBankAccount)))
         }
        def us_bank_account=(_us_bank_account); end
        sig {
          params(us_bank_account: T.nilable(T.any(String, Treasury::OutboundTransferCreateParams::DestinationPaymentMethodOptions::UsBankAccount))).void
         }
        def initialize(us_bank_account: nil); end
      end
      # Amount (in cents) to be transferred.
      sig { returns(Integer) }
      def amount; end
      sig { params(_amount: Integer).returns(Integer) }
      def amount=(_amount); end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      sig { params(_currency: String).returns(String) }
      def currency=(_currency); end
      # An arbitrary string attached to the object. Often useful for displaying to users.
      sig { returns(T.nilable(String)) }
      def description; end
      sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
      def description=(_description); end
      # The PaymentMethod to use as the payment instrument for the OutboundTransfer.
      sig { returns(T.nilable(String)) }
      def destination_payment_method; end
      sig { params(_destination_payment_method: T.nilable(String)).returns(T.nilable(String)) }
      def destination_payment_method=(_destination_payment_method); end
      # Hash used to generate the PaymentMethod to be used for this OutboundTransfer. Exclusive with `destination_payment_method`.
      sig {
        returns(T.nilable(Treasury::OutboundTransferCreateParams::DestinationPaymentMethodData))
       }
      def destination_payment_method_data; end
      sig {
        params(_destination_payment_method_data: T.nilable(Treasury::OutboundTransferCreateParams::DestinationPaymentMethodData)).returns(T.nilable(Treasury::OutboundTransferCreateParams::DestinationPaymentMethodData))
       }
      def destination_payment_method_data=(_destination_payment_method_data); end
      # Hash describing payment method configuration details.
      sig {
        returns(T.nilable(Treasury::OutboundTransferCreateParams::DestinationPaymentMethodOptions))
       }
      def destination_payment_method_options; end
      sig {
        params(_destination_payment_method_options: T.nilable(Treasury::OutboundTransferCreateParams::DestinationPaymentMethodOptions)).returns(T.nilable(Treasury::OutboundTransferCreateParams::DestinationPaymentMethodOptions))
       }
      def destination_payment_method_options=(_destination_payment_method_options); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The FinancialAccount to pull funds from.
      sig { returns(String) }
      def financial_account; end
      sig { params(_financial_account: String).returns(String) }
      def financial_account=(_financial_account); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # Statement descriptor to be shown on the receiving end of an OutboundTransfer. Maximum 10 characters for `ach` transfers or 140 characters for `us_domestic_wire` transfers. The default value is "transfer". Can only include -#.$&*, spaces, and alphanumeric characters.
      sig { returns(T.nilable(String)) }
      def statement_descriptor; end
      sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
      def statement_descriptor=(_statement_descriptor); end
      sig {
        params(amount: Integer, currency: String, description: T.nilable(String), destination_payment_method: T.nilable(String), destination_payment_method_data: T.nilable(Treasury::OutboundTransferCreateParams::DestinationPaymentMethodData), destination_payment_method_options: T.nilable(Treasury::OutboundTransferCreateParams::DestinationPaymentMethodOptions), expand: T.nilable(T::Array[String]), financial_account: String, metadata: T.nilable(T::Hash[String, String]), statement_descriptor: T.nilable(String)).void
       }
      def initialize(
        amount: nil,
        currency: nil,
        description: nil,
        destination_payment_method: nil,
        destination_payment_method_data: nil,
        destination_payment_method_options: nil,
        expand: nil,
        financial_account: nil,
        metadata: nil,
        statement_descriptor: nil
      ); end
    end
  end
end