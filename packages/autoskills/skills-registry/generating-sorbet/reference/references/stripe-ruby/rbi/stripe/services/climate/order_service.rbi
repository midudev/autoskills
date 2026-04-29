# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Climate
    class OrderService < StripeService
      # Cancels a Climate order. You can cancel an order within 24 hours of creation. Stripe refunds the
      # reservation amount_subtotal, but not the amount_fees for user-triggered cancellations. Frontier
      # might cancel reservations if suppliers fail to deliver. If Frontier cancels the reservation, Stripe
      # provides 90 days advance notice and refunds the amount_total.
      sig {
        params(order: String, params: T.any(::Stripe::Climate::OrderCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Order)
       }
      def cancel(order, params = {}, opts = {}); end

      # Creates a Climate order object for a given Climate product. The order will be processed immediately
      # after creation and payment will be deducted your Stripe balance.
      sig {
        params(params: T.any(::Stripe::Climate::OrderCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Order)
       }
      def create(params = {}, opts = {}); end

      # Lists all Climate order objects. The orders are returned sorted by creation date, with the
      # most recently created orders appearing first.
      sig {
        params(params: T.any(::Stripe::Climate::OrderListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def list(params = {}, opts = {}); end

      # Retrieves the details of a Climate order object with the given ID.
      sig {
        params(order: String, params: T.any(::Stripe::Climate::OrderRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Order)
       }
      def retrieve(order, params = {}, opts = {}); end

      # Updates the specified order by setting the values of the parameters passed.
      sig {
        params(order: String, params: T.any(::Stripe::Climate::OrderUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Climate::Order)
       }
      def update(order, params = {}, opts = {}); end
    end
  end
end