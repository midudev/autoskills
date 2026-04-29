# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    # A credit grant is an API resource that documents the allocation of some billing credits to a customer.
    #
    # Related guide: [Billing credits](https://docs.stripe.com/billing/subscriptions/usage-based/billing-credits)
    class CreditGrant < APIResource
      class Amount < ::Stripe::StripeObject
        class Monetary < ::Stripe::StripeObject
          # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
          sig { returns(String) }
          def currency; end
          # A positive integer representing the amount.
          sig { returns(Integer) }
          def value; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The monetary amount.
        sig { returns(T.nilable(Monetary)) }
        def monetary; end
        # The type of this amount. We currently only support `monetary` billing credits.
        sig { returns(String) }
        def type; end
        def self.inner_class_types
          @inner_class_types = {monetary: Monetary}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ApplicabilityConfig < ::Stripe::StripeObject
        class Scope < ::Stripe::StripeObject
          class Price < ::Stripe::StripeObject
            # Unique identifier for the object.
            sig { returns(T.nilable(String)) }
            def id; end
            def self.inner_class_types
              @inner_class_types = {}
            end
            def self.field_remappings
              @field_remappings = {}
            end
          end
          # The price type that credit grants can apply to. We currently only support the `metered` price type. This refers to prices that have a [Billing Meter](https://docs.stripe.com/api/billing/meter) attached to them. Cannot be used in combination with `prices`.
          sig { returns(T.nilable(String)) }
          def price_type; end
          # The prices that credit grants can apply to. We currently only support `metered` prices. This refers to prices that have a [Billing Meter](https://docs.stripe.com/api/billing/meter) attached to them. Cannot be used in combination with `price_type`.
          sig { returns(T.nilable(T::Array[Price])) }
          def prices; end
          def self.inner_class_types
            @inner_class_types = {prices: Price}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Attribute for field scope
        sig { returns(Scope) }
        def scope; end
        def self.inner_class_types
          @inner_class_types = {scope: Scope}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Attribute for field amount
      sig { returns(Amount) }
      def amount; end
      # Attribute for field applicability_config
      sig { returns(ApplicabilityConfig) }
      def applicability_config; end
      # The category of this credit grant. This is for tracking purposes and isn't displayed to the customer.
      sig { returns(String) }
      def category; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # ID of the customer receiving the billing credits.
      sig { returns(T.any(String, ::Stripe::Customer)) }
      def customer; end
      # ID of the account representing the customer receiving the billing credits
      sig { returns(T.nilable(String)) }
      def customer_account; end
      # The time when the billing credits become effective-when they're eligible for use.
      sig { returns(T.nilable(Integer)) }
      def effective_at; end
      # The time when the billing credits expire. If not present, the billing credits don't expire.
      sig { returns(T.nilable(Integer)) }
      def expires_at; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # A descriptive name shown in dashboard.
      sig { returns(T.nilable(String)) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The priority for applying this credit grant. The highest priority is 0 and the lowest is 100.
      sig { returns(T.nilable(Integer)) }
      def priority; end
      # ID of the test clock this credit grant belongs to.
      sig { returns(T.nilable(T.any(String, ::Stripe::TestHelpers::TestClock))) }
      def test_clock; end
      # Time at which the object was last updated. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def updated; end
      # The time when this credit grant was voided. If not present, the credit grant hasn't been voided.
      sig { returns(T.nilable(Integer)) }
      def voided_at; end
      # Creates a credit grant.
      sig {
        params(params: T.any(::Stripe::Billing::CreditGrantCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def self.create(params = {}, opts = {}); end

      # Expires a credit grant.
      sig {
        params(params: T.any(::Stripe::Billing::CreditGrantExpireParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def expire(params = {}, opts = {}); end

      # Expires a credit grant.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::CreditGrantExpireParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def self.expire(id, params = {}, opts = {}); end

      # Retrieve a list of credit grants.
      sig {
        params(params: T.any(::Stripe::Billing::CreditGrantListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates a credit grant.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::CreditGrantUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def self.update(id, params = {}, opts = {}); end

      # Voids a credit grant.
      sig {
        params(params: T.any(::Stripe::Billing::CreditGrantVoidGrantParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def void_grant(params = {}, opts = {}); end

      # Voids a credit grant.
      sig {
        params(id: String, params: T.any(::Stripe::Billing::CreditGrantVoidGrantParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Billing::CreditGrant)
       }
      def self.void_grant(id, params = {}, opts = {}); end
    end
  end
end