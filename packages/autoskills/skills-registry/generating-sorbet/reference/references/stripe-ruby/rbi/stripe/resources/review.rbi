# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Reviews can be used to supplement automated fraud detection with human expertise.
  #
  # Learn more about [Radar](https://docs.stripe.com/radar) and reviewing payments
  # [here](https://docs.stripe.com/radar/reviews).
  class Review < APIResource
    class IpAddressLocation < ::Stripe::StripeObject
      # The city where the payment originated.
      sig { returns(T.nilable(String)) }
      def city; end
      # Two-letter ISO code representing the country where the payment originated.
      sig { returns(T.nilable(String)) }
      def country; end
      # The geographic latitude where the payment originated.
      sig { returns(T.nilable(Float)) }
      def latitude; end
      # The geographic longitude where the payment originated.
      sig { returns(T.nilable(Float)) }
      def longitude; end
      # The state/county/province/region where the payment originated.
      sig { returns(T.nilable(String)) }
      def region; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class Session < ::Stripe::StripeObject
      # The browser used in this browser session (e.g., `Chrome`).
      sig { returns(T.nilable(String)) }
      def browser; end
      # Information about the device used for the browser session (e.g., `Samsung SM-G930T`).
      sig { returns(T.nilable(String)) }
      def device; end
      # The platform for the browser session (e.g., `Macintosh`).
      sig { returns(T.nilable(String)) }
      def platform; end
      # The version for the browser session (e.g., `61.0.3163.100`).
      sig { returns(T.nilable(String)) }
      def version; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # The ZIP or postal code of the card used, if applicable.
    sig { returns(T.nilable(String)) }
    def billing_zip; end
    # The charge associated with this review.
    sig { returns(T.nilable(T.any(String, ::Stripe::Charge))) }
    def charge; end
    # The reason the review was closed, or null if it has not yet been closed. One of `approved`, `refunded`, `refunded_as_fraud`, `disputed`, `redacted`, `canceled`, `payment_never_settled`, or `acknowledged`.
    sig { returns(T.nilable(String)) }
    def closed_reason; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The IP address where the payment originated.
    sig { returns(T.nilable(String)) }
    def ip_address; end
    # Information related to the location of the payment. Note that this information is an approximation and attempts to locate the nearest population center - it should not be used to determine a specific address.
    sig { returns(T.nilable(IpAddressLocation)) }
    def ip_address_location; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # If `true`, the review needs action.
    sig { returns(T::Boolean) }
    def open; end
    # The reason the review was opened. One of `rule` or `manual`.
    sig { returns(String) }
    def opened_reason; end
    # The PaymentIntent ID associated with this review, if one exists.
    sig { returns(T.nilable(T.any(String, ::Stripe::PaymentIntent))) }
    def payment_intent; end
    # The reason the review is currently open or closed. One of `rule`, `manual`, `approved`, `refunded`, `refunded_as_fraud`, `disputed`, `redacted`, `canceled`, `payment_never_settled`, or `acknowledged`.
    sig { returns(String) }
    def reason; end
    # Information related to the browsing session of the user who initiated the payment.
    sig { returns(T.nilable(Session)) }
    def session; end
    # Approves a Review object, closing it and removing it from the list of reviews.
    sig {
      params(params: T.any(::Stripe::ReviewApproveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Review)
     }
    def approve(params = {}, opts = {}); end

    # Approves a Review object, closing it and removing it from the list of reviews.
    sig {
      params(review: String, params: T.any(::Stripe::ReviewApproveParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Review)
     }
    def self.approve(review, params = {}, opts = {}); end

    # Returns a list of Review objects that have open set to true. The objects are sorted in descending order by creation date, with the most recently created object appearing first.
    sig {
      params(params: T.any(::Stripe::ReviewListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end