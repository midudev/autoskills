# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionScheduleCancelParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # If the subscription schedule is `active`, indicates if a final invoice will be generated that contains any un-invoiced metered usage and new/pending proration invoice items. Defaults to `true`.
    sig { returns(T.nilable(T::Boolean)) }
    def invoice_now; end
    sig { params(_invoice_now: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def invoice_now=(_invoice_now); end
    # If the subscription schedule is `active`, indicates if the cancellation should be prorated. Defaults to `true`.
    sig { returns(T.nilable(T::Boolean)) }
    def prorate; end
    sig { params(_prorate: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def prorate=(_prorate); end
    sig {
      params(expand: T.nilable(T::Array[String]), invoice_now: T.nilable(T::Boolean), prorate: T.nilable(T::Boolean)).void
     }
    def initialize(expand: nil, invoice_now: nil, prorate: nil); end
  end
end