# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class SetupIntentCancelParams < ::Stripe::RequestParams
    # Reason for canceling this SetupIntent. Possible values are: `abandoned`, `requested_by_customer`, or `duplicate`
    sig { returns(T.nilable(String)) }
    def cancellation_reason; end
    sig { params(_cancellation_reason: T.nilable(String)).returns(T.nilable(String)) }
    def cancellation_reason=(_cancellation_reason); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    sig { params(cancellation_reason: T.nilable(String), expand: T.nilable(T::Array[String])).void }
    def initialize(cancellation_reason: nil, expand: nil); end
  end
end