# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Radar
    class ValueListCreateParams < ::Stripe::RequestParams
      # The name of the value list for use in rules.
      sig { returns(String) }
      def alias; end
      sig { params(_alias: String).returns(String) }
      def alias=(_alias); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Type of the items in the value list. One of `card_fingerprint`, `card_bin`, `email`, `ip_address`, `country`, `string`, `case_sensitive_string`, `customer_id`, `sepa_debit_fingerprint`, or `us_bank_account_fingerprint`. Use `string` if the item type is unknown or mixed.
      sig { returns(T.nilable(String)) }
      def item_type; end
      sig { params(_item_type: T.nilable(String)).returns(T.nilable(String)) }
      def item_type=(_item_type); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The human-readable name of the value list.
      sig { returns(String) }
      def name; end
      sig { params(_name: String).returns(String) }
      def name=(_name); end
      sig {
        params(alias_: String, expand: T.nilable(T::Array[String]), item_type: T.nilable(String), metadata: T.nilable(T::Hash[String, String]), name: String).void
       }
      def initialize(alias_: nil, expand: nil, item_type: nil, metadata: nil, name: nil); end
    end
  end
end