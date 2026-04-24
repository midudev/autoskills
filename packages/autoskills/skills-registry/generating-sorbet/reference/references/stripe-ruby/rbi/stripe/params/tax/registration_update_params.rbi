# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Tax
    class RegistrationUpdateParams < ::Stripe::RequestParams
      # Time at which the registration becomes active. It can be either `now` to indicate the current time, or a timestamp measured in seconds since the Unix epoch.
      sig { returns(T.nilable(T.any(String, Integer))) }
      def active_from; end
      sig {
        params(_active_from: T.nilable(T.any(String, Integer))).returns(T.nilable(T.any(String, Integer)))
       }
      def active_from=(_active_from); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # If set, the registration stops being active at this time. If not set, the registration will be active indefinitely. It can be either `now` to indicate the current time, or a timestamp measured in seconds since the Unix epoch.
      sig { returns(T.nilable(T.any(String, T.any(String, Integer)))) }
      def expires_at; end
      sig {
        params(_expires_at: T.nilable(T.any(String, T.any(String, Integer)))).returns(T.nilable(T.any(String, T.any(String, Integer))))
       }
      def expires_at=(_expires_at); end
      sig {
        params(active_from: T.nilable(T.any(String, Integer)), expand: T.nilable(T::Array[String]), expires_at: T.nilable(T.any(String, T.any(String, Integer)))).void
       }
      def initialize(active_from: nil, expand: nil, expires_at: nil); end
    end
  end
end