# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Climate
    # Orders represent your intent to purchase a particular Climate product. When you create an order, the
    # payment is deducted from your merchant balance.
    class Order < APIResource
      class Beneficiary < ::Stripe::StripeObject
        # Publicly displayable name for the end beneficiary of carbon removal.
        sig { returns(String) }
        def public_name; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class DeliveryDetail < ::Stripe::StripeObject
        class Location < ::Stripe::StripeObject
          # The city where the supplier is located.
          sig { returns(T.nilable(String)) }
          def city; end
          # Two-letter ISO code representing the country where the supplier is located.
          sig { returns(String) }
          def country; end
          # The geographic latitude where the supplier is located.
          sig { returns(T.nilable(Float)) }
          def latitude; end
          # The geographic longitude where the supplier is located.
          sig { returns(T.nilable(Float)) }
          def longitude; end
          # The state/county/province/region where the supplier is located.
          sig { returns(T.nilable(String)) }
          def region; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # Time at which the delivery occurred. Measured in seconds since the Unix epoch.
        sig { returns(Integer) }
        def delivered_at; end
        # Specific location of this delivery.
        sig { returns(T.nilable(Location)) }
        def location; end
        # Quantity of carbon removal supplied by this delivery.
        sig { returns(String) }
        def metric_tons; end
        # Once retired, a URL to the registry entry for the tons from this delivery.
        sig { returns(T.nilable(String)) }
        def registry_url; end
        # A supplier of carbon removal.
        sig { returns(::Stripe::Climate::Supplier) }
        def supplier; end
        def self.inner_class_types
          @inner_class_types = {location: Location}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Total amount of [Frontier](https://frontierclimate.com/)'s service fees in the currency's smallest unit.
      sig { returns(Integer) }
      def amount_fees; end
      # Total amount of the carbon removal in the currency's smallest unit.
      sig { returns(Integer) }
      def amount_subtotal; end
      # Total amount of the order including fees in the currency's smallest unit.
      sig { returns(Integer) }
      def amount_total; end
      # Attribute for field beneficiary
      sig { returns(T.nilable(Beneficiary)) }
      def beneficiary; end
      # Time at which the order was canceled. Measured in seconds since the Unix epoch.
      sig { returns(T.nilable(Integer)) }
      def canceled_at; end
      # Reason for the cancellation of this order.
      sig { returns(T.nilable(String)) }
      def cancellation_reason; end
      # For delivered orders, a URL to a delivery certificate for the order.
      sig { returns(T.nilable(String)) }
      def certificate; end
      # Time at which the order was confirmed. Measured in seconds since the Unix epoch.
      sig { returns(T.nilable(Integer)) }
      def confirmed_at; end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase, representing the currency for this order.
      sig { returns(String) }
      def currency; end
      # Time at which the order's expected_delivery_year was delayed. Measured in seconds since the Unix epoch.
      sig { returns(T.nilable(Integer)) }
      def delayed_at; end
      # Time at which the order was delivered. Measured in seconds since the Unix epoch.
      sig { returns(T.nilable(Integer)) }
      def delivered_at; end
      # Details about the delivery of carbon removal for this order.
      sig { returns(T::Array[DeliveryDetail]) }
      def delivery_details; end
      # The year this order is expected to be delivered.
      sig { returns(Integer) }
      def expected_delivery_year; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T::Hash[String, String]) }
      def metadata; end
      # Quantity of carbon removal that is included in this order.
      sig { returns(String) }
      def metric_tons; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # Unique ID for the Climate `Product` this order is purchasing.
      sig { returns(T.any(String, ::Stripe::Climate::Product)) }
      def product; end
      # Time at which the order's product was substituted for a different product. Measured in seconds since the Unix epoch.
      sig { returns(T.nilable(Integer)) }
      def product_substituted_at; end
      # The current status of this order.
      sig { returns(String) }
      def status; end
      # Cancels a Climate order. You can cancel an order within 24 hours of creation. Stripe refunds the
      # reservation amount_subtotal, but not the amount_fees for user-triggered cancellations. Frontier
      # might cancel reservations if suppliers fail to deliver. If Frontier cancels the reservation, Stripe
      # provides 90 days advance notice and refunds the amount_total.
      sig {
        params(params: T.any(::Stripe::Climate::OrderCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Order)
       }
      def cancel(params = {}, opts = {}); end

      # Cancels a Climate order. You can cancel an order within 24 hours of creation. Stripe refunds the
      # reservation amount_subtotal, but not the amount_fees for user-triggered cancellations. Frontier
      # might cancel reservations if suppliers fail to deliver. If Frontier cancels the reservation, Stripe
      # provides 90 days advance notice and refunds the amount_total.
      sig {
        params(order: String, params: T.any(::Stripe::Climate::OrderCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Order)
       }
      def self.cancel(order, params = {}, opts = {}); end

      # Creates a Climate order object for a given Climate product. The order will be processed immediately
      # after creation and payment will be deducted your Stripe balance.
      sig {
        params(params: T.any(::Stripe::Climate::OrderCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Order)
       }
      def self.create(params = {}, opts = {}); end

      # Lists all Climate order objects. The orders are returned sorted by creation date, with the
      # most recently created orders appearing first.
      sig {
        params(params: T.any(::Stripe::Climate::OrderListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end

      # Updates the specified order by setting the values of the parameters passed.
      sig {
        params(order: String, params: T.any(::Stripe::Climate::OrderUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Order)
       }
      def self.update(order, params = {}, opts = {}); end
    end
  end
end