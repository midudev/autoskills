# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class PriceListParams < ::Stripe::RequestParams
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
    class Recurring < ::Stripe::RequestParams
      # Filter by billing frequency. Either `day`, `week`, `month` or `year`.
      sig { returns(T.nilable(String)) }
      def interval; end
      sig { params(_interval: T.nilable(String)).returns(T.nilable(String)) }
      def interval=(_interval); end
      # Filter by the price's meter.
      sig { returns(T.nilable(String)) }
      def meter; end
      sig { params(_meter: T.nilable(String)).returns(T.nilable(String)) }
      def meter=(_meter); end
      # Filter by the usage type for this price. Can be either `metered` or `licensed`.
      sig { returns(T.nilable(String)) }
      def usage_type; end
      sig { params(_usage_type: T.nilable(String)).returns(T.nilable(String)) }
      def usage_type=(_usage_type); end
      sig {
        params(interval: T.nilable(String), meter: T.nilable(String), usage_type: T.nilable(String)).void
       }
      def initialize(interval: nil, meter: nil, usage_type: nil); end
    end
    # Only return prices that are active or inactive (e.g., pass `false` to list all inactive prices).
    sig { returns(T.nilable(T::Boolean)) }
    def active; end
    sig { params(_active: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def active=(_active); end
    # A filter on the list, based on the object `created` field. The value can be a string with an integer Unix timestamp, or it can be a dictionary with a number of different query options.
    sig { returns(T.nilable(T.any(PriceListParams::Created, Integer))) }
    def created; end
    sig {
      params(_created: T.nilable(T.any(PriceListParams::Created, Integer))).returns(T.nilable(T.any(PriceListParams::Created, Integer)))
     }
    def created=(_created); end
    # Only return prices for the given currency.
    sig { returns(T.nilable(String)) }
    def currency; end
    sig { params(_currency: T.nilable(String)).returns(T.nilable(String)) }
    def currency=(_currency); end
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
    # Only return the price with these lookup_keys, if any exist. You can specify up to 10 lookup_keys.
    sig { returns(T.nilable(T::Array[String])) }
    def lookup_keys; end
    sig { params(_lookup_keys: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def lookup_keys=(_lookup_keys); end
    # Only return prices for the given product.
    sig { returns(T.nilable(String)) }
    def product; end
    sig { params(_product: T.nilable(String)).returns(T.nilable(String)) }
    def product=(_product); end
    # Only return prices with these recurring fields.
    sig { returns(T.nilable(PriceListParams::Recurring)) }
    def recurring; end
    sig {
      params(_recurring: T.nilable(PriceListParams::Recurring)).returns(T.nilable(PriceListParams::Recurring))
     }
    def recurring=(_recurring); end
    # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
    sig { returns(T.nilable(String)) }
    def starting_after; end
    sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
    def starting_after=(_starting_after); end
    # Only return prices of type `recurring` or `one_time`.
    sig { returns(T.nilable(String)) }
    def type; end
    sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
    def type=(_type); end
    sig {
      params(active: T.nilable(T::Boolean), created: T.nilable(T.any(PriceListParams::Created, Integer)), currency: T.nilable(String), ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), lookup_keys: T.nilable(T::Array[String]), product: T.nilable(String), recurring: T.nilable(PriceListParams::Recurring), starting_after: T.nilable(String), type: T.nilable(String)).void
     }
    def initialize(
      active: nil,
      created: nil,
      currency: nil,
      ending_before: nil,
      expand: nil,
      limit: nil,
      lookup_keys: nil,
      product: nil,
      recurring: nil,
      starting_after: nil,
      type: nil
    ); end
  end
end