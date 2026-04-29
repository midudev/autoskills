# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  module Forwarding
    # Instructs Stripe to make a request on your behalf using the destination URL. The destination URL
    # is activated by Stripe at the time of onboarding. Stripe verifies requests with your credentials
    # provided during onboarding, and injects card details from the payment_method into the request.
    #
    # Stripe redacts all sensitive fields and headers, including authentication credentials and card numbers,
    # before storing the request and response data in the forwarding Request object, which are subject to a
    # 30-day retention period.
    #
    # You can provide a Stripe idempotency key to make sure that requests with the same key result in only one
    # outbound request. The Stripe idempotency key provided should be unique and different from any idempotency
    # keys provided on the underlying third-party request.
    #
    # Forwarding Requests are synchronous requests that return a response or time out according to
    # Stripe's limits.
    #
    # Related guide: [Forward card details to third-party API endpoints](https://docs.stripe.com/payments/forwarding).
    class Request < APIResource
      class RequestContext < ::Stripe::StripeObject
        # The time it took in milliseconds for the destination endpoint to respond.
        sig { returns(Integer) }
        def destination_duration; end
        # The IP address of the destination.
        sig { returns(String) }
        def destination_ip_address; end
        def self.inner_class_types
          @inner_class_types = {}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class RequestDetails < ::Stripe::StripeObject
        class Header < ::Stripe::StripeObject
          # The header name.
          sig { returns(String) }
          def name; end
          # The header value.
          sig { returns(String) }
          def value; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The body payload to send to the destination endpoint.
        sig { returns(String) }
        def body; end
        # The headers to include in the forwarded request. Can be omitted if no additional headers (excluding Stripe-generated ones such as the Content-Type header) should be included.
        sig { returns(T::Array[Header]) }
        def headers; end
        # The HTTP method used to call the destination endpoint.
        sig { returns(String) }
        def http_method; end
        def self.inner_class_types
          @inner_class_types = {headers: Header}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      class ResponseDetails < ::Stripe::StripeObject
        class Header < ::Stripe::StripeObject
          # The header name.
          sig { returns(String) }
          def name; end
          # The header value.
          sig { returns(String) }
          def value; end
          def self.inner_class_types
            @inner_class_types = {}
          end
          def self.field_remappings
            @field_remappings = {}
          end
        end
        # The response body from the destination endpoint to Stripe.
        sig { returns(String) }
        def body; end
        # HTTP headers that the destination endpoint returned.
        sig { returns(T::Array[Header]) }
        def headers; end
        # The HTTP status code that the destination endpoint returned.
        sig { returns(Integer) }
        def status; end
        def self.inner_class_types
          @inner_class_types = {headers: Header}
        end
        def self.field_remappings
          @field_remappings = {}
        end
      end
      # Time at which the object was created. Measured in seconds since the Unix epoch.
      sig { returns(Integer) }
      def created; end
      # Unique identifier for the object.
      sig { returns(String) }
      def id; end
      # Has the value `true` if the object exists in live mode or the value `false` if the object exists in test mode.
      sig { returns(T::Boolean) }
      def livemode; end
      # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
      sig { returns(T.nilable(T::Hash[String, String])) }
      def metadata; end
      # String representing the object's type. Objects of the same type share the same value.
      sig { returns(String) }
      def object; end
      # The PaymentMethod to insert into the forwarded request. Forwarding previously consumed PaymentMethods is allowed.
      sig { returns(String) }
      def payment_method; end
      # The field kinds to be replaced in the forwarded request.
      sig { returns(T::Array[String]) }
      def replacements; end
      # Context about the request from Stripe's servers to the destination endpoint.
      sig { returns(T.nilable(RequestContext)) }
      def request_context; end
      # The request that was sent to the destination endpoint. We redact any sensitive fields.
      sig { returns(T.nilable(RequestDetails)) }
      def request_details; end
      # The response that the destination endpoint returned to us. We redact any sensitive fields.
      sig { returns(T.nilable(ResponseDetails)) }
      def response_details; end
      # The destination URL for the forwarded request. Must be supported by the config.
      sig { returns(T.nilable(String)) }
      def url; end
      # Creates a ForwardingRequest object.
      sig {
        params(params: T.any(::Stripe::Forwarding::RequestCreateParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::Forwarding::Request)
       }
      def self.create(params = {}, opts = {}); end

      # Lists all ForwardingRequest objects.
      sig {
        params(params: T.any(::Stripe::Forwarding::RequestListParams, T::Hash[T.untyped, T.untyped]), opts: T.untyped).returns(::Stripe::ListObject)
       }
      def self.list(params = {}, opts = {}); end
    end
  end
end