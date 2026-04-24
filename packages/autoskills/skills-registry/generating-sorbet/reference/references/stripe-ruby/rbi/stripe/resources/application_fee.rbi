# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class ApplicationFee < APIResource
    class FeeSource < ::Stripe::StripeObject
      # Charge ID that created this application fee.
      sig { returns(T.nilable(String)) }
      def charge; end
      # Payout ID that created this application fee.
      sig { returns(T.nilable(String)) }
      def payout; end
      # Type of object that created the application fee.
      sig { returns(String) }
      def type; end
      def self.inner_class_types
        @inner_class_types = {}
      end
      def self.field_remappings
        @field_remappings = {}
      end
    end
    # ID of the Stripe account this fee was taken from.
    sig { returns(T.any(String, ::Stripe::Account)) }
    def account; end
    # Amount earned, in cents (or local equivalent).
    sig { returns(Integer) }
    def amount; end
    # Amount in cents (or local equivalent) refunded (can be less than the amount attribute on the fee if a partial refund was issued)
    sig { returns(Integer) }
    def amount_refunded; end
    # ID of the Connect application that earned the fee.
    sig { returns(T.any(String, ::Stripe::Application)) }
    def application; end
    # Balance transaction that describes the impact of this collected application fee on your account balance (not including refunds).
    sig { returns(T.nilable(T.any(String, ::Stripe::BalanceTransaction))) }
    def balance_transaction; end
    # ID of the charge that the application fee was taken from.
    sig { returns(T.any(String, ::Stripe::Charge)) }
    def charge; end
    # Time at which the object was created. Measured in seconds since the Unix epoch.
    sig { returns(Integer) }
    def created; end
    # Three-letter [ISO currency code](https://www.iso.org/iso-4217-currency-codes.html), in lowercase. Must be a [supported currency](https://stripe.com/docs/currencies).
    sig { returns(String) }
    def currency; end
    # Polymorphic source of the application fee. Includes the ID of the object the application fee was created from.
    sig { returns(T.nilable(FeeSource)) }
    def fee_source; end
    # Unique identifier for the object.
    sig { returns(String) }
    def id; end
    # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
    sig { returns(T::Boolean) }
    def livemode; end
    # String representing the object's type. Objects of the same type share the same value.
    sig { returns(String) }
    def object; end
    # ID of the corresponding charge on the platform account, if this fee was the result of a charge using the `destination` parameter.
    sig { returns(T.nilable(T.any(String, ::Stripe::Charge))) }
    def originating_transaction; end
    # Whether the fee has been fully refunded. If the fee is only partially refunded, this attribute will still be false.
    sig { returns(T::Boolean) }
    def refunded; end
    # A list of refunds that have been applied to the fee.
    sig { returns(::Stripe::ListObject) }
    def refunds; end
    # Returns a list of application fees you've previously collected. The application fees are returned in sorted order, with the most recent fees appearing first.
    sig {
      params(params: T.any(::Stripe::ApplicationFeeListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
     }
    def self.list(params = {}, opts = {}); end
  end
end