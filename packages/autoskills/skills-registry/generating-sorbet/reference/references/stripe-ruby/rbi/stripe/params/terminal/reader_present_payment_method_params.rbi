# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ReaderPresentPaymentMethodParams < ::Stripe::RequestParams
      class Card < ::Stripe::RequestParams
        # Card security code.
        sig { returns(T.nilable(String)) }
        def cvc; end
        sig { params(_cvc: T.nilable(String)).returns(T.nilable(String)) }
        def cvc=(_cvc); end
        # Two-digit number representing the card's expiration month.
        sig { returns(Integer) }
        def exp_month; end
        sig { params(_exp_month: Integer).returns(Integer) }
        def exp_month=(_exp_month); end
        # Two- or four-digit number representing the card's expiration year.
        sig { returns(Integer) }
        def exp_year; end
        sig { params(_exp_year: Integer).returns(Integer) }
        def exp_year=(_exp_year); end
        # The card number, as a string without any separators.
        sig { returns(String) }
        def number; end
        sig { params(_number: String).returns(String) }
        def number=(_number); end
        sig {
          params(cvc: T.nilable(String), exp_month: Integer, exp_year: Integer, number: String).void
         }
        def initialize(cvc: nil, exp_month: nil, exp_year: nil, number: nil); end
      end
      class CardPresent < ::Stripe::RequestParams
        # The card number, as a string without any separators.
        sig { returns(T.nilable(String)) }
        def number; end
        sig { params(_number: T.nilable(String)).returns(T.nilable(String)) }
        def number=(_number); end
        sig { params(number: T.nilable(String)).void }
        def initialize(number: nil); end
      end
      class InteracPresent < ::Stripe::RequestParams
        # The Interac card number.
        sig { returns(T.nilable(String)) }
        def number; end
        sig { params(_number: T.nilable(String)).returns(T.nilable(String)) }
        def number=(_number); end
        sig { params(number: T.nilable(String)).void }
        def initialize(number: nil); end
      end
      # Simulated on-reader tip amount.
      sig { returns(T.nilable(Integer)) }
      def amount_tip; end
      sig { params(_amount_tip: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def amount_tip=(_amount_tip); end
      # Simulated data for the card payment method.
      sig { returns(T.nilable(Terminal::ReaderPresentPaymentMethodParams::Card)) }
      def card; end
      sig {
        params(_card: T.nilable(Terminal::ReaderPresentPaymentMethodParams::Card)).returns(T.nilable(Terminal::ReaderPresentPaymentMethodParams::Card))
       }
      def card=(_card); end
      # Simulated data for the card_present payment method.
      sig { returns(T.nilable(Terminal::ReaderPresentPaymentMethodParams::CardPresent)) }
      def card_present; end
      sig {
        params(_card_present: T.nilable(Terminal::ReaderPresentPaymentMethodParams::CardPresent)).returns(T.nilable(Terminal::ReaderPresentPaymentMethodParams::CardPresent))
       }
      def card_present=(_card_present); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Simulated data for the interac_present payment method.
      sig { returns(T.nilable(Terminal::ReaderPresentPaymentMethodParams::InteracPresent)) }
      def interac_present; end
      sig {
        params(_interac_present: T.nilable(Terminal::ReaderPresentPaymentMethodParams::InteracPresent)).returns(T.nilable(Terminal::ReaderPresentPaymentMethodParams::InteracPresent))
       }
      def interac_present=(_interac_present); end
      # Simulated payment type.
      sig { returns(T.nilable(String)) }
      def type; end
      sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
      def type=(_type); end
      sig {
        params(amount_tip: T.nilable(Integer), card: T.nilable(Terminal::ReaderPresentPaymentMethodParams::Card), card_present: T.nilable(Terminal::ReaderPresentPaymentMethodParams::CardPresent), expand: T.nilable(T::Array[String]), interac_present: T.nilable(Terminal::ReaderPresentPaymentMethodParams::InteracPresent), type: T.nilable(String)).void
       }
      def initialize(
        amount_tip: nil,
        card: nil,
        card_present: nil,
        expand: nil,
        interac_present: nil,
        type: nil
      ); end
    end
  end
end