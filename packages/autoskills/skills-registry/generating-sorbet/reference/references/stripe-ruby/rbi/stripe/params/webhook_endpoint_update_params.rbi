# File generated from our OpenAPI spec
# frozen_string_literal: true

# typed: true
module Stripe
  class WebhookEndpointUpdateParams < ::Stripe::RequestParams
    # An optional description of what the webhook is used for.
    sig { returns(T.nilable(String)) }
    def description; end
    sig { params(_description: T.nilable(String)).returns(T.nilable(String)) }
    def description=(_description); end
    # Disable the webhook endpoint if set to true.
    sig { returns(T.nilable(T::Boolean)) }
    def disabled; end
    sig { params(_disabled: T.nilable(T::Boolean)).returns(T.nilable(T::Boolean)) }
    def disabled=(_disabled); end
    # The list of events to enable for this endpoint. You may specify `['*']` to enable all events, except those that require explicit selection.
    sig { returns(T.nilable(T::Array[String])) }
    def enabled_events; end
    sig {
      params(_enabled_events: T.nilable(T::Array[String])).returns(T.nilable(T::Array[String]))
     }
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
    sig { returns(T.nilable(String)) }
    def url; end
    sig { params(_url: T.nilable(String)).returns(T.nilable(String)) }
    def url=(_url); end
    sig {
      params(description: T.nilable(String), disabled: T.nilable(T::Boolean), enabled_events: T.nilable(T::Array[String]), expand: T.nilable(T::Array[String]), metadata: T.nilable(T.any(String, T::Hash[String, String])), url: T.nilable(String)).void
     }
    def initialize(
      description: nil,
      disabled: nil,
      enabled_events: nil,
      expand: nil,
      metadata: nil,
      url: nil
    ); end
  end
end