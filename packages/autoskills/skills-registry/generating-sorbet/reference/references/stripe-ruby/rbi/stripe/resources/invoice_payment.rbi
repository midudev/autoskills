# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  # Invoice Payments represent payments made against invoices. Invoice Payments can
  # be accessed in two ways:
  # 1. By expanding the `payments` field on the [Invoice](https://api.stripe.com#invoice) resource.
  # 2. By using the Invoice Payment retrieve and list endpoints.
  #
  # Invoice Payments include the mapping between payment objects, such as Payment Intent, and Invoices.
  # This resource and its endpoints allows you to easily track if a payment is associated with a specific invoice and
  # monitor the allocation details of the payments.
  class InvoicePayment < APIResource
    class Payment < ::Stripe::StripeObject
      # ID of the successful charge for this payment when `type` is `charge`.Note: charge is only surfaced if the charge object is not associated with a payment intent. If the charge object does have a payment intent, the Invoice Payment surfaces the payment intent instead.
      sig { returns(T.nilable(T.any(String, ::Stripe::Charge))) }
      def charge; end
      # ID of the PaymentIntent associated with this payment when `type` is `payment_intent`. Note: This property is only populated for invoices finalized on or after March 15th, 2019.
      sig { returns(T.nilable(T.any(String, ::Stripe::PaymentIntent))) }
      def payment_intent; end
      # ID of the PaymentRecord associated with this payment when `type` is `payment_record`.
      sig { returns(T.nilable(T.any(String, ::Stripe::PaymentRecord))) }
      def payment_record; end
      # Type of payment object associated with this invoice payment.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    class StatusTransitions < ::Stripe::StripeObject
      # The time that the payment was canceled.
      sig { returns(T.nilable(Integer)) }
      def canceled_at; end
      # The time that the payment succeeded.
      sig { returns(T.nilable(Integer)) }
      def paid_at; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # Amount that was actually paid for this invoice, in cents (or local equivalent). This field is null until the payment is `paid`. This amount can be less than the `amount_requested` if the PaymentIntent’s `amount_received` is not sufficient to pay all of the invoices that it is attached to.
    sig { returns(T.nilable(Integer)) }
    def amount_paid; end
    # Amount intended to be paid toward this invoice, in cents (or local equivalent)
    sig { returns(Integer) }
    def amount_requested; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # The invoice that was paid.
    sig { returns(T.any(String, ::Stripe::Invoice)) }
    def invoice; end
    # Stripe automatically creates a default InvoicePayment when the invoice is finalized, and keeps it synchronized with the invoice’s `amount_remaining`. The PaymentIntent associated with the default payment can’t be edited or canceled directly.
    sig { returns(T::Boolean) }
    def is_default; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # Attribute for field payment
    sig { returns(Payment) }
    def payment; end
    # The status of the payment, one of `open`, `paid`, or `canceled`.
    sig { returns(String) }
    def status; end
    # Attribute for field status_transitions
    sig { returns(StatusTransitions) }
    def status_transitions; end
    # When retrieving an invoice, there is an includable payments property containing the first handful of those items. There is also a URL where you can retrieve the full (paginated) list of payments.
    sig {
      params(params: T.any(::Stripe::InvoicePaymentListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end