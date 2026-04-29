# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class InvoiceItemListParams < ::Stripe::RequestParams
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
    # Only return invoice items that were created during the given date interval.
    sig { returns(T.nilable(T.any(InvoiceItemListParams::Created, Integer))) }
    def created; end
    sig {
      params(_created: T.nilable(T.any(InvoiceItemListParams::Created, Integer))).returns(T.nilable(T.any(InvoiceItemListParams::Created, Integer)))
     }
    def created=(_created); end
    # The identifier of the customer whose invoice items to return. If none is provided, returns all invoice items.
    sig { returns(T.nilable(String)) }
    def customer; end
    sig { params(_customer: T.nilable(String)).returns(T.nilable(String)) }
    def customer=(_customer); end
    # The identifier of the account representing the customer whose invoice items to return. If none is provided, returns all invoice items.
    sig { returns(T.nilable(String)) }
    def customer_account; end
    sig { params(_customer_account: T.nilable(String)).returns(T.nilable(String)) }
    def customer_account=(_customer_account); end
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
    # Only return invoice items belonging to this invoice. If none is provided, all invoice items will be returned. If specifying an invoice, no customer identifier is needed.
    sig { returns(T.nilable(String)) }
    def invoice; end
    sig { params(_invoice: T.nilable(String)).returns(T.nilable(String)) }
    def invoice=(_invoice); end
    # A limit on the number of objects to be returned. Limit can range between 1 and 100, and the default is 10.
    sig { returns(T.nilable(Integer)) }
    def limit; end
    sig { params(_limit: T.nilable(Integer)).returns(T.nilable(Integer)) }
    def limit=(_limit); end
    # Set to `true` to only show pending invoice items, which are not yet attached to any invoices. Set to `false` to only show invoice items already attached to invoices. If unspecified, no filter is applied.
    sig { returns(T.nilable(T::Boolean)) }
    def pending; end
    sig { params(_pending: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def pending=(_pending); end
    # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
    sig { returns(T.nilable(String)) }
    def starting_after; end
    sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
    def starting_after=(_starting_after); end
    sig {
      params(created: T.nilable(T.any(InvoiceItemListParams::Created, Integer)), customer: T.nilable(String), customer_account: T.nilable(String), ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), invoice: T.nilable(String), limit: T.nilable(Integer), pending: T.nilable(T::Boolean), starting_after: T.nilable(String)).void
     }
    def initialize(
      created: nil,
      customer: nil,
      customer_account: nil,
      ending_before: nil,
      expand: nil,
      invoice: nil,
      limit: nil,
      pending: nil,
      starting_after: nil
    ); end
  end
end