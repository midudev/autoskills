# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module FinancialConnections
    # A Financial Connections Account represents an account that exists outside of Stripe, to which you have been granted some degree of access.
    class Account < APIResource
      class AccountHolder < ::Stripe::StripeObject
        # The ID of the Stripe account that this account belongs to. Only available when `account_holder.type` is `account`.
        sig { returns(T.nilable(T.any(String, ::Stripe::Account))) }
        def account; end
        # The ID for an Account representing a customer that this account belongs to. Only available when `account_holder.type` is `customer`.
        sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
        def customer; end
        # Attribute for field customer_account
        sig { returns(T.nilable(String)) }
        def customer_account; end
        # Type of account holder that this account belongs to.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AccountNumber < ::Stripe::StripeObject
        # When the account number is expected to expire, if applicable.
        sig { returns(T.nilable(Integer)) }
        def expected_expiry_date; end
        # The type of account number associated with the account.
        sig { returns(String) }
        def identifier_type; end
        # Whether the account number is currently active and usable for transactions.
        sig { returns(String) }
        def status; end
        # The payment networks that the account number can be used for.
        sig { returns(T::Array[String]) }
        def supported_networks; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Balance < ::Stripe::StripeObject
        class Cash < ::Stripe::StripeObject
          # The funds available to the account holder. Typically this is the current balance after subtracting any outbound pending transactions and adding any inbound pending transactions.
          #
          # Each key is a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase.
          #
          # Each value is a integer amount. A positive amount indicates money owed to the account holder. A negative amount indicates money owed by the account holder.
          sig { returns(T.nilable(T::Hash[String, Integer])) }
          def available; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        class Credit < ::Stripe::StripeObject
          # The credit that has been used by the account holder.
          #
          # Each key is a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase.
          #
          # Each value is a integer amount. A positive amount indicates money owed to the account holder. A negative amount indicates money owed by the account holder.
          sig { returns(T.nilable(T::Hash[String, Integer])) }
          def used; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The time that the external institution calculated this balance. Measured in seconds since the Unix epoch.
        sig { returns(Integer) }
        def as_of; end
        # Attribute for field cash
        sig { returns(T.nilable(Cash)) }
        def cash; end
        # Attribute for field credit
        sig { returns(T.nilable(Credit)) }
        def credit; end
        # The balances owed to (or by) the account holder, before subtracting any outbound pending transactions or adding any inbound pending transactions.
        #
        # Each key is a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase.
        #
        # Each value is a integer amount. A positive amount indicates money owed to the account holder. A negative amount indicates money owed by the account holder.
        sig { returns(T::Hash[String, Integer]) }
        def current; end
        # The `type` of the balance. An additional hash is included on the balance with a name matching this value.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {cash: Cash, credit: Credit}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class BalanceRefresh < ::Stripe::StripeObject
        # The time at which the last refresh attempt was initiated. Measured in seconds since the Unix epoch.
        sig { returns(Integer) }
        def last_attempted_at; end
        # Time at which the next balance refresh can be initiated. This value will be `null` when `status` is `pending`. Measured in seconds since the Unix epoch.
        sig { returns(T.nilable(Integer)) }
        def next_refresh_available_at; end
        # The status of the last refresh attempt.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class OwnershipRefresh < ::Stripe::StripeObject
        # The time at which the last refresh attempt was initiated. Measured in seconds since the Unix epoch.
        sig { returns(Integer) }
        def last_attempted_at; end
        # Time at which the next ownership refresh can be initiated. This value will be `null` when `status` is `pending`. Measured in seconds since the Unix epoch.
        sig { returns(T.nilable(Integer)) }
        def next_refresh_available_at; end
        # The status of the last refresh attempt.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class TransactionRefresh < ::Stripe::StripeObject
        # Unique identifier for the object.
        sig { returns(String) }
        def id; end
        # The time at which the last refresh attempt was initiated. Measured in seconds since the Unix epoch.
        sig { returns(Integer) }
        def last_attempted_at; end
        # Time at which the next transaction refresh can be initiated. This value will be `null` when `status` is `pending`. Measured in seconds since the Unix epoch.
        sig { returns(T.nilable(Integer)) }
        def next_refresh_available_at; end
        # The status of the last refresh attempt.
        sig { returns(String) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The account holder that this account belongs to.
      sig { returns(T.nilable(AccountHolder)) }
      def account_holder; end
      # Details about the account numbers.
      sig { returns(T.nilable(T::Array[AccountNumber])) }
      def account_numbers; end
      # The most recent information about the account's balance.
      sig { returns(T.nilable(Balance)) }
      def balance; end
      # The state of the most recent attempt to refresh the account balance.
      sig { returns(T.nilable(BalanceRefresh)) }
      def balance_refresh; end
      # The type of the account. Account category is further divided in `subcategory`.
      sig { returns(String) }
      def category; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # A human-readable name that has been assigned to this account, either by the account holder or by the institution.
      sig { returns(T.nilable(String)) }
      def display_name; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # The name of the institution that holds this account.
      sig { returns(String) }
      def institution_name; end
      # The last 4 digits of the account number. If present, this will be 4 numeric characters.
      sig { returns(T.nilable(String)) }
      def last4; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The most recent information about the account's owners.
      sig { returns(T.nilable(T.any(String, ::Stripe::FinancialConnections::AccountOwnership))) }
      def ownership; end
      # The state of the most recent attempt to refresh the account owners.
      sig { returns(T.nilable(OwnershipRefresh)) }
      def ownership_refresh; end
      # The list of permissions granted by this account.
      sig { returns(T.nilable(T::Array[String])) }
      def permissions; end
      # The status of the link to the account.
      sig { returns(String) }
      def status; end
      # If `category` is `cash`, one of:
      #
      #  - `checking`
      #  - `savings`
      #  - `other`
      #
      # If `category` is `credit`, one of:
      #
      #  - `mortgage`
      #  - `line_of_credit`
      #  - `credit_card`
      #  - `other`
      #
      # If `category` is `investment` or `other`, this will be `other`.
      sig { returns(String) }
      def subcategory; end
      # The list of data refresh subscriptions requested on this account.
      sig { returns(T.nilable(T::Array[String])) }
      def subscriptions; end
      # The [PaymentMethod type](https://docs.stripe.com/api/payment_methods/object#payment_method_object-type)(s) that can be created from this account.
      sig { returns(T::Array[String]) }
      def supported_payment_method_types; end
      # The state of the most recent attempt to refresh the account transactions.
      sig { returns(T.nilable(TransactionRefresh)) }
      def transaction_refresh; end
      # Disables your access to a Financial Connections Account. You will no longer be able to access data associated with the account (e.g. balances, transactions).
      sig {
        params(params: T.any(::Stripe::FinancialConnections::AccountDisconnectParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def disconnect(params = {}, opts = {}); end

      # Disables your access to a Financial Connections Account. You will no longer be able to access data associated with the account (e.g. balances, transactions).
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountDisconnectParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def self.disconnect(account, params = {}, opts = {}); end

      # Returns a list of Financial Connections Account objects.
      sig {
        params(params: T.any(::Stripe::FinancialConnections::AccountListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Lists all owners for a given Account
      sig {
        params(params: T.any(::Stripe::FinancialConnections::AccountListOwnersParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list_owners(params = {}, opts = {}); end

      # Lists all owners for a given Account
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountListOwnersParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list_owners(account, params = {}, opts = {}); end

      # Refreshes the data associated with a Financial Connections Account.
      sig {
        params(params: T.any(::Stripe::FinancialConnections::AccountRefreshAccountParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def refresh_account(params = {}, opts = {}); end

      # Refreshes the data associated with a Financial Connections Account.
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountRefreshAccountParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def self.refresh_account(account, params = {}, opts = {}); end

      # Subscribes to periodic refreshes of data associated with a Financial Connections Account. When the account status is active, data is typically refreshed once a day.
      sig {
        params(params: T.any(::Stripe::FinancialConnections::AccountSubscribeParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def subscribe(params = {}, opts = {}); end

      # Subscribes to periodic refreshes of data associated with a Financial Connections Account. When the account status is active, data is typically refreshed once a day.
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountSubscribeParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def self.subscribe(account, params = {}, opts = {}); end

      # Unsubscribes from periodic refreshes of data associated with a Financial Connections Account.
      sig {
        params(params: T.any(::Stripe::FinancialConnections::AccountUnsubscribeParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def unsubscribe(params = {}, opts = {}); end

      # Unsubscribes from periodic refreshes of data associated with a Financial Connections Account.
      sig {
        params(account: String, params: T.any(::Stripe::FinancialConnections::AccountUnsubscribeParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::FinancialConnections::Account)
       }
      def self.unsubscribe(account, params = {}, opts = {}); end
    end
  end
end