# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class RefundService < StripeService
    # Cancels a refund with a status of requires_action.
    #
    # You can't cancel refunds in other states. Only refunds for payment methods that require customer action can enter the requires_action state.
    sig {
      params(refund: String, params: T.any(::Stripe::RefundCancelParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Refund)
     }
    def cancel(refund, params = {}, opts = {}); end

    # When you create a new refund, you must specify a Charge or a PaymentIntent object on which to create it.
    #
    # Creating a new refund will refund a charge that has previously been created but not yet refunded.
    # Funds will be refunded to the credit or debit card that was originally charged.
    #
    # You can optionally refund only part of a charge.
    # You can do so multiple times, until the entire charge has been refunded.
    #
    # Once entirely refunded, a charge can't be refunded again.
    # This method will raise an error when called on an already-refunded charge,
    # or when trying to refund more money than is left on a charge.
    sig {
      params(params: T.any(::Stripe::RefundCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Refund)
     }
    def create(params = {}, opts = {}); end

    # Returns a list of all refunds you created. We return the refunds in sorted order, with the most recent refunds appearing first. The 10 most recent refunds are always available by default on the Charge object.
    sig {
      params(params: T.any(::Stripe::RefundListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the details of an existing refund.
    sig {
      params(refund: String, params: T.any(::Stripe::RefundRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Refund)
     }
    def retrieve(refund, params = {}, opts = {}); end

    # Updates the refund that you specify by setting the values of the passed parameters. Any parameters that you don't provide remain unchanged.
    #
    # This request only accepts metadata as an argument.
    sig {
      params(refund: String, params: T.any(::Stripe::RefundUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Refund)
     }
    def update(refund, params = {}, opts = {}); end
  end
end