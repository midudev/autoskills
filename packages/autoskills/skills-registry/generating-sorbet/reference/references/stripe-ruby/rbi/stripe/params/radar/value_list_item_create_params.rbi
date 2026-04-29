# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Radar
    class ValueListItemCreateParams < ::Stripe::RequestParams
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # The value of the item (whose type must match the type of the parent value list).
      sig { returns(String) }
      def value; end
      sig { params(_value: String).returns(String) }
      def value=(_value); end
      # The identifier of the value list which the created item will be added to.
      sig { returns(String) }
      def value_list; end
      sig { params(_value_list: String).returns(String) }
      def value_list=(_value_list); end
      sig { params(expand: T.nilable(T::Array[String]), value: String, value_list: String).void }
      def initialize(expand: nil, value: nil, value_list: nil); end
    end
  end
end