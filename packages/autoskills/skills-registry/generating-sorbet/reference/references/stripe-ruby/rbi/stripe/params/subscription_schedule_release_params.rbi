# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SubscriptionScheduleReleaseParams < ::Stripe::RequestParams
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Keep any cancellation on the subscription that the schedule has set
    sig { returns(T.nilable(T::Boolean)) }
    def preserve_cancel_date; end
    sig { params(_preserve_cancel_date: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def preserve_cancel_date=(_preserve_cancel_date); end
    sig {
      params(expand: T.nilable(T::Array[String]), preserve_cancel_date: T.nilable(T::Boolean)).void
     }
    def initialize(expand: nil, preserve_cancel_date: nil); end
  end
end