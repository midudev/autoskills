# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Climate
    # A Climate product represents a type of carbon removal unit available for reservation.
    # You can retrieve it to see the current price and availability.
    class Product < APIResource
      class CurrentPricesPerMetricTon < ::Stripe::StripeObject
        # Fees for one metric ton of carbon removal in the currency's smallest unit.
        sig { returns(Integer) }
        def amount_fees; end
        # Subtotal for one metric ton of carbon removal (excluding fees) in the currency's smallest unit.
        sig { returns(Integer) }
        def amount_subtotal; end
        # Total for one metric ton of carbon removal (including fees) in the currency's smallest unit.
        sig { returns(Integer) }
        def amount_total; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Current prices for a metric ton of carbon removal in a currency's smallest unit.
      sig { returns(T::Hash[String, CurrentPricesPerMetricTon]) }
      def current_prices_per_metric_ton; end
      # The year in which the carbon removal is expected to be delivered.
      sig { returns(T.nilable(Integer)) }
      def delivery_year; end
      # Unique identifier for the object. For convenience, Climate product IDs are human-readable strings
      # that start with `climsku_`. See [carbon removal inventory](https://stripe.com/docs/climate/orders/carbon-removal-inventory)
      # for a list of available carbon removal products.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # The quantity of metric tons available for reservation.
      sig { returns(String) }
      def metric_tons_available; end
      # The Climate product's name.
      sig { returns(String) }
      def name; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The carbon removal suppliers that fulfill orders for this Climate product.
      sig { returns(T::Array[::Stripe::Climate::Supplier]) }
      def suppliers; end
      # Lists all available Climate product objects.
      sig {
        params(params: T.any(::Stripe::Climate::ProductListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end