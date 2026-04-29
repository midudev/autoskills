# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # A discount represents the actual application of a [coupon](https://api.stripe.com#coupons) or [promotion code](https://api.stripe.com#promotion_codes).
  # It contains information about when the discount began, when it will end, and what it is applied to.
  #
  # Related guide: [Applying discounts to subscriptions](https://docs.stripe.com/billing/subscriptions/discounts)
  class Discount < StripeObject
    class Source < ::Stripe::StripeObject
      # The coupon that was redeemed to create this discount.
      sig { returns(T.nilable(T.any(String, ::Stripe::Coupon))) }
      def coupon; end
      # The source type of the discount.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The Checkout session that this coupon is applied to, if it is applied to a particular session in payment mode. Will not be present for subscription mode.
    sig { returns(T.nilable(String)) }
    def checkout_session; end
    # The ID of the customer associated with this discount.
    sig { returns(T.nilable(T.any(String, ::Stripe::Customer))) }
    def customer; end
    # The ID of the account representing the customer associated with this discount.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    # If the coupon has a duration of `repeating`, the date that this discount will end. If the coupon has a duration of `once` or `forever`, this attribute will be null.
    sig { returns(T.nilable(Integer)) }
    def end; end
    # The ID of the discount object. Discounts cannot be fetched by ID. Use `expand[]=discounts` in API calls to expand discount IDs in an array.
    sig { returns(String) }
    def id; end
    # The invoice that the discount's coupon was applied to, if it was applied directly to a particular invoice.
    sig { returns(T.nilable(String)) }
    def invoice; end
    # The invoice item `id` (or invoice line item `id` for invoice line items of type='subscription') that the discount's coupon was applied to, if it was applied directly to a particular invoice item or invoice line item.
    sig { returns(T.nilable(String)) }
    def invoice_item; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # The promotion code applied to create this discount.
    sig { returns(T.nilable(T.any(String, ::Stripe::PromotionCode))) }
    def promotion_code; end
    # Attribute for field source
    sig { returns(Source) }
    def source; end
    # Date that the coupon was applied.
    sig { returns(Integer) }
    def start; end
    # The subscription that this coupon is applied to, if it is applied to a particular subscription.
    sig { returns(T.nilable(String)) }
    def subscription; end
    # The subscription item that this coupon is applied to, if it is applied to a particular subscription item.
    sig { returns(T.nilable(String)) }
    def subscription_item; end
    # Always true for a deleted object
    sig { returns(T.nilable(T::Boolean)) }
    def deleted; end
  end
end