# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # An AccountSession allows a Connect platform to grant access to a connected account in Connect embedded components.
  #
  # We recommend that you create an AccountSession each time you need to display an embedded component
  # to your user. Do not save AccountSessions to your database as they expire relatively
  # quickly, and cannot be used more than once.
  #
  # Related guide: [Connect embedded components](https://docs.stripe.com/connect/get-started-connect-embedded-components)
  class AccountSession < APIResource
    class Components < ::Stripe::StripeObject
      class AccountManagement < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether Stripe user authentication is disabled. This value can only be `true` for accounts where `controller.requirement_collection` is `application` for the account. The default value is the opposite of the `external_account_collection` value. For example, if you don't set `external_account_collection`, it defaults to `true` and `disable_stripe_user_authentication` defaults to `false`.
          sig { returns(T::Boolean) }
          def disable_stripe_user_authentication; end
          # Whether external account collection is enabled. This feature can only be `false` for accounts where you’re responsible for collecting updated information when requirements are due or change, like Custom accounts. The default value for this feature is `true`.
          sig { returns(T::Boolean) }
          def external_account_collection; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class AccountOnboarding < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether Stripe user authentication is disabled. This value can only be `true` for accounts where `controller.requirement_collection` is `application` for the account. The default value is the opposite of the `external_account_collection` value. For example, if you don't set `external_account_collection`, it defaults to `true` and `disable_stripe_user_authentication` defaults to `false`.
          sig { returns(T::Boolean) }
          def disable_stripe_user_authentication; end
          # Whether external account collection is enabled. This feature can only be `false` for accounts where you’re responsible for collecting updated information when requirements are due or change, like Custom accounts. The default value for this feature is `true`.
          sig { returns(T::Boolean) }
          def external_account_collection; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Balances < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether Stripe user authentication is disabled. This value can only be `true` for accounts where `controller.requirement_collection` is `application` for the account. The default value is the opposite of the `external_account_collection` value. For example, if you don't set `external_account_collection`, it defaults to `true` and `disable_stripe_user_authentication` defaults to `false`.
          sig { returns(T::Boolean) }
          def disable_stripe_user_authentication; end
          # Whether to allow payout schedule to be changed. Defaults to `true` when `controller.losses.payments` is set to `stripe` for the account, otherwise `false`.
          sig { returns(T::Boolean) }
          def edit_payout_schedule; end
          # Whether external account collection is enabled. This feature can only be `false` for accounts where you’re responsible for collecting updated information when requirements are due or change, like Custom accounts. The default value for this feature is `true`.
          sig { returns(T::Boolean) }
          def external_account_collection; end
          # Whether to allow creation of instant payouts. Defaults to `true` when `controller.losses.payments` is set to `stripe` for the account, otherwise `false`.
          sig { returns(T::Boolean) }
          def instant_payouts; end
          # Whether to allow creation of standard payouts. Defaults to `true` when `controller.losses.payments` is set to `stripe` for the account, otherwise `false`.
          sig { returns(T::Boolean) }
          def standard_payouts; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class DisputesList < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether to allow capturing and cancelling payment intents. This is `true` by default.
          sig { returns(T::Boolean) }
          def capture_payments; end
          # Whether connected accounts can manage destination charges that are created on behalf of them. This is `false` by default.
          sig { returns(T::Boolean) }
          def destination_on_behalf_of_charge_management; end
          # Whether responding to disputes is enabled, including submitting evidence and accepting disputes. This is `true` by default.
          sig { returns(T::Boolean) }
          def dispute_management; end
          # Whether sending refunds is enabled. This is `true` by default.
          sig { returns(T::Boolean) }
          def refund_management; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Documents < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class FinancialAccount < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether Stripe user authentication is disabled. This value can only be `true` for accounts where `controller.requirement_collection` is `application` for the account. The default value is the opposite of the `external_account_collection` value. For example, if you don't set `external_account_collection`, it defaults to `true` and `disable_stripe_user_authentication` defaults to `false`.
          sig { returns(T::Boolean) }
          def disable_stripe_user_authentication; end
          # Whether external account collection is enabled. This feature can only be `false` for accounts where you’re responsible for collecting updated information when requirements are due or change, like Custom accounts. The default value for this feature is `true`.
          sig { returns(T::Boolean) }
          def external_account_collection; end
          # Whether to allow sending money.
          sig { returns(T::Boolean) }
          def send_money; end
          # Whether to allow transferring balance.
          sig { returns(T::Boolean) }
          def transfer_balance; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class FinancialAccountTransactions < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether to allow card spend dispute management features.
          sig { returns(T::Boolean) }
          def card_spend_dispute_management; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class InstantPayoutsPromotion < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether Stripe user authentication is disabled. This value can only be `true` for accounts where `controller.requirement_collection` is `application` for the account. The default value is the opposite of the `external_account_collection` value. For example, if you don't set `external_account_collection`, it defaults to `true` and `disable_stripe_user_authentication` defaults to `false`.
          sig { returns(T::Boolean) }
          def disable_stripe_user_authentication; end
          # Whether external account collection is enabled. This feature can only be `false` for accounts where you’re responsible for collecting updated information when requirements are due or change, like Custom accounts. The default value for this feature is `true`.
          sig { returns(T::Boolean) }
          def external_account_collection; end
          # Whether to allow creation of instant payouts. Defaults to `true` when `controller.losses.payments` is set to `stripe` for the account, otherwise `false`.
          sig { returns(T::Boolean) }
          def instant_payouts; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class IssuingCard < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether to allow card management features.
          sig { returns(T::Boolean) }
          def card_management; end
          # Whether to allow card spend dispute management features.
          sig { returns(T::Boolean) }
          def card_spend_dispute_management; end
          # Whether to allow cardholder management features.
          sig { returns(T::Boolean) }
          def cardholder_management; end
          # Whether to allow spend control management features.
          sig { returns(T::Boolean) }
          def spend_control_management; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class IssuingCardsList < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether to allow card management features.
          sig { returns(T::Boolean) }
          def card_management; end
          # Whether to allow card spend dispute management features.
          sig { returns(T::Boolean) }
          def card_spend_dispute_management; end
          # Whether to allow cardholder management features.
          sig { returns(T::Boolean) }
          def cardholder_management; end
          # Whether Stripe user authentication is disabled. This value can only be `true` for accounts where `controller.requirement_collection` is `application` for the account. The default value is the opposite of the `external_account_collection` value. For example, if you don't set `external_account_collection`, it defaults to `true` and `disable_stripe_user_authentication` defaults to `false`.
          sig { returns(T::Boolean) }
          def disable_stripe_user_authentication; end
          # Whether to allow spend control management features.
          sig { returns(T::Boolean) }
          def spend_control_management; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class NotificationBanner < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether Stripe user authentication is disabled. This value can only be `true` for accounts where `controller.requirement_collection` is `application` for the account. The default value is the opposite of the `external_account_collection` value. For example, if you don't set `external_account_collection`, it defaults to `true` and `disable_stripe_user_authentication` defaults to `false`.
          sig { returns(T::Boolean) }
          def disable_stripe_user_authentication; end
          # Whether external account collection is enabled. This feature can only be `false` for accounts where you’re responsible for collecting updated information when requirements are due or change, like Custom accounts. The default value for this feature is `true`.
          sig { returns(T::Boolean) }
          def external_account_collection; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PaymentDetails < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether to allow capturing and cancelling payment intents. This is `true` by default.
          sig { returns(T::Boolean) }
          def capture_payments; end
          # Whether connected accounts can manage destination charges that are created on behalf of them. This is `false` by default.
          sig { returns(T::Boolean) }
          def destination_on_behalf_of_charge_management; end
          # Whether responding to disputes is enabled, including submitting evidence and accepting disputes. This is `true` by default.
          sig { returns(T::Boolean) }
          def dispute_management; end
          # Whether sending refunds is enabled. This is `true` by default.
          sig { returns(T::Boolean) }
          def refund_management; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PaymentDisputes < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether connected accounts can manage destination charges that are created on behalf of them. This is `false` by default.
          sig { returns(T::Boolean) }
          def destination_on_behalf_of_charge_management; end
          # Whether responding to disputes is enabled, including submitting evidence and accepting disputes. This is `true` by default.
          sig { returns(T::Boolean) }
          def dispute_management; end
          # Whether sending refunds is enabled. This is `true` by default.
          sig { returns(T::Boolean) }
          def refund_management; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Payments < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether to allow capturing and cancelling payment intents. This is `true` by default.
          sig { returns(T::Boolean) }
          def capture_payments; end
          # Whether connected accounts can manage destination charges that are created on behalf of them. This is `false` by default.
          sig { returns(T::Boolean) }
          def destination_on_behalf_of_charge_management; end
          # Whether responding to disputes is enabled, including submitting evidence and accepting disputes. This is `true` by default.
          sig { returns(T::Boolean) }
          def dispute_management; end
          # Whether sending refunds is enabled. This is `true` by default.
          sig { returns(T::Boolean) }
          def refund_management; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PayoutDetails < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Payouts < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          # Whether Stripe user authentication is disabled. This value can only be `true` for accounts where `controller.requirement_collection` is `application` for the account. The default value is the opposite of the `external_account_collection` value. For example, if you don't set `external_account_collection`, it defaults to `true` and `disable_stripe_user_authentication` defaults to `false`.
          sig { returns(T::Boolean) }
          def disable_stripe_user_authentication; end
          # Whether to allow payout schedule to be changed. Defaults to `true` when `controller.losses.payments` is set to `stripe` for the account, otherwise `false`.
          sig { returns(T::Boolean) }
          def edit_payout_schedule; end
          # Whether external account collection is enabled. This feature can only be `false` for accounts where you’re responsible for collecting updated information when requirements are due or change, like Custom accounts. The default value for this feature is `true`.
          sig { returns(T::Boolean) }
          def external_account_collection; end
          # Whether to allow creation of instant payouts. Defaults to `true` when `controller.losses.payments` is set to `stripe` for the account, otherwise `false`.
          sig { returns(T::Boolean) }
          def instant_payouts; end
          # Whether to allow creation of standard payouts. Defaults to `true` when `controller.losses.payments` is set to `stripe` for the account, otherwise `false`.
          sig { returns(T::Boolean) }
          def standard_payouts; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class PayoutsList < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class TaxRegistrations < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class TaxSettings < ::Stripe::StripeObject
        class Features < ::Stripe::StripeObject
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Whether the embedded component is enabled.
        sig { returns(T::Boolean) }
        def enabled; end
        # Attribute for field features
        sig { returns(Features) }
        def features; end
        def self.inner_class_types
          @inner_class_types = {features: Features}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field account_management
      sig { returns(AccountManagement) }
      def account_management; end
      # Attribute for field account_onboarding
      sig { returns(AccountOnboarding) }
      def account_onboarding; end
      # Attribute for field balances
      sig { returns(Balances) }
      def balances; end
      # Attribute for field disputes_list
      sig { returns(DisputesList) }
      def disputes_list; end
      # Attribute for field documents
      sig { returns(Documents) }
      def documents; end
      # Attribute for field financial_account
      sig { returns(FinancialAccount) }
      def financial_account; end
      # Attribute for field financial_account_transactions
      sig { returns(FinancialAccountTransactions) }
      def financial_account_transactions; end
      # Attribute for field instant_payouts_promotion
      sig { returns(InstantPayoutsPromotion) }
      def instant_payouts_promotion; end
      # Attribute for field issuing_card
      sig { returns(IssuingCard) }
      def issuing_card; end
      # Attribute for field issuing_cards_list
      sig { returns(IssuingCardsList) }
      def issuing_cards_list; end
      # Attribute for field notification_banner
      sig { returns(NotificationBanner) }
      def notification_banner; end
      # Attribute for field payment_details
      sig { returns(PaymentDetails) }
      def payment_details; end
      # Attribute for field payment_disputes
      sig { returns(PaymentDisputes) }
      def payment_disputes; end
      # Attribute for field payments
      sig { returns(Payments) }
      def payments; end
      # Attribute for field payout_details
      sig { returns(PayoutDetails) }
      def payout_details; end
      # Attribute for field payouts
      sig { returns(Payouts) }
      def payouts; end
      # Attribute for field payouts_list
      sig { returns(PayoutsList) }
      def payouts_list; end
      # Attribute for field tax_registrations
      sig { returns(TaxRegistrations) }
      def tax_registrations; end
      # Attribute for field tax_settings
      sig { returns(TaxSettings) }
      def tax_settings; end
      def self.inner_class_types
        @inner_class_types = {
          account_management: AccountManagement,
          account_onboarding: AccountOnboarding,
          balances: Balances,
          disputes_list: DisputesList,
          documents: Documents,
          financial_account: FinancialAccount,
          financial_account_transactions: FinancialAccountTransactions,
          instant_payouts_promotion: InstantPayoutsPromotion,
          issuing_card: IssuingCard,
          issuing_cards_list: IssuingCardsList,
          notification_banner: NotificationBanner,
          payment_details: PaymentDetails,
          payment_disputes: PaymentDisputes,
          payments: Payments,
          payout_details: PayoutDetails,
          payouts: Payouts,
          payouts_list: PayoutsList,
          tax_registrations: TaxRegistrations,
          tax_settings: TaxSettings,
        }
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The ID of the account the AccountSession was created for
    sig { returns(String) }
    def account; end
    # The client secret of this AccountSession. Used on the client to set up secure access to the given `account`.
    #
    # The client secret can be used to provide access to `account` from your frontend. It should not be stored, logged, or exposed to anyone other than the connected account. Make sure that you have TLS enabled on any page that includes the client secret.
    #
    # Refer to our docs to [setup Connect embedded components](https://docs.stripe.com/connect/get-started-connect-embedded-components) and learn about how `client_secret` should be handled.
    sig { returns(String) }
    def client_secret; end
    # Attribute for field components
    sig { returns(Components) }
    def components; end
    # The timestamp at which this AccountSession will expire.
    sig { returns(Integer) }
    def expires_at; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Creates a AccountSession object that includes a single-use token that the platform can use on their front-end to grant client-side API access.
    sig {
      params(params: T.any(::Stripe::AccountSessionCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::AccountSession)
     }
    def self.create(params = {}, opts = {}); end
  end
end