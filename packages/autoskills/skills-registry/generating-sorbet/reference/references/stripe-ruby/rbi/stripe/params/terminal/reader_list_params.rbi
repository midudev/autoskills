# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Terminal
    class ReaderListParams < ::Stripe::RequestParams
      # Filters readers by device type
      sig { returns(T.nilable(String)) }
      def device_type; end
      sig { params(_device_type: T.nilable(String)).returns(T.nilable(String)) }
      def device_type=(_device_type); end
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
      # A location ID to filter the response list to only readers at the specific location
      sig { returns(T.nilable(String)) }
      def location; end
      sig { params(_location: T.nilable(String)).returns(T.nilable(String)) }
      def location=(_location); end
      # Filters readers by serial number
      sig { returns(T.nilable(String)) }
      def serial_number; end
      sig { params(_serial_number: T.nilable(String)).returns(T.nilable(String)) }
      def serial_number=(_serial_number); end
      # A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list. For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
      sig { returns(T.nilable(String)) }
      def starting_after; end
      sig { params(_starting_after: T.nilable(String)).returns(T.nilable(String)) }
      def starting_after=(_starting_after); end
      # A status filter to filter readers to only offline or online readers
      sig { returns(T.nilable(String)) }
      def status; end
      sig { params(_status: T.nilable(String)).returns(T.nilable(String)) }
      def status=(_status); end
      sig {
        params(device_type: T.nilable(String), ending_before: T.nilable(String), expand: T.nilable(T::Array[String]), limit: T.nilable(Integer), location: T.nilable(String), serial_number: T.nilable(String), starting_after: T.nilable(String), status: T.nilable(String)).void
       }
      def initialize(
        device_type: nil,
        ending_before: nil,
        expand: nil,
        limit: nil,
        location: nil,
        serial_number: nil,
        starting_after: nil,
        status: nil
      ); end
    end
  end
end