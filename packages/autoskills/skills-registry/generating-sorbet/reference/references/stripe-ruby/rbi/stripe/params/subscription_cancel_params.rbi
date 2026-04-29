# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionCancelParams < ::Stripe::RequestParams
    class CancellationDetails < ::Stripe::RequestParams
      # Additional comments about why the user canceled the subscription, if the subscription was canceled explicitly by the user.
      sig { returns(T.nilable(String)) }
      def comment; end
      sig { params(_comment: T.nilable(String)).returns(T.nilable(String)) }
      def comment=(_comment); end
      # The customer submitted reason for why they canceled, if the subscription was canceled explicitly by the user.
      sig { returns(T.nilable(T.any(String, String))) }
      def feedback; end
      sig {
        params(_feedback: T.nilable(T.any(String, String))).returns(T.nilable(T.any(String, String)))
       }
      def feedback=(_feedback); end
      sig { params(comment: T.nilable(String), feedback: T.nilable(T.any(String, String))).void }
      def initialize(comment: nil, feedback: nil); end
    end
    # Details about why this subscription was cancelled
    sig { returns(T.nilable(SubscriptionCancelParams::CancellationDetails)) }
    def cancellation_details; end
    sig {
      params(_cancellation_details: T.nilable(SubscriptionCancelParams::CancellationDetails)).returns(T.nilable(SubscriptionCancelParams::CancellationDetails))
     }
    def cancellation_details=(_cancellation_details); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Will generate a final invoice that invoices for any un-invoiced metered usage and new/pending proration invoice items. Defaults to `false`.
    sig { returns(T.nilable(T::Boolean)) }
    def invoice_now; end
    sig { params(_invoice_now: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def invoice_now=(_invoice_now); end
    # Will generate a proration invoice item that credits remaining unused time until the subscription period end. Defaults to `false`.
    sig { returns(T.nilable(T::Boolean)) }
    def prorate; end
    sig { params(_prorate: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def prorate=(_prorate); end
    sig {
      params(cancellation_details: T.nilable(SubscriptionCancelParams::CancellationDetails), expand: T.nilable(T::Array[String]), invoice_now: T.nilable(T::Boolean), prorate: T.nilable(T::Boolean)).void
     }
    def initialize(cancellation_details: nil, expand: nil, invoice_now: nil, prorate: nil); end
  end
end