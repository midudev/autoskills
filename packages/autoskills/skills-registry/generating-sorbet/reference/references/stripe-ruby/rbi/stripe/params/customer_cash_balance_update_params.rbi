# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CustomerCashBalanceUpdateParams < ::Stripe::RequestParams
    class Settings < ::Stripe::RequestParams
      # Controls how funds transferred by the customer are applied to payment intents and invoices. Valid options are `automatic`, `manual`, or `merchant_default`. For more information about these reconciliation modes, see [Reconciliation](https://docs.stripe.com/payments/customer-balance/reconciliation).
      sig { returns(T.nilable(String)) }
      def reconciliation_mode; end
      sig { params(_reconciliation_mode: T.nilable(String)).returns(T.nilable(String)) }
      def reconciliation_mode=(_reconciliation_mode); end
      sig { params(reconciliation_mode: T.nilable(String)).void }
      def initialize(reconciliation_mode: nil); end
    end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # A hash of settings for this cash balance.
    sig { returns(T.nilable(CustomerCashBalanceUpdateParams::Settings)) }
    def settings; end
    sig {
      params(_settings: T.nilable(CustomerCashBalanceUpdateParams::Settings)).returns(T.nilable(CustomerCashBalanceUpdateParams::Settings))
     }
    def settings=(_settings); end
    sig {
      params(expand: T.nilable(T::Array[String]), settings: T.nilable(CustomerCashBalanceUpdateParams::Settings)).void
     }
    def initialize(expand: nil, settings: nil); end
  end
end