# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PlanListParams < ::Stripe::RequestParams
    class Created < ::Stripe::RequestParams
      # Minimum value to filter by (exclusive)
      sig { returns(T.nilable(Integer)) }
      def gt; end
      sig { params(_gt: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def gt=(_gt); end
      # Minimum value to filter by (inclusive)
      sig { returns(T.nilable(Integer)) }
      def gte; end
      sig { params(_gte: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def gte=(_gte); end
      # Maximum value to filter by (exclusive)
      sig { returns(T.nilable(Integer)) }
      def lt; end
      sig { params(_lt: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def lt=(_lt); end
      # Maximum value to filter by (inclusive)
      sig { returns(T.nilable(Integer)) }
      def lte; end
      sig { params(_lte: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def lte=(_lte); end
      sig {
        params(gt: T.nilable(Integer), gte: T.nilable(Integer), lt: T.nilable(Integer), lte: T.nilable(Integer)).void
       }
      def initialize(gt: nil, gte: nil, lt: nil, lte: nil); end
    end
    # Only return plans that are active or inactive (e.g., pass `false` to list all inactive plans).
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # A filter on the list, based on the object `created` field. The value can be a string with an integer Unix timestamp, or it can be a dictionary with a number of different query options.
    sig { returns(T.nilable(T.any(PlanListParams::Created, Integer))) }
    def created; end
    sig {
      params(_created: T.nilable(T.any(PlanListParams::Created, Integer))).returns(T.nilable(T.any(PlanListParams::Created, Integer)))
     }
    def created=(_created); end
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
    # Only return plans for the given product.
    sig { returns(T.nilable(String)) }
    def product; end
    sig { params(_product: T.nilable(String)).returns(T.nilable(String)) }
    def product=(_product); end
    # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
    sig { returns(T.nilable(String)) }
    def starting_after; end
    sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
    def starting_after=(_starting_after); end
    sig {
      params(active: T.nilable(T::Boolean), created: T.nilable(T.any(PlanListParams::Created, Integer)), ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), product: T.nilable(String), starting_after: T.nilable(String)).void
     }
    def initialize(
      active: nil,
      created: nil,
      ending_before: nil,
      expand: nil,
      limit: nil,
      product: nil,
      starting_after: nil
    ); end
  end
end