# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class WebhookEndpointCreateParams < ::Stripe::RequestParams
    # Events sent to this endpoint will be generated with this Stripe Version instead of your account's default Stripe Version.
    sig { returns(T.nilable(String)) }
    def api_version; end
    sig { params(_api_version: T.nilable(String)).returns(T.nilable(String)) }
    def api_version=(_api_version); end
    # Whether this endpoint should receive events from connected accounts (`true`), or from your account (`false`). Defaults to `false`.
    sig { returns(T.nilable(T::Boolean)) }
    def connect; end
    sig { params(_connect: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def connect=(_connect); end
    # An optional description of what the webhook is used for.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # The list of events to enable for this endpoint. You may specify `['*']` to enable all events, except those that require explicit selection.
    sig { returns(T::Array[String]) }
    def enabled_events; end
    sig { params(_enabled_events: T::Array[String]).returns(T::Array[String]) }
    def enabled_events=(_enabled_events); end
    # Specifies which fields in the response should be expanded.
    sig { returns(T.nilable(T::Array[String])) }
    def expand; end
    sig { params(_expand: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String])) }
    def expand=(_expand); end
    # Set of [key-value pairs](https://docs.stripe.com/api/metadata) that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    sig { returns(T.nilable(T.any(String, T::Hash[String, String]))) }
    def metadata; end
    sig {
      params(_metadata: T.nilable(T.any(String, T::Hash[String, String]))).returns(T.nilable(T.any(String, T::Hash[String, String])))
     }
    def metadata=(_metadata); end
    # The URL of the webhook endpoint.
    sig { returns(String) }
    def url; end
    sig { params(_url: String).returns(String) }
    def url=(_url); end
    sig {
      params(api_version: T.nilable(String), connect: T.nilable(T::Boolean), description: T.nilable(String), enabled_events: T::Array[String], expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), url: String).void
     }
    def initialize(
      api_version: nil,
      connect: nil,
      description: nil,
      enabled_events: nil,
      expand: nil,
      metadata: nil,
      url: nil
    ); end
  end
end