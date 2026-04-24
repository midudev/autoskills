# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class CreditGrantCreateParams < ::Stripe::RequestParams
      class Amount < ::Stripe::RequestParams
        class Monetary < ::Stripe::RequestParams
          # Three-letter [ISO code for the currency](https://stripe.com/docs/currencies) of the `value` parameter.
          sig { returns(String) }
          def currency; end
          sig { params(_currency: String).returns(String) }
          def currency=(_currency); end
          # A positive integer representing the amount of the credit grant.
          sig { returns(Integer) }
          def value; end
          sig { params(_value: Integer).returns(Integer) }
          def value=(_value); end
          sig { params(currency: String, value: Integer).void }
          def initialize(currency: nil, value: nil); end
        end
        # The monetary amount.
        sig { returns(T.nilable(Billing::CreditGrantCreateParams::Amount::Monetary)) }
        def monetary; end
        sig {
          params(_monetary: T.nilable(Billing::CreditGrantCreateParams::Amount::Monetary)).returns(T.nilable(Billing::CreditGrantCreateParams::Amount::Monetary))
         }
        def monetary=(_monetary); end
        # The type of this amount. We currently only support `monetary` billing credits.
        sig { returns(String) }
        def type; end
        sig { params(_type: String).returns(String) }
        def type=(_type); end
        sig {
          params(monetary: T.nilable(Billing::CreditGrantCreateParams::Amount::Monetary), type: String).void
         }
        def initialize(monetary: nil, type: nil); end
      end
      class ApplicabilityConfig < ::Stripe::RequestParams
        class Scope < ::Stripe::RequestParams
          class Price < ::Stripe::RequestParams
            # The price ID this credit grant should apply to.
            sig { returns(String) }
            def id; end
            sig { params(_id: String).returns(String) }
            def id=(_id); end
            sig { params(id: String).void }
            def initialize(id: nil); end
          end
          # The price type that credit grants can apply to. We currently only support the `metered` price type. Cannot be used in combination with `prices`.
          sig { returns(T.nilable(String)) }
          def price_type; end
          sig { params(_price_type: T.nilable(String)).returns(T.nilable(String)) }
          def price_type=(_price_type); end
          # A list of prices that the credit grant can apply to. We currently only support the `metered` prices. Cannot be used in combination with `price_type`.
          sig {
            returns(T.nilable(T::Array[Billing::CreditGrantCreateParams::ApplicabilityConfig::Scope::Price]))
           }
          def prices; end
          sig {
            params(_prices: T.nilable(T::Array[Billing::CreditGrantCreateParams::ApplicabilityConfig::Scope::Price])).returns(T.nilable(T::Array[Billing::CreditGrantCreateParams::ApplicabilityConfig::Scope::Price]))
           }
          def prices=(_prices); end
          sig {
            params(price_type: T.nilable(String), prices: T.nilable(T::Array[Billing::CreditGrantCreateParams::ApplicabilityConfig::Scope::Price])).void
           }
          def initialize(price_type: nil, prices: nil); end
        end
        # Specify the scope of this applicability config.
        sig { returns(Billing::CreditGrantCreateParams::ApplicabilityConfig::Scope) }
        def scope; end
        sig {
          params(_scope: Billing::CreditGrantCreateParams::ApplicabilityConfig::Scope).returns(Billing::CreditGrantCreateParams::ApplicabilityConfig::Scope)
         }
        def scope=(_scope); end
        sig { params(scope: Billing::CreditGrantCreateParams::ApplicabilityConfig::Scope).void }
        def initialize(scope: nil); end
      end
      # Amount of this credit grant.
      sig { returns(Billing::CreditGrantCreateParams::Amount) }
      def amount; end
      sig {
        params(_amount: Billing::CreditGrantCreateParams::Amount).returns(Billing::CreditGrantCreateParams::Amount)
       }
      def amount=(_amount); end
      # Configuration specifying what this credit grant applies to. We currently only support `metered` prices that have a [Billing Meter](https://docs.stripe.com/api/billing/meter) attached to them.
      sig { returns(Billing::CreditGrantCreateParams::ApplicabilityConfig) }
      def applicability_config; end
      sig {
        params(_applicability_config: Billing::CreditGrantCreateParams::ApplicabilityConfig).returns(Billing::CreditGrantCreateParams::ApplicabilityConfig)
       }
      def applicability_config=(_applicability_config); end
      # The category of this credit grant. It defaults to `paid` if not specified.
      sig { returns(T.nilable(String)) }
      def category; end
      sig { params(_category: T.nilable(String)).returns(T.nilable(String)) }
      def category=(_category); end
      # ID of the customer receiving the billing credits.
      sig { returns(T.nilable(String)) }
      def customer; end
      sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
      def customer=(_customer); end
      # ID of the account representing the customer receiving the billing credits.
      sig { returns(T.nilable(String)) }
      def customer_account; end
      sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
      def customer_account=(_customer_account); end
      # The time when the billing credits become effective-when they're eligible for use. It defaults to the current timestamp if not specified.
      sig { returns(T.nilable(Integer)) }
      def effective_at; end
      sig { params(_effective_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def effective_at=(_effective_at); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The time when the billing credits expire. If not specified, the billing credits don't expire.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      sig { params(_expires_at: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def expires_at=(_expires_at); end
      # Set of key-value pairs that you can attach to an object. You can use this to store additional information about the object (for example, cost basis) in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # A descriptive name shown in the Dashboard.
      sig { returns(T.nilable(String)) }
      def name; end
      sig { params(_name: T.nilable(String)).returns(T.nilable(String)) }
      def name=(_name); end
      # The desired priority for applying this credit grant. If not specified, it will be set to the default value of 50. The highest priority is 0 and the lowest is 100.
      sig { returns(T.nilable(Integer)) }
      def priority; end
      sig { params(_priority: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def priority=(_priority); end
      sig {
        params(amount: Billing::CreditGrantCreateParams::Amount, applicability_config: Billing::CreditGrantCreateParams::ApplicabilityConfig, category: T.nilable(String), customer: T.nilable(String), customer_account: T.nilable(String), effective_at: T.nilable(Integer), expand: T.nilable(T::Array[String]), expires_at: T.nilable(Integer), metadata: T.nilable(T::Hash[String, String]), name: T.nilable(String), priority: T.nilable(Integer)).void
       }
      def initialize(
        amount: nil,
        applicability_config: nil,
        category: nil,
        customer: nil,
        customer_account: nil,
        effective_at: nil,
        expand: nil,
        expires_at: nil,
        metadata: nil,
        name: nil,
        priority: nil
      ); end
    end
  end
end