# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Billing
    class MeterUpdateParams < ::Stripe::RequestParams
      # The meter’s name. Not visible to the customer.
      sig { returns(T.nilable(String)) }
      def display_name; end
      sig { params(_display_name: T.nilable(String)).returns(T.nilable(String)) }
      def display_name=(_display_name); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      sig { params(display_name: T.nilable(String), expand: T.nilable(T::Array[String])).void }
      def initialize(display_name: nil, expand: nil); end
    end
  end
end