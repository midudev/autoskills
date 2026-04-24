# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class BalanceSettingsUpdateParams < ::Stripe::RequestParams
    class Payments < ::Stripe::RequestParams
      class Payouts < ::Stripe::RequestParams
        class Schedule < ::Stripe::RequestParams
          # How frequently available funds are paid out. One of: `daily`, `manual`, `weekly`, or `monthly`. Default is `daily`.
          sig { returns(T.nilable(String)) }
          def interval; end
          sig { params(_interval: T.nilable(String)).returns(T.nilable(String)) }
          def interval=(_interval); end
          # The days of the month when available funds are paid out, specified as an array of numbers between 1--31. Payouts nominally scheduled between the 29th and 31st of the month are instead sent on the last day of a shorter month. Required and applicable only if `interval` is `monthly`.
          sig { returns(T.nilable(T::Array[Integer])) }
          def monthly_payout_days; end
          sig {
            params(_monthly_payout_days: T.nilable(T::Array[Integer])).returns(T.nilable(T::Array[Integer]))
           }
          def monthly_payout_days=(_monthly_payout_days); end
          # The days of the week when available funds are paid out, specified as an array, e.g., [`monday`, `tuesday`]. Required and applicable only if `interval` is `weekly`.
          sig { returns(T.nilable(T::Array[String])) }
          def weekly_payout_days; end
          sig {
            params(_weekly_payout_days: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
           }
          def weekly_payout_days=(_weekly_payout_days); end
          sig {
            params(interval: T.nilable(String), monthly_payout_days: T.nilable(T::Array[Integer]), weekly_payout_days: T.nilable(T::Array[String])).void
           }
          def initialize(interval: nil, monthly_payout_days: nil, weekly_payout_days: nil); end
        end
        # The minimum balance amount to retain per currency after automatic payouts. Only funds that exceed these amounts are paid out. Learn more about the [minimum balances for automatic payouts](/payouts/minimum-balances-for-automatic-payouts).
        sig { returns(T.nilable(T.any(String, T::Hash[String, T.any(String, Integer)]))) }
        def minimum_balance_by_currency; end
        sig {
          params(_minimum_balance_by_currency: T.nilable(T.any(String, T::Hash[String, T.any(String, Integer)]))).returns(T.nilable(T.any(String, T::Hash[String, T.any(String, Integer)])))
         }
        def minimum_balance_by_currency=(_minimum_balance_by_currency); end
        # Details on when funds from charges are available, and when they are paid out to an external account. For details, see our [Setting Bank and Debit Card Payouts](/connect/bank-transfers#payout-information) documentation.
        sig { returns(T.nilable(BalanceSettingsUpdateParams::Payments::Payouts::Schedule)) }
        def schedule; end
        sig {
          params(_schedule: T.nilable(BalanceSettingsUpdateParams::Payments::Payouts::Schedule)).returns(T.nilable(BalanceSettingsUpdateParams::Payments::Payouts::Schedule))
         }
        def schedule=(_schedule); end
        # The text that appears on the bank account statement for payouts. If not set, this defaults to the platform's bank descriptor as set in the Dashboard.
        sig { returns(T.nilable(String)) }
        def statement_descriptor; end
        sig { params(_statement_descriptor: T.nilable(String)).returns(T.nilable(String)) }
        def statement_descriptor=(_statement_descriptor); end
        sig {
          params(minimum_balance_by_currency: T.nilable(T.any(String, T::Hash[String, T.any(String, Integer)])), schedule: T.nilable(BalanceSettingsUpdateParams::Payments::Payouts::Schedule), statement_descriptor: T.nilable(String)).void
         }
        def initialize(
          minimum_balance_by_currency: nil,
          schedule: nil,
          statement_descriptor: nil
        ); end
      end
      class SettlementTiming < ::Stripe::RequestParams
        # Change `delay_days` for this account, which determines the number of days charge funds are held before becoming available. The maximum value is 31. Passing an empty string to `delay_days_override` will return `delay_days` to the default, which is the lowest available value for the account. [Learn more about controlling delay days](/connect/manage-payout-schedule).
        sig { returns(T.nilable(T.any(String, Integer))) }
        def delay_days_override; end
        sig {
          params(_delay_days_override: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
         }
        def delay_days_override=(_delay_days_override); end
        sig { params(delay_days_override: T.nilable(T.any(String, Integer))).void }
        def initialize(delay_days_override: nil); end
      end
      # A Boolean indicating whether Stripe should try to reclaim negative balances from an attached bank account. For details, see [Understanding Connect Account Balances](/connect/account-balances).
      sig { returns(T.nilable(T::Boolean)) }
      def debit_negative_balances; end
      sig { params(_debit_negative_balances: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def debit_negative_balances=(_debit_negative_balances); end
      # Settings specific to the account's payouts.
      sig { returns(T.nilable(BalanceSettingsUpdateParams::Payments::Payouts)) }
      def payouts; end
      sig {
        params(_payouts: T.nilable(BalanceSettingsUpdateParams::Payments::Payouts)).returns(T.nilable(BalanceSettingsUpdateParams::Payments::Payouts))
       }
      def payouts=(_payouts); end
      # Settings related to the account's balance settlement timing.
      sig { returns(T.nilable(BalanceSettingsUpdateParams::Payments::SettlementTiming)) }
      def settlement_timing; end
      sig {
        params(_settlement_timing: T.nilable(BalanceSettingsUpdateParams::Payments::SettlementTiming)).returns(T.nilable(BalanceSettingsUpdateParams::Payments::SettlementTiming))
       }
      def settlement_timing=(_settlement_timing); end
      sig {
        params(debit_negative_balances: T.nilable(T::Boolean), payouts: T.nilable(BalanceSettingsUpdateParams::Payments::Payouts), settlement_timing: T.nilable(BalanceSettingsUpdateParams::Payments::SettlementTiming)).void
       }
      def initialize(debit_negative_balances: nil, payouts: nil, settlement_timing: nil); end
    end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Settings that apply to the [Payments Balance](https://docs.stripe.com/api/balance).
    sig { returns(T.nilable(BalanceSettingsUpdateParams::Payments)) }
    def payments; end
    sig {
      params(_payments: T.nilable(BalanceSettingsUpdateParams::Payments)).returns(T.nilable(BalanceSettingsUpdateParams::Payments))
     }
    def payments=(_payments); end
    sig {
      params(expand: T.nilable(T::Array[String]), payments: T.nilable(BalanceSettingsUpdateParams::Payments)).void
     }
    def initialize(expand: nil, payments: nil); end
  end
end