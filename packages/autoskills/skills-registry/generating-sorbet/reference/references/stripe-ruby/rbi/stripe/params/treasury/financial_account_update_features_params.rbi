# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class FinancialAccountUpdateFeaturesParams < ::Stripe::RequestParams
      class CardIssuing < ::Stripe::RequestParams
        # Whether the FinancialAccount should have the Feature.
        sig { returns(T::Boolean) }
        def requested; end
        sig { params(_requested: T::Boolean).returns(T::Boolean) }
        def requested=(_requested); end
        sig { params(requested: T::Boolean).void }
        def initialize(requested: nil); end
      end
      class DepositInsurance < ::Stripe::RequestParams
        # Whether the FinancialAccount should have the Feature.
        sig { returns(T::Boolean) }
        def requested; end
        sig { params(_requested: T::Boolean).returns(T::Boolean) }
        def requested=(_requested); end
        sig { params(requested: T::Boolean).void }
        def initialize(requested: nil); end
      end
      class FinancialAddresses < ::Stripe::RequestParams
        class Aba < ::Stripe::RequestParams
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          sig { params(_requested: T::Boolean).returns(T::Boolean) }
          def requested=(_requested); end
          sig { params(requested: T::Boolean).void }
          def initialize(requested: nil); end
        end
        # Adds an ABA FinancialAddress to the FinancialAccount.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::FinancialAddresses::Aba))
         }
        def aba; end
        sig {
          params(_aba: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::FinancialAddresses::Aba)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::FinancialAddresses::Aba))
         }
        def aba=(_aba); end
        sig {
          params(aba: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::FinancialAddresses::Aba)).void
         }
        def initialize(aba: nil); end
      end
      class InboundTransfers < ::Stripe::RequestParams
        class Ach < ::Stripe::RequestParams
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          sig { params(_requested: T::Boolean).returns(T::Boolean) }
          def requested=(_requested); end
          sig { params(requested: T::Boolean).void }
          def initialize(requested: nil); end
        end
        # Enables ACH Debits via the InboundTransfers API.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::InboundTransfers::Ach))
         }
        def ach; end
        sig {
          params(_ach: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::InboundTransfers::Ach)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::InboundTransfers::Ach))
         }
        def ach=(_ach); end
        sig {
          params(ach: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::InboundTransfers::Ach)).void
         }
        def initialize(ach: nil); end
      end
      class IntraStripeFlows < ::Stripe::RequestParams
        # Whether the FinancialAccount should have the Feature.
        sig { returns(T::Boolean) }
        def requested; end
        sig { params(_requested: T::Boolean).returns(T::Boolean) }
        def requested=(_requested); end
        sig { params(requested: T::Boolean).void }
        def initialize(requested: nil); end
      end
      class OutboundPayments < ::Stripe::RequestParams
        class Ach < ::Stripe::RequestParams
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          sig { params(_requested: T::Boolean).returns(T::Boolean) }
          def requested=(_requested); end
          sig { params(requested: T::Boolean).void }
          def initialize(requested: nil); end
        end
        class UsDomesticWire < ::Stripe::RequestParams
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          sig { params(_requested: T::Boolean).returns(T::Boolean) }
          def requested=(_requested); end
          sig { params(requested: T::Boolean).void }
          def initialize(requested: nil); end
        end
        # Enables ACH transfers via the OutboundPayments API.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments::Ach))
         }
        def ach; end
        sig {
          params(_ach: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments::Ach)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments::Ach))
         }
        def ach=(_ach); end
        # Enables US domestic wire transfers via the OutboundPayments API.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments::UsDomesticWire))
         }
        def us_domestic_wire; end
        sig {
          params(_us_domestic_wire: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments::UsDomesticWire)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments::UsDomesticWire))
         }
        def us_domestic_wire=(_us_domestic_wire); end
        sig {
          params(ach: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments::Ach), us_domestic_wire: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments::UsDomesticWire)).void
         }
        def initialize(ach: nil, us_domestic_wire: nil); end
      end
      class OutboundTransfers < ::Stripe::RequestParams
        class Ach < ::Stripe::RequestParams
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          sig { params(_requested: T::Boolean).returns(T::Boolean) }
          def requested=(_requested); end
          sig { params(requested: T::Boolean).void }
          def initialize(requested: nil); end
        end
        class UsDomesticWire < ::Stripe::RequestParams
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          sig { params(_requested: T::Boolean).returns(T::Boolean) }
          def requested=(_requested); end
          sig { params(requested: T::Boolean).void }
          def initialize(requested: nil); end
        end
        # Enables ACH transfers via the OutboundTransfers API.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers::Ach))
         }
        def ach; end
        sig {
          params(_ach: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers::Ach)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers::Ach))
         }
        def ach=(_ach); end
        # Enables US domestic wire transfers via the OutboundTransfers API.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers::UsDomesticWire))
         }
        def us_domestic_wire; end
        sig {
          params(_us_domestic_wire: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers::UsDomesticWire)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers::UsDomesticWire))
         }
        def us_domestic_wire=(_us_domestic_wire); end
        sig {
          params(ach: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers::Ach), us_domestic_wire: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers::UsDomesticWire)).void
         }
        def initialize(ach: nil, us_domestic_wire: nil); end
      end
      # Encodes the FinancialAccount's ability to be used with the Issuing product, including attaching cards to and drawing funds from the FinancialAccount.
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::CardIssuing)) }
      def card_issuing; end
      sig {
        params(_card_issuing: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::CardIssuing)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::CardIssuing))
       }
      def card_issuing=(_card_issuing); end
      # Represents whether this FinancialAccount is eligible for deposit insurance. Various factors determine the insurance amount.
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::DepositInsurance)) }
      def deposit_insurance; end
      sig {
        params(_deposit_insurance: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::DepositInsurance)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::DepositInsurance))
       }
      def deposit_insurance=(_deposit_insurance); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Contains Features that add FinancialAddresses to the FinancialAccount.
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::FinancialAddresses)) }
      def financial_addresses; end
      sig {
        params(_financial_addresses: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::FinancialAddresses)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::FinancialAddresses))
       }
      def financial_addresses=(_financial_addresses); end
      # Contains settings related to adding funds to a FinancialAccount from another Account with the same owner.
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::InboundTransfers)) }
      def inbound_transfers; end
      sig {
        params(_inbound_transfers: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::InboundTransfers)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::InboundTransfers))
       }
      def inbound_transfers=(_inbound_transfers); end
      # Represents the ability for the FinancialAccount to send money to, or receive money from other FinancialAccounts (for example, via OutboundPayment).
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::IntraStripeFlows)) }
      def intra_stripe_flows; end
      sig {
        params(_intra_stripe_flows: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::IntraStripeFlows)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::IntraStripeFlows))
       }
      def intra_stripe_flows=(_intra_stripe_flows); end
      # Includes Features related to initiating money movement out of the FinancialAccount to someone else's bucket of money.
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments)) }
      def outbound_payments; end
      sig {
        params(_outbound_payments: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments))
       }
      def outbound_payments=(_outbound_payments); end
      # Contains a Feature and settings related to moving money out of the FinancialAccount into another Account with the same owner.
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers)) }
      def outbound_transfers; end
      sig {
        params(_outbound_transfers: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers)).returns(T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers))
       }
      def outbound_transfers=(_outbound_transfers); end
      sig {
        params(card_issuing: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::CardIssuing), deposit_insurance: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::DepositInsurance), expand: T.nilable(T::Array[String]), financial_addresses: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::FinancialAddresses), inbound_transfers: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::InboundTransfers), intra_stripe_flows: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::IntraStripeFlows), outbound_payments: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundPayments), outbound_transfers: T.nilable(Treasury::FinancialAccountUpdateFeaturesParams::OutboundTransfers)).void
       }
      def initialize(
        card_issuing: nil,
        deposit_insurance: nil,
        expand: nil,
        financial_addresses: nil,
        inbound_transfers: nil,
        intra_stripe_flows: nil,
        outbound_payments: nil,
        outbound_transfers: nil
      ); end
    end
  end
end