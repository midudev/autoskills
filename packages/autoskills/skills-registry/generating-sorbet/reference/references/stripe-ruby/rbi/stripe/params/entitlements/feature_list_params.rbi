# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Entitlements
    class FeatureListParams < ::Stripe::RequestParams
      # If set, filter results to only include features with the given archive status.
      sig { returns(T.nilable(T::Boolean)) }
      def archived; end
      sig { params(_archived: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
      def archived=(_archived); end
      # A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
      sig { returns(T.nilable(String)) }
      def ending_before; end
      sig { params(_ending_before: T.nilable(String)).returns(T.nilable(String)) }
      def ending_before=(_ending_before); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
      sig { returns(T.nilable(Integer)) }
      def limit; end
      sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def limit=(_limit); end
      # If set, filter results to only include features with the given lookup_key.
      sig { returns(T.nilable(String)) }
      def lookup_key; end
      sig { params(_lookup_key: T.nilable(String)).returns(T.nilable(String)) }
      def lookup_key=(_lookup_key); end
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      sig {
        params(archived: T.nilable(T::Boolean), ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), lookup_key: T.nilable(String), starting_after: T.nilable(String)).void
       }
      def initialize(
        archived: nil,
        ending_before: nil,
        expand: nil,
        limit: nil,
        lookup_key: nil,
        starting_after: nil
      ); end
    end
  end
end