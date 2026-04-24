# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class CouponService < StripeService
    # You can create coupons easily via the [coupon management](https://dashboard.stripe.com/coupons) page of the Stripe dashboard. Coupon creation is also accessible via the API if you need to create coupons on the fly.
    #
    # A coupon has either a percent_off or an amount_off and currency. If you set an amount_off, that amount will be subtracted from any invoice's subtotal. For example, an invoice with a subtotal of 100 will have a final total of 0 if a coupon with an amount_off of 200 is applied to it and an invoice with a subtotal of 300 will have a final total of 100 if a coupon with an amount_off of 200 is applied to it.
    sig {
      params(params: T.any(::Stripe::CouponCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Coupon)
     }
    def create(params = {}, opts = {}); end

    # You can delete coupons via the [coupon management](https://dashboard.stripe.com/coupons) page of the Stripe dashboard. However, deleting a coupon does not affect any customers who have already applied the coupon; it means that new customers can't redeem the coupon. You can also delete coupons via the API.
    sig {
      params(coupon: String, params: T.any(::Stripe::CouponDeleteParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Coupon)
     }
    def delete(coupon, params = {}, opts = {}); end

    # Returns a list of your coupons.
    sig {
      params(params: T.any(::Stripe::CouponListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def list(params = {}, opts = {}); end

    # Retrieves the coupon with the given ID.
    sig {
      params(coupon: String, params: T.any(::Stripe::CouponRetrieveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Coupon)
     }
    def retrieve(coupon, params = {}, opts = {}); end

    # Updates the metadata of a coupon. Other coupon details (currency, duration, amount_off) are, by design, not editable.
    sig {
      params(coupon: String, params: T.any(::Stripe::CouponUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Coupon)
     }
    def update(coupon, params = {}, opts = {}); end
  end
end