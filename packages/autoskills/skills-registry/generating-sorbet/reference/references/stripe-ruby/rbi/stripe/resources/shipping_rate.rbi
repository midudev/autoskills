# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Shipping rates describe the price of shipping presented to your customers and
  # applied to a purchase. For more information, see [Charge for shipping](https://docs.stripe.com/payments/during-payment/charge-shipping).
  class ShippingRate < APIResource
    class DeliveryEstimate < ::Stripe::StripeObject
      class Maximum < ::Stripe::StripeObject
        # A unit of time.
        sig { returns(String) }
        def unit; end
        # Must be greater than 0.
        sig { returns(Integer) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class Minimum < ::Stripe::StripeObject
        # A unit of time.
        sig { returns(String) }
        def unit; end
        # Must be greater than 0.
        sig { returns(Integer) }
        def value; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # The upper bound of the estimated range. If empty, represents no upper bound i.e., infinite.
      sig { returns(T.nilable(Maximum)) }
      def maximum; end
      # The lower bound of the estimated range. If empty, represents no lower bound.
      sig { returns(T.nilable(Minimum)) }
      def minimum; end
      def self.inner_class_types
        @inner_class_types = {maximum: Maximum, minimum: Minimum}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class FixedAmount < ::Stripe::StripeObject
      class CurrencyOptions < ::Stripe::StripeObject
        # A non-negative integer in cents representing how much to charge.
        sig { returns(Integer) }
        def amount; end
        # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
        sig { returns(String) }
        def tax_behavior; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # A non-negative integer in cents representing how much to charge.
      sig { returns(Integer) }
      def amount; end
      # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(String) }
      def currency; end
      # Shipping rates defined in each available currency option. Each key must be a three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html) and a [supported currency](https://stripe.com/docs/currencies).
      sig { returns(T.nilable(T::Hash[String, CurrencyOptions])) }
      def currency_options; end
      def self.inner_class_types
        @inner_class_types = {currency_options: CurrencyOptions}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Whether the shipping rate can be used for new purchases. Defaults to `true`.
    sig { returns(T::Boolean) }
    def active; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # The estimated range for how long shipping will take, meant to be displayable to the customer. This will appear on CheckoutSessions.
    sig { returns(T.nilable(DeliveryEstimate)) }
    def delivery_estimate; end
    # The name of the shipping rate, meant to be displayable to the customer. This will appear on CheckoutSessions.
    sig { returns(T.nilable(String)) }
    def display_name; end
    # Attribute for field fixed_amount
    sig { returns(T.nilable(FixedAmount)) }
    def fixed_amount; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    sig { returns(T::Hash[String, String]) }
    def metadata; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Specifies whether the rate is considered inclusive of taxes or exclusive of taxes. One of `inclusive`, `exclusive`, or `unspecified`.
    sig { returns(T.nilable(String)) }
    def tax_behavior; end
    # A [tax code](https://docs.stripe.com/tax/tax-categories) ID. The Shipping tax code is `txcd_92010001`.
    sig { returns(T.nilable(T.any(String, ::Stripe::TaxCode))) }
    def tax_code; end
    # The type of calculation to use on the shipping rate.
    sig { returns(String) }
    def type; end
    # Creates a new shipping rate object.
    sig {
      params(params: T.any(::Stripe::ShippingRateCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ShippingRate)
     }
    def self.create(params = {}, opts = {}); end

    # Returns a list of your shipping rates.
    sig {
      params(params: T.any(::Stripe::ShippingRateListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end

    # Updates an existing shipping rate object.
    sig {
      params(shipping_rate_token: String, params: T.any(::Stripe::ShippingRateUpdateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ShippingRate)
     }
    def self.update(shipping_rate_token, params = {}, opts = {}); end
  end
end