# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionMigrateParams < ::Stripe::RequestParams
    class BillingMode < ::Stripe::RequestParams
      class Flexible < ::Stripe::RequestParams
        # Controls how invoices and invoice items display proration amounts and discount amounts.
        sig { returns(T.nilable(String)) }
        def proration_discounts; end
        sig { params(_proration_discounts: T.nilable(String)).returns(T.nilable(String)) }
        def proration_discounts=(_proration_discounts); end
        sig { params(proration_discounts: T.nilable(String)).void }
        def initialize(proration_discounts: nil); end
      end
      # Configure behavior for flexible billing mode.
      sig { returns(T.nilable(SubscriptionMigrateParams::BillingMode::Flexible)) }
      def flexible; end
      sig {
        params(_flexible: T.nilable(SubscriptionMigrateParams::BillingMode::Flexible)).returns(T.nilable(SubscriptionMigrateParams::BillingMode::Flexible))
       }
      def flexible=(_flexible); end
      # Controls the calculation and orchestration of prorations and invoices for subscriptions.
      sig { returns(String) }
      def type; end
      sig { params(_type: String).returns(String) }
      def type=(_type); end
      sig {
        params(flexible: T.nilable(SubscriptionMigrateParams::BillingMode::Flexible), type: String).void
       }
      def initialize(flexible: nil, type: nil); end
    end
    # Controls how prorations and invoices for subscriptions are calculated and orchestrated.
    sig { returns(SubscriptionMigrateParams::BillingMode) }
    def billing_mode; end
    sig {
      params(_billing_mode: SubscriptionMigrateParams::BillingMode).returns(SubscriptionMigrateParams::BillingMode)
     }
    def billing_mode=(_billing_mode); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig {
      params(billing_mode: SubscriptionMigrateParams::BillingMode, expand: T.nilable(T::Array[String])).void
     }
    def initialize(billing_mode: nil, expand: nil); end
  end
end