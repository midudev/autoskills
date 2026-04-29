# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Forwarding
    class RequestCreateParams < ::Stripe::RequestParams
      class Request < ::Stripe::RequestParams
        class Header < ::Stripe::RequestParams
          # The header name.
          sig { returns(String) }
          def name; end
          sig { params(_name: String).returns(String) }
          def name=(_name); end
          # The header value.
          sig { returns(String) }
          def value; end
          sig { params(_value: String).returns(String) }
          def value=(_value); end
          sig { params(name: String, value: String).void }
          def initialize(name: nil, value: nil); end
        end
        # The body payload to send to the destination endpoint.
        sig { returns(T.nilable(String)) }
        def body; end
        sig { params(_body: T.nilable(String)).returns(T.nilable(String)) }
        def body=(_body); end
        # The headers to include in the forwarded request. Can be omitted if no additional headers (excluding Stripe-generated ones such as the Content-Type header) should be included.
        sig { returns(T.nilable(T::Array[Forwarding::RequestCreateParams::Request::Header])) }
        def headers; end
        sig {
          params(_headers: T.nilable(T::Array[Forwarding::RequestCreateParams::Request::Header])).returns(T.nilable(T::Array[Forwarding::RequestCreateParams::Request::Header]))
         }
        def headers=(_headers); end
        sig {
          params(body: T.nilable(String), headers: T.nilable(T::Array[Forwarding::RequestCreateParams::Request::Header])).void
         }
        def initialize(body: nil, headers: nil); end
      end
      # Specifies which fields in the response should be expanded.
      sig { returns(T.nilable(T::Array[String])) }
      def expand; end
      sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
      def expand=(_expand); end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      sig {
        params(_metadata: T.nilable(T::Hash[String, String])).returns(T.nilable(T::Hash[String, String]))
       }
      def metadata=(_metadata); end
      # The PaymentMethod to insert into the forwarded request. Forwarding previously consumed PaymentMethods is allowed.
      sig { returns(String) }
      def payment_method; end
      sig { params(_payment_method: String).returns(String) }
      def payment_method=(_payment_method); end
      # The field kinds to be replaced in the forwarded request.
      sig { returns(T::Array[String]) }
      def replacements; end
      sig { params(_replacements: T::Array[String]).returns(T::Array[String]) }
      def replacements=(_replacements); end
      # The request body and headers to be sent to the destination endpoint.
      sig { returns(Forwarding::RequestCreateParams::Request) }
      def request; end
      sig {
        params(_request: Forwarding::RequestCreateParams::Request).returns(Forwarding::RequestCreateParams::Request)
       }
      def request=(_request); end
      # The destination URL for the forwarded request. Must be supported by the config.
      sig { returns(String) }
      def url; end
      sig { params(_url: String).returns(String) }
      def url=(_url); end
      sig {
        params(expand: T.nilable(T::Array[String]), metadata: T.nilable(T::Hash[String, String]), payment_method: String, replacements: T::Array[String], request: Forwarding::RequestCreateParams::Request, url: String).void
       }
      def initialize(
        expand: nil,
        metadata: nil,
        payment_method: nil,
        replacements: nil,
        request: nil,
        url: nil
      ); end
    end
  end
end