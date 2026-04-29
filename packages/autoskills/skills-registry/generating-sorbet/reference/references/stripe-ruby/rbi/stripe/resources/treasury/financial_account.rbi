# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    # Stripe Treasury provides users with a container for money called a FinancialAccount that is separate from their Payments balance.
    # FinancialAccounts serve as the source and destination of Treasury's money movement APIs.
    class FinancialAccount < APIResource
      class Balance < ::Stripe::StripeObject
        # Funds the user can spend right now.
        sig { returns(T::Hash[String, Integer]) }
        def cash; end
        # Funds not spendable yet, but will become available at a later time.
        sig { returns(T::Hash[String, Integer]) }
        def inbound_pending; end
        # Funds in the account, but not spendable because they are being held for pending outbound flows.
        sig { returns(T::Hash[String, Integer]) }
        def outbound_pending; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class FinancialAddress < ::Stripe::StripeObject
        class Aba < ::Stripe::StripeObject
          # The name of the person or business that owns the bank account.
          sig { returns(String) }
          def account_holder_name; end
          # The account number.
          sig { returns(T.nilable(String)) }
          def account_number; end
          # The last four characters of the account number.
          sig { returns(String) }
          def account_number_last4; end
          # Name of the bank.
          sig { returns(String) }
          def bank_name; end
          # Routing number for the account.
          sig { returns(String) }
          def routing_number; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # ABA Records contain U.S. bank account details per the ABA format.
        sig { returns(T.nilable(Aba)) }
        def aba; end
        # The list of networks that the address supports
        sig { returns(T.nilable(T::Array[String])) }
        def supported_networks; end
        # The type of financial address
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {aba: Aba}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PlatformRestrictions < ::Stripe::StripeObject
        # Restricts all inbound money movement.
        sig { returns(T.nilable(String)) }
        def inbound_flows; end
        # Restricts all outbound money movement.
        sig { returns(T.nilable(String)) }
        def outbound_flows; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class StatusDetails < ::Stripe::StripeObject
        class Closed < ::Stripe::StripeObject
          # The array that contains reasons for a FinancialAccount closure.
          sig { returns(T::Array[String]) }
          def reasons; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Details related to the closure of this FinancialAccount
        sig { returns(T.nilable(Closed)) }
        def closed; end
        def self.inner_class_types
          @inner_class_types = {closed: Closed}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The array of paths to active Features in the Features hash.
      sig { returns(T.nilable(T::Array[String])) }
      def active_features; end
      # Balance information for the FinancialAccount
      sig { returns(Balance) }
      def balance; end
      # Two-letter country code ([ISO 3166-1 alpha-2](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2)).
      sig { returns(String) }
      def country; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Encodes whether a FinancialAccount has access to a particular Feature, with a `status` enum and associated `status_details`.
      # Stripe or the platform can control Features via the requested field.
      sig { returns(T.nilable(::Stripe::Treasury::FinancialAccountFeatures)) }
      def features; end
      # The set of credentials that resolve to a FinancialAccount.
      sig { returns(T::Array[FinancialAddress]) }
      def financial_addresses; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Attribute for field is_default
      sig { returns(T.nilable(T::Boolean)) }
      def is_default; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      # The nickname for the FinancialAccount.
      sig { returns(T.nilable(String)) }
      def nickname; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The array of paths to pending Features in the Features hash.
      sig { returns(T.nilable(T::Array[String])) }
      def pending_features; end
      # The set of functionalities that the platform can restrict on the FinancialAccount.
      sig { returns(T.nilable(PlatformRestrictions)) }
      def platform_restrictions; end
      # The array of paths to restricted Features in the Features hash.
      sig { returns(T.nilable(T::Array[String])) }
      def restricted_features; end
      # Status of this FinancialAccount.
      sig { returns(String) }
      def status; end
      # Attribute for field status_details
      sig { returns(StatusDetails) }
      def status_details; end
      # The currencies the FinancialAccount can hold a balance in. Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase.
      sig { returns(T::Array[String]) }
      def supported_currencies; end
      # Closes a FinancialAccount. A FinancialAccount can only be closed if it has a zero balance, has no pending InboundTransfers, and has canceled all attached Issuing cards.
      sig {
        params(params: T.any(::Stripe::Treasury::FinancialAccountCloseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccount)
       }
      def close(params = {}, opts = {}); end

      # Closes a FinancialAccount. A FinancialAccount can only be closed if it has a zero balance, has no pending InboundTransfers, and has canceled all attached Issuing cards.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountCloseParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccount)
       }
      def self.close(financial_account, params = {}, opts = {}); end

      # Creates a new FinancialAccount. Each connected account can have up to three FinancialAccounts by default.
      sig {
        params(params: T.any(::Stripe::Treasury::FinancialAccountCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccount)
       }
      def self.create(params = {}, opts = {}); end

      # Returns a list of FinancialAccounts.
      sig {
        params(params: T.any(::Stripe::Treasury::FinancialAccountListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Retrieves Features information associated with the FinancialAccount.
      sig {
        params(params: T.any(::Stripe::Treasury::FinancialAccountRetrieveFeaturesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccountFeatures)
       }
      def retrieve_features(params = {}, opts = {}); end

      # Retrieves Features information associated with the FinancialAccount.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountRetrieveFeaturesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccountFeatures)
       }
      def self.retrieve_features(financial_account, params = {}, opts = {}); end

      # Updates the details of a FinancialAccount.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccount)
       }
      def self.update(financial_account, params = {}, opts = {}); end

      # Updates the Features associated with a FinancialAccount.
      sig {
        params(params: T.any(::Stripe::Treasury::FinancialAccountUpdateFeaturesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccountFeatures)
       }
      def update_features(params = {}, opts = {}); end

      # Updates the Features associated with a FinancialAccount.
      sig {
        params(financial_account: String, params: T.any(::Stripe::Treasury::FinancialAccountUpdateFeaturesParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Treasury::FinancialAccountFeatures)
       }
      def self.update_features(financial_account, params = {}, opts = {}); end
    end
  end
end