# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    # Encodes whether a FinancialAccount has access to a particular Feature, with a `status` enum and associated `status_details`.
    # Stripe or the platform can control Features via the requested field.
    class FinancialAccountFeatures < APIResource
      class CardIssuing < ::Stripe::StripeObject
        class StatusDetail < ::Stripe::StripeObject
          # Represents the reason why the status is `pending` or `restricted`.
          sig { returns(String) }
          def code; end
          # Represents what the user should do, if anything, to activate the Feature.
          sig { returns(T.nilable(String)) }
          def resolution; end
          # The `platform_restrictions` that are restricting this Feature.
          sig { returns(T.nilable(String)) }
          def restriction; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the FinancialAccount should have the Feature.
        sig { returns(T::Boolean) }
        def requested; end
        # Whether the Feature is operational.
        sig { returns(String) }
        def status; end
        # Additional details; includes at least one entry when the status is not `active`.
        sig { returns(T::Array[StatusDetail]) }
        def status_details; end
        def self.inner_class_types
          @inner_class_types = {status_details: StatusDetail}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class DepositInsurance < ::Stripe::StripeObject
        class StatusDetail < ::Stripe::StripeObject
          # Represents the reason why the status is `pending` or `restricted`.
          sig { returns(String) }
          def code; end
          # Represents what the user should do, if anything, to activate the Feature.
          sig { returns(T.nilable(String)) }
          def resolution; end
          # The `platform_restrictions` that are restricting this Feature.
          sig { returns(T.nilable(String)) }
          def restriction; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the FinancialAccount should have the Feature.
        sig { returns(T::Boolean) }
        def requested; end
        # Whether the Feature is operational.
        sig { returns(String) }
        def status; end
        # Additional details; includes at least one entry when the status is not `active`.
        sig { returns(T::Array[StatusDetail]) }
        def status_details; end
        def self.inner_class_types
          @inner_class_types = {status_details: StatusDetail}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class FinancialAddresses < ::Stripe::StripeObject
        class Aba < ::Stripe::StripeObject
          class StatusDetail < ::Stripe::StripeObject
            # Represents the reason why the status is `pending` or `restricted`.
            sig { returns(String) }
            def code; end
            # Represents what the user should do, if anything, to activate the Feature.
            sig { returns(T.nilable(String)) }
            def resolution; end
            # The `platform_restrictions` that are restricting this Feature.
            sig { returns(T.nilable(String)) }
            def restriction; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          # Whether the Feature is operational.
          sig { returns(String) }
          def status; end
          # Additional details; includes at least one entry when the status is not `active`.
          sig { returns(T::Array[StatusDetail]) }
          def status_details; end
          def self.inner_class_types
            @inner_class_types = {status_details: StatusDetail}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Toggle settings for enabling/disabling the ABA address feature
        sig { returns(T.nilable(Aba)) }
        def aba; end
        def self.inner_class_types
          @inner_class_types = {aba: Aba}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class InboundTransfers < ::Stripe::StripeObject
        class Ach < ::Stripe::StripeObject
          class StatusDetail < ::Stripe::StripeObject
            # Represents the reason why the status is `pending` or `restricted`.
            sig { returns(String) }
            def code; end
            # Represents what the user should do, if anything, to activate the Feature.
            sig { returns(T.nilable(String)) }
            def resolution; end
            # The `platform_restrictions` that are restricting this Feature.
            sig { returns(T.nilable(String)) }
            def restriction; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          # Whether the Feature is operational.
          sig { returns(String) }
          def status; end
          # Additional details; includes at least one entry when the status is not `active`.
          sig { returns(T::Array[StatusDetail]) }
          def status_details; end
          def self.inner_class_types
            @inner_class_types = {status_details: StatusDetail}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Toggle settings for enabling/disabling an inbound ACH specific feature
        sig { returns(T.nilable(Ach)) }
        def ach; end
        def self.inner_class_types
          @inner_class_types = {ach: Ach}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class IntraStripeFlows < ::Stripe::StripeObject
        class StatusDetail < ::Stripe::StripeObject
          # Represents the reason why the status is `pending` or `restricted`.
          sig { returns(String) }
          def code; end
          # Represents what the user should do, if anything, to activate the Feature.
          sig { returns(T.nilable(String)) }
          def resolution; end
          # The `platform_restrictions` that are restricting this Feature.
          sig { returns(T.nilable(String)) }
          def restriction; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the FinancialAccount should have the Feature.
        sig { returns(T::Boolean) }
        def requested; end
        # Whether the Feature is operational.
        sig { returns(String) }
        def status; end
        # Additional details; includes at least one entry when the status is not `active`.
        sig { returns(T::Array[StatusDetail]) }
        def status_details; end
        def self.inner_class_types
          @inner_class_types = {status_details: StatusDetail}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class OutboundPayments < ::Stripe::StripeObject
        class Ach < ::Stripe::StripeObject
          class StatusDetail < ::Stripe::StripeObject
            # Represents the reason why the status is `pending` or `restricted`.
            sig { returns(String) }
            def code; end
            # Represents what the user should do, if anything, to activate the Feature.
            sig { returns(T.nilable(String)) }
            def resolution; end
            # The `platform_restrictions` that are restricting this Feature.
            sig { returns(T.nilable(String)) }
            def restriction; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          # Whether the Feature is operational.
          sig { returns(String) }
          def status; end
          # Additional details; includes at least one entry when the status is not `active`.
          sig { returns(T::Array[StatusDetail]) }
          def status_details; end
          def self.inner_class_types
            @inner_class_types = {status_details: StatusDetail}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class UsDomesticWire < ::Stripe::StripeObject
          class StatusDetail < ::Stripe::StripeObject
            # Represents the reason why the status is `pending` or `restricted`.
            sig { returns(String) }
            def code; end
            # Represents what the user should do, if anything, to activate the Feature.
            sig { returns(T.nilable(String)) }
            def resolution; end
            # The `platform_restrictions` that are restricting this Feature.
            sig { returns(T.nilable(String)) }
            def restriction; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          # Whether the Feature is operational.
          sig { returns(String) }
          def status; end
          # Additional details; includes at least one entry when the status is not `active`.
          sig { returns(T::Array[StatusDetail]) }
          def status_details; end
          def self.inner_class_types
            @inner_class_types = {status_details: StatusDetail}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Toggle settings for enabling/disabling an outbound ACH specific feature
        sig { returns(T.nilable(Ach)) }
        def ach; end
        # Toggle settings for enabling/disabling a feature
        sig { returns(T.nilable(UsDomesticWire)) }
        def us_domestic_wire; end
        def self.inner_class_types
          @inner_class_types = {ach: Ach, us_domestic_wire: UsDomesticWire}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class OutboundTransfers < ::Stripe::StripeObject
        class Ach < ::Stripe::StripeObject
          class StatusDetail < ::Stripe::StripeObject
            # Represents the reason why the status is `pending` or `restricted`.
            sig { returns(String) }
            def code; end
            # Represents what the user should do, if anything, to activate the Feature.
            sig { returns(T.nilable(String)) }
            def resolution; end
            # The `platform_restrictions` that are restricting this Feature.
            sig { returns(T.nilable(String)) }
            def restriction; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          # Whether the Feature is operational.
          sig { returns(String) }
          def status; end
          # Additional details; includes at least one entry when the status is not `active`.
          sig { returns(T::Array[StatusDetail]) }
          def status_details; end
          def self.inner_class_types
            @inner_class_types = {status_details: StatusDetail}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class UsDomesticWire < ::Stripe::StripeObject
          class StatusDetail < ::Stripe::StripeObject
            # Represents the reason why the status is `pending` or `restricted`.
            sig { returns(String) }
            def code; end
            # Represents what the user should do, if anything, to activate the Feature.
            sig { returns(T.nilable(String)) }
            def resolution; end
            # The `platform_restrictions` that are restricting this Feature.
            sig { returns(T.nilable(String)) }
            def restriction; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # Whether the FinancialAccount should have the Feature.
          sig { returns(T::Boolean) }
          def requested; end
          # Whether the Feature is operational.
          sig { returns(String) }
          def status; end
          # Additional details; includes at least one entry when the status is not `active`.
          sig { returns(T::Array[StatusDetail]) }
          def status_details; end
          def self.inner_class_types
            @inner_class_types = {status_details: StatusDetail}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Toggle settings for enabling/disabling an outbound ACH specific feature
        sig { returns(T.nilable(Ach)) }
        def ach; end
        # Toggle settings for enabling/disabling a feature
        sig { returns(T.nilable(UsDomesticWire)) }
        def us_domestic_wire; end
        def self.inner_class_types
          @inner_class_types = {ach: Ach, us_domestic_wire: UsDomesticWire}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Toggle settings for enabling/disabling a feature
      sig { returns(T.nilable(CardIssuing)) }
      def card_issuing; end
      # Toggle settings for enabling/disabling a feature
      sig { returns(T.nilable(DepositInsurance)) }
      def deposit_insurance; end
      # Settings related to Financial Addresses features on a Financial Account
      sig { returns(T.nilable(FinancialAddresses)) }
      def financial_addresses; end
      # InboundTransfers contains inbound transfers features for a FinancialAccount.
      sig { returns(T.nilable(InboundTransfers)) }
      def inbound_transfers; end
      # Toggle settings for enabling/disabling a feature
      sig { returns(T.nilable(IntraStripeFlows)) }
      def intra_stripe_flows; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Settings related to Outbound Payments features on a Financial Account
      sig { returns(T.nilable(OutboundPayments)) }
      def outbound_payments; end
      # OutboundTransfers contains outbound transfers features for a FinancialAccount.
      sig { returns(T.nilable(OutboundTransfers)) }
      def outbound_transfers; end
    end
  end
end