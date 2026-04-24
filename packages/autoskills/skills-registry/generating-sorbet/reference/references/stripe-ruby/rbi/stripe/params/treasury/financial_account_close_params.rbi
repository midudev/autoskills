# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Treasury
    class FinancialAccountCloseParams < ::Stripe::RequestParams
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
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A different bank account where funds can be deposited/debited in order to get the closing FA's balance to $0
      sig { returns(T.nilable(Treasury::FinancialAccountCloseParams::ForwardingSettings)) }
      def forwarding_settings; end
      sig {
        params(_forwarding_settings: T.nilable(Treasury::FinancialAccountCloseParams::ForwardingSettings)).returns(T.nilable(Treasury::FinancialAccountCloseParams::ForwardingSettings))
       }
      def forwarding_settings=(_forwarding_settings); end
      sig {
        params(expand: T.nilable(T::Array[String]), forwarding_settings: T.nilable(Treasury::FinancialAccountCloseParams::ForwardingSettings)).void
       }
      def initialize(expand: nil, forwarding_settings: nil); end
    end
  end
end