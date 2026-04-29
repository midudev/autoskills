# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Issuing
    class CardListParams < ::Stripe::RequestParams
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
      # Only return cards belonging to the Cardholder with the provided ID.
      sig { returns(T.nilable(String)) }
      def cardholder; end
      sig { params(_cardholder: T.nilable(String)).returns(T.nilable(String)) }
      def cardholder=(_cardholder); end
      # Only return cards that were issued during the given date interval.
      sig { returns(T.nilable(T.any(Issuing::CardListParams::Created, Integer))) }
      def created; end
      sig {
        params(_created: T.nilable(T.any(Issuing::CardListParams::Created, Integer))).returns(T.nilable(T.any(Issuing::CardListParams::Created, Integer)))
       }
      def created=(_created); end
      # A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, starting with `obj_bar`, your subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
      sig { returns(T.nilable(String)) }
      def ending_before; end
      sig { params(_ending_before: T.nilable(String)).returns(T.nilable(String)) }
      def ending_before=(_ending_before); end
      # Only return cards that have the given expiration month.
      sig { returns(T.nilable(Integer)) }
      def exp_month; end
      sig { params(_exp_month: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def exp_month=(_exp_month); end
      # Only return cards that have the given expiration year.
      sig { returns(T.nilable(Integer)) }
      def exp_year; end
      sig { params(_exp_year: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def exp_year=(_exp_year); end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Only return cards that have the given last four digits.
      sig { returns(T.nilable(String)) }
      def last4; end
      sig { params(_last4: T.nilable(String)).returns(T.nilable(String)) }
      def last4=(_last4); end
      # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
      sig { returns(T.nilable(Integer)) }
      def limit; end
      sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
      def limit=(_limit); end
      # Attribute for param field personalization_design
      sig { returns(T.nilable(String)) }
      def personalization_design; end
      sig { params(_personalization_design: T.nilable(String)).returns(T.nilable(String)) }
      def personalization_design=(_personalization_design); end
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      # Only return cards that have the given status. One of `active`, `inactive`, or `canceled`.
      sig { returns(T.nilable(String)) }
      def status; end
      sig { params(_status: T.nilable(String)).returns(T.nilable(String)) }
      def status=(_status); end
      # Only return cards that have the given type. One of `virtual` or `physical`.
      sig { returns(T.nilable(String)) }
      def type; end
      sig { params(_type: T.nilable(String)).returns(T.nilable(String)) }
      def type=(_type); end
      sig {
        params(cardholder: T.nilable(String), created: T.nilable(T.any(Issuing::CardListParams::Created, Integer)), ending_before: T.nilable(String), exp_month: T.nilable(Integer), exp_year: T.nilable(Integer), expand: T.nilable(T::Array[String]), last4: T.nilable(String), limit: T.nilable(Integer), personalization_design: T.nilable(String), starting_after: T.nilable(String), status: T.nilable(String), type: T.nilable(String)).void
       }
      def initialize(
        cardholder: nil,
        created: nil,
        ending_before: nil,
        exp_month: nil,
        exp_year: nil,
        expand: nil,
        last4: nil,
        limit: nil,
        personalization_design: nil,
        starting_after: nil,
        status: nil,
        type: nil
      ); end
    end
  end
end