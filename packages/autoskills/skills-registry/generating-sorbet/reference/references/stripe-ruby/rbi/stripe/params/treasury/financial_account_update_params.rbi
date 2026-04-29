# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class FinancialAccountUpdateParams < ::Stripe::RequestParams
      class Features < ::Stripe::RequestParams
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
            returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::FinancialAddresses::Aba))
           }
          def aba; end
          sig {
            params(_aba: T.nilable(Treasury::FinancialAccountUpdateParams::Features::FinancialAddresses::Aba)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::FinancialAddresses::Aba))
           }
          def aba=(_aba); end
          sig {
            params(aba: T.nilable(Treasury::FinancialAccountUpdateParams::Features::FinancialAddresses::Aba)).void
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
            returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::InboundTransfers::Ach))
           }
          def ach; end
          sig {
            params(_ach: T.nilable(Treasury::FinancialAccountUpdateParams::Features::InboundTransfers::Ach)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::InboundTransfers::Ach))
           }
          def ach=(_ach); end
          sig {
            params(ach: T.nilable(Treasury::FinancialAccountUpdateParams::Features::InboundTransfers::Ach)).void
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
            returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments::Ach))
           }
          def ach; end
          sig {
            params(_ach: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments::Ach)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments::Ach))
           }
          def ach=(_ach); end
          # Enables US domestic wire transfers via the OutboundPayments API.
          sig {
            returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments::UsDomesticWire))
           }
          def us_domestic_wire; end
          sig {
            params(_us_domestic_wire: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments::UsDomesticWire)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments::UsDomesticWire))
           }
          def us_domestic_wire=(_us_domestic_wire); end
          sig {
            params(ach: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments::Ach), us_domestic_wire: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments::UsDomesticWire)).void
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
            returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers::Ach))
           }
          def ach; end
          sig {
            params(_ach: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers::Ach)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers::Ach))
           }
          def ach=(_ach); end
          # Enables US domestic wire transfers via the OutboundTransfers API.
          sig {
            returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers::UsDomesticWire))
           }
          def us_domestic_wire; end
          sig {
            params(_us_domestic_wire: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers::UsDomesticWire)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers::UsDomesticWire))
           }
          def us_domestic_wire=(_us_domestic_wire); end
          sig {
            params(ach: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers::Ach), us_domestic_wire: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers::UsDomesticWire)).void
           }
          def initialize(ach: nil, us_domestic_wire: nil); end
        end
        # Encodes the FinancialAccount's ability to be used with the Issuing product, including attaching cards to and drawing funds from the FinancialAccount.
        sig { returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::CardIssuing)) }
        def card_issuing; end
        sig {
          params(_card_issuing: T.nilable(Treasury::FinancialAccountUpdateParams::Features::CardIssuing)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::CardIssuing))
         }
        def card_issuing=(_card_issuing); end
        # Represents whether this FinancialAccount is eligible for deposit insurance. Various factors determine the insurance amount.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::DepositInsurance))
         }
        def deposit_insurance; end
        sig {
          params(_deposit_insurance: T.nilable(Treasury::FinancialAccountUpdateParams::Features::DepositInsurance)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::DepositInsurance))
         }
        def deposit_insurance=(_deposit_insurance); end
        # Contains Features that add FinancialAddresses to the FinancialAccount.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::FinancialAddresses))
         }
        def financial_addresses; end
        sig {
          params(_financial_addresses: T.nilable(Treasury::FinancialAccountUpdateParams::Features::FinancialAddresses)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::FinancialAddresses))
         }
        def financial_addresses=(_financial_addresses); end
        # Contains settings related to adding funds to a FinancialAccount from another Account with the same owner.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::InboundTransfers))
         }
        def inbound_transfers; end
        sig {
          params(_inbound_transfers: T.nilable(Treasury::FinancialAccountUpdateParams::Features::InboundTransfers)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::InboundTransfers))
         }
        def inbound_transfers=(_inbound_transfers); end
        # Represents the ability for the FinancialAccount to send money to, or receive money from other FinancialAccounts (for example, via OutboundPayment).
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::IntraStripeFlows))
         }
        def intra_stripe_flows; end
        sig {
          params(_intra_stripe_flows: T.nilable(Treasury::FinancialAccountUpdateParams::Features::IntraStripeFlows)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::IntraStripeFlows))
         }
        def intra_stripe_flows=(_intra_stripe_flows); end
        # Includes Features related to initiating money movement out of the FinancialAccount to someone else's bucket of money.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments))
         }
        def outbound_payments; end
        sig {
          params(_outbound_payments: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments))
         }
        def outbound_payments=(_outbound_payments); end
        # Contains a Feature and settings related to moving money out of the FinancialAccount into another Account with the same owner.
        sig {
          returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers))
         }
        def outbound_transfers; end
        sig {
          params(_outbound_transfers: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers))
         }
        def outbound_transfers=(_outbound_transfers); end
        sig {
          params(card_issuing: T.nilable(Treasury::FinancialAccountUpdateParams::Features::CardIssuing), deposit_insurance: T.nilable(Treasury::FinancialAccountUpdateParams::Features::DepositInsurance), financial_addresses: T.nilable(Treasury::FinancialAccountUpdateParams::Features::FinancialAddresses), inbound_transfers: T.nilable(Treasury::FinancialAccountUpdateParams::Features::InboundTransfers), intra_stripe_flows: T.nilable(Treasury::FinancialAccountUpdateParams::Features::IntraStripeFlows), outbound_payments: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundPayments), outbound_transfers: T.nilable(Treasury::FinancialAccountUpdateParams::Features::OutboundTransfers)).void
         }
        def initialize(
          card_issuing: nil,
          deposit_insurance: nil,
          financial_addresses: nil,
          inbound_transfers: nil,
          intra_stripe_flows: nil,
          outbound_payments: nil,
          outbound_transfers: nil
        ); end
      end
      class ForwardingSettings < ::Stripe::RequestParams
        # The financial_account id
        sig { returns(T.nilable(String)) }
        def financial_account; end
        sig { params(_financial_account: T.nilable(String)).returns(T.nilable(String)) }
        def financial_account=(_financial_account); end
        # The payment_method or bank account id. This needs to be a verified bank account.
        sig { returns(T.nilable(String)) }
        def payment_method; end
        sig { params(_payment_method: T.nilable(String)).returns(T.nilable(String)) }
        def payment_method=(_payment_method); end
        # The type of the bank account provided. This can be either "financial_account" or "payment_method"
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(financial_account: T.nilable(String), payment_method: T.nilable(String), type: String).void
         }
        def initialize(financial_account: nil, payment_method: nil, type: nil); end
      end
      class PlatformRestrictions < ::Stripe::RequestParams
        # Restricts all inbound money movement.
        sig { returns(T.nilable(String)) }
        def inbound_flows; end
        sig { params(_inbound_flows: T.nilable(String)).returns(T.nilable(String)) }
        def inbound_flows=(_inbound_flows); end
        # Restricts all outbound money movement.
        sig { returns(T.nilable(String)) }
        def outbound_flows; end
        sig { params(_outbound_flows: T.nilable(String)).returns(T.nilable(String)) }
        def outbound_flows=(_outbound_flows); end
        sig { params(inbound_flows: T.nilable(String), outbound_flows: T.nilable(String)).void }
        def initialize(inbound_flows: nil, outbound_flows: nil); end
      end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Encodes whether a FinancialAccount has access to a particular feature, with a status enum and associated `status_details`. Stripe or the platform may control features via the requested field.
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features)) }
      def features; end
      sig {
        params(_features: T.nilable(Treasury::FinancialAccountUpdateParams::Features)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::Features))
       }
      def features=(_features); end
      # A different bank account where funds can be deposited/debited in order to get the closing FA's balance to $0
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateParams::ForwardingSettings)) }
      def forwarding_settings; end
      sig {
        params(_forwarding_settings: T.nilable(Treasury::FinancialAccountUpdateParams::ForwardingSettings)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::ForwardingSettings))
       }
      def forwarding_settings=(_forwarding_settings); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The nickname for the FinancialAccount.
      sig { returns(T.nilable(String)) }
      def nickname; end
      sig { params(_nickname: T.nilable(String)).returns(T.nilable(String)) }
      def nickname=(_nickname); end
      # The set of functionalities that the platform can restrict on the FinancialAccount.
      sig { returns(T.nilable(Treasury::FinancialAccountUpdateParams::PlatformRestrictions)) }
      def platform_restrictions; end
      sig {
        params(_platform_restrictions: T.nilable(Treasury::FinancialAccountUpdateParams::PlatformRestrictions)).returns(T.nilable(Treasury::FinancialAccountUpdateParams::PlatformRestrictions))
       }
      def platform_restrictions=(_platform_restrictions); end
      sig {
        params(expand: T.nilable(T::Array[String]), features: T.nilable(Treasury::FinancialAccountUpdateParams::Features), forwarding_settings: T.nilable(Treasury::FinancialAccountUpdateParams::ForwardingSettings), metadata: T.nilable(T::Hash[String, String]), nickname: T.nilable(String), platform_restrictions: T.nilable(Treasury::FinancialAccountUpdateParams::PlatformRestrictions)).void
       }
      def initialize(
        expand: nil,
        features: nil,
        forwarding_settings: nil,
        metadata: nil,
        nickname: nil,
        platform_restrictions: nil
      ); end
    end
  end
end