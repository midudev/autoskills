# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class OutboundPaymentUpdateParams < ::Stripe::RequestParams
      class TrackingDetails < ::Stripe::RequestParams
        class Ach < ::Stripe::RequestParams
          # ACH trace ID for funds sent over the `ach` network.
          sig { returns(String) }
          def trace_id; end
          sig { params(_trace_id: String).returns(String) }
          def trace_id=(_trace_id); end
          sig { params(trace_id: String).void }
          def initialize(trace_id: nil); end
        end
        class UsDomesticWire < ::Stripe::RequestParams
          # CHIPS System Sequence Number (SSN) for funds sent over the `us_domestic_wire` network.
          sig { returns(T.nilable(String)) }
          def chips; end
          sig { params(_chips: T.nilable(String)).returns(T.nilable(String)) }
          def chips=(_chips); end
          # IMAD for funds sent over the `us_domestic_wire` network.
          sig { returns(T.nilable(String)) }
          def imad; end
          sig { params(_imad: T.nilable(String)).returns(T.nilable(String)) }
          def imad=(_imad); end
          # OMAD for funds sent over the `us_domestic_wire` network.
          sig { returns(T.nilable(String)) }
          def omad; end
          sig { params(_omad: T.nilable(String)).returns(T.nilable(String)) }
          def omad=(_omad); end
          sig {
            params(chips: T.nilable(String), imad: T.nilable(String), omad: T.nilable(String)).void
           }
          def initialize(chips: nil, imad: nil, omad: nil); end
        end
        # ACH network tracking details.
        sig { returns(T.nilable(Treasury::OutboundPaymentUpdateParams::TrackingDetails::Ach)) }
        def ach; end
        sig {
          params(_ach: T.nilable(Treasury::OutboundPaymentUpdateParams::TrackingDetails::Ach)).returns(T.nilable(Treasury::OutboundPaymentUpdateParams::TrackingDetails::Ach))
         }
        def ach=(_ach); end
        # The US bank account network used to send funds.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        # US domestic wire network tracking details.
        sig {
          returns(T.nilable(Treasury::OutboundPaymentUpdateParams::TrackingDetails::UsDomesticWire))
         }
        def us_domestic_wire; end
        sig {
          params(_us_domestic_wire: T.nilable(Treasury::OutboundPaymentUpdateParams::TrackingDetails::UsDomesticWire)).returns(T.nilable(Treasury::OutboundPaymentUpdateParams::TrackingDetails::UsDomesticWire))
         }
        def us_domestic_wire=(_us_domestic_wire); end
        sig {
          params(ach: T.nilable(Treasury::OutboundPaymentUpdateParams::TrackingDetails::Ach), type: String, us_domestic_wire: T.nilable(Treasury::OutboundPaymentUpdateParams::TrackingDetails::UsDomesticWire)).void
         }
        def initialize(ach: nil, type: nil, us_domestic_wire: nil); end
      end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Details about network-specific tracking information.
      sig { returns(Treasury::OutboundPaymentUpdateParams::TrackingDetails) }
      def tracking_details; end
      sig {
        params(_tracking_details: Treasury::OutboundPaymentUpdateParams::TrackingDetails).returns(Treasury::OutboundPaymentUpdateParams::TrackingDetails)
       }
      def tracking_details=(_tracking_details); end
      sig {
        params(expand: T.nilable(T::Array[String]), tracking_details: Treasury::OutboundPaymentUpdateParams::TrackingDetails).void
       }
      def initialize(expand: nil, tracking_details: nil); end
    end
  end
end